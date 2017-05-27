#import "WeChat/ContactInfoViewController.h"
#import "WeChat/SendVerifyMsgViewController.h"
#import "WeChat/BaseMsgContentViewController.h"
#import "WeChat/RoomContentLogicController.h"
#import "WeChat/ChatRoomInfoViewController.h"
#import "WeChat/RoomContactSelectViewController.h"
#import "SaulWeChatAddFriend.h"
#import "WeChat/MMTabBarController.h"


%hook MMTabBarController

- (void)viewDidLoad
{
%orig;

    UISwitch *switch1 = [[UISwitch alloc]init];
    switch1.frame = CGRectMake(100, 20, 0, 0);
    [switch1 setOn:YES];
    [SaulWeChatAddFriend sharedInstance].isAddFriend = YES;
    [switch1 addTarget:self action:@selector(switchIsChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:switch1];

}

%new
-(void)switchIsChanged:(UISwitch *)swith
{
    if ([swith isOn]){
NSLog(@"The switch is on.");
[SaulWeChatAddFriend sharedInstance].isAddFriend = YES;
    } else {
NSLog(@"The switch is off.");
[SaulWeChatAddFriend sharedInstance].isAddFriend = NO;
    }
}

%end


%hook RoomContactSelectViewController // 用户列表

- (id)getMemberList
{
    id result = %orig;

    NSLog(@"getMemberList is\n%@",result);
    NSLog(@"array - getMemberList is\n%@",[NSArray arrayWithObject:result]);

    return result;
}


- (void)viewWillAppear:(_Bool)arg1 {

%orig;

if (![SaulWeChatAddFriend sharedInstance].isAddFriend) {
return;
}

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)),
    dispatch_get_main_queue(), ^{

        static NSInteger row = 0;
        for(UIView *view in self.view.subviews) {
            if([view isKindOfClass:[UITableView class]]) {

                if (row >= [self tableView:view numberOfRowsInSection:0]) {
                    row = 0;
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    return;
                }

                NSIndexPath * indexPatch = [NSIndexPath indexPathForRow:row inSection:0];
                [self tableView:view didSelectRowAtIndexPath:indexPatch];
                row++;
            }
        }

    });
}

%end



%hook ChatRoomInfoViewController // 聊天信息

- (void)viewDidLoad {

%orig;
if (![SaulWeChatAddFriend sharedInstance].isAddFriend) {
return;
}

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)),
    dispatch_get_main_queue(), ^{

        [self showMoreMemberEx];

    });
}

%end

%hook RoomContentLogicController
- (void)viewDidLoad
{
%orig;
    if (![SaulWeChatAddFriend sharedInstance].isAddFriend) {
        return;
    }

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)),
    dispatch_get_main_queue(), ^{
        [self OpenDetailInfo];

    });
}

%end

%hook BaseMsgContentViewController

- (void)viewWillAppear:(_Bool)arg1 {

%orig;
if (![SaulWeChatAddFriend sharedInstance].isAddFriend) {
return;
}

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)),
    dispatch_get_main_queue(), ^{

        [self openChatInfo:[self GetContact]];

    });
}

%end



%hook ContactInfoViewController

- (void)viewWillAppear:(_Bool)arg1 {

%orig;
if (![SaulWeChatAddFriend sharedInstance].isAddFriend) {
return;
}

    static BOOL isSend = YES;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)),
    dispatch_get_main_queue(), ^{
        if ([self isInMyContactList]) {
            [self.navigationController popViewControllerAnimated:YES];
            isSend = YES;
        } else {
            if (isSend) {
                [self onSendVerifyMsg];
                isSend = NO;
            } else {
                [self.navigationController popViewControllerAnimated:YES];
                isSend = YES;
            }
        }
    });
}

%end

%hook SendVerifyMsgViewController

- (void)viewDidLoad {

%orig;
if (![SaulWeChatAddFriend sharedInstance].isAddFriend) {
return;
}

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)),
    dispatch_get_main_queue(), ^{

        [self onSendVerifyMsg];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)),
        dispatch_get_main_queue(), ^{
            [self onReturn];

        });
    });
}

%end


%hook NSDictionary

+ (id)dictionaryWithContentsOfFile:(NSString *)path {

    id result = %orig;

    NSLog(@"dic content is\n%@",result);

    return result;
}

%end

