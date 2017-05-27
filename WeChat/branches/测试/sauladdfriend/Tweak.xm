#import "SaulWeChatAddFriend.h"
#import "WeChat/SayHelloViewController.h"
#import "WeChat/SayHelloDataLogic.h"
#import "WeChat/CBaseContactInfoAssist.h"
#import "WeChat/MMMainTableView.h"

#import "WeChat/ContactInfoViewController.h"
#import "WeChat/MMTabBarController.h"

%hook ContactsViewController
- (void)viewWillAppear:(_Bool)arg1 {
%orig;

    if (![SaulWeChatAddFriend sharedInstance].isAddFriend) {
        return;
    }

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        Ivar mDelegateVar = class_getInstanceVariable(objc_getClass("ContactsViewController"), "m_tableView");
        MMMainTableView * mDelegate = object_getIvar(self, mDelegateVar);

        [self tableView:mDelegate didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];

    });

}

%end

%hook ContactInfoViewController
- (void)viewDidLoad
{
%orig;
    if (![SaulWeChatAddFriend sharedInstance].isAddFriend) {
        return;
    }

    SaulWeChatAddFriend *addFriend = [SaulWeChatAddFriend sharedInstance];
    Ivar mDelegateVar = class_getInstanceVariable(objc_getClass("ContactInfoViewController"), "m_oContactInfoAssist");
    id mDelegate = object_getIvar(self, mDelegateVar);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)),
    dispatch_get_main_queue(), ^{
        if ([self isInMyContactList]) {
            [self.navigationController popViewControllerAnimated:YES];
    } else {
        [addFriend doAddFriendAction:mDelegate];
    }
    });
}

- (void)reloadContactAssist
{
%orig;
    if (![SaulWeChatAddFriend sharedInstance].isAddFriend) {
        return;
    }
    SaulWeChatAddFriend *addFriend = [SaulWeChatAddFriend sharedInstance];
    if ([self isInMyContactList] && addFriend.isAddFriendSent) {
        [self.navigationController popViewControllerAnimated:YES];
        addFriend.isAddFriendSent = NO;
    }
}

%end

%hook SayHelloViewController
- (void)willAppear
{
%orig;

    if (![SaulWeChatAddFriend sharedInstance].isAddFriend) {
        return;
    }

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)),
    dispatch_get_main_queue(), ^{
        SaulWeChatAddFriend *addFriend = [SaulWeChatAddFriend sharedInstance];
        static NSInteger row = addFriend.totalCount - 1;
        static NSInteger tmpNum = addFriend.totalCount;
        for(UIView *view in self.view.subviews) {
            if([view isKindOfClass:[UITableView class]]) {
                if (row < 0) {
                    row = addFriend.totalCount;
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    return;
                }
                if (tmpNum < addFriend.totalCount) {
                    row += addFriend.totalCount - tmpNum + 1;
                    tmpNum = addFriend.totalCount;
NSLog(@"tmp==%ld_%ld_%ld",(long)addFriend.totalCount,(long)row,(long)tmpNum);
                } else {

                }

NSLog(@"row++%ld_%ld_%ld",(long)addFriend.totalCount,(long)row,(long)tmpNum);

                if (row + 2 == addFriend.totalCount) {
                    Ivar mDelegateVar = class_getInstanceVariable(objc_getClass("SayHelloViewController"), "m_DataLogic");
                    id mDelegate = object_getIvar(self, mDelegateVar);
                    [addFriend doDelegateFriendAction:mDelegate andCellNum:row + 1];
NSLog(@"删除成功++row = %ld -- total = %ld",(long)(row+1),(long)addFriend.totalCount);

                    tmpNum = addFriend.totalCount;

NSLog(@"删除成功——row = %ld -- total = %ld",(long)(row+1),(long)addFriend.totalCount);
                }

                NSIndexPath * indexPatch = [NSIndexPath indexPathForRow:row inSection:0];
                row--;
NSLog(@"row--%ld_%ld_%ld",(long)addFriend.totalCount,(long)row,(long)tmpNum);
                [self tableView:view didSelectRowAtIndexPath:indexPatch];
            }
        }
    });
}

%end

%hook SayHelloDataLogic
- (unsigned int)getHelloCount
{
    int orgin = %orig;
    SaulWeChatAddFriend *addFriend = [SaulWeChatAddFriend sharedInstance];
    addFriend.totalCount = orgin;
    return orgin;
}

%end

%hook MMTabBarController

- (void)viewDidLoad
{
%orig;

    UILabel * label = [[UILabel alloc] init];
    label.frame = CGRectMake(30, 20, 70, 30);
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:12];
    label.text = @"添加好友 →";
    [self.view addSubview:label];


    UISwitch *switch1 = [[UISwitch alloc]init];
    switch1.frame = CGRectMake(100, 20, 0, 0);
    [switch1 setOn:NO];
    [switch1 addTarget:self action:@selector(switchIsChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:switch1];

}

%new
-(void)switchIsChanged:(UISwitch *)swith
{
    SaulWeChatAddFriend *addFriend = [SaulWeChatAddFriend sharedInstance];

    if ([swith isOn]){
        addFriend.isAddFriend = YES;
    } else {
        addFriend.isAddFriend = NO;
    }
}

%end

