#import "SaulWeChatSayHello.h"
#import "WeChat/ContactInfoViewController.h"
#import "WeChat/FindFriendEntryViewController.h"
#import "WeChat/MMSayHelloViewController.h"
#import "WeChat/MMTabBarController.h"
#import "WeChat/ShakeGetItem.h"
#import "WeChat/ShakeSingleView.h"
#import "WeChat/ShakeViewController.h"


%hook ShakeSingleView

- (id)initWithItem:(id)arg1 andScene:(unsigned int)arg2
{
%orig;
    SaulWeChatSayHello *sayHello = [SaulWeChatSayHello sharedInstance];
    [sayHello setDataDictWith:arg1 andScene:[NSString stringWithFormat:@"%d",arg2]];

    return self;
}

%end

%hook MMSayHelloViewController

- (void)onSendSayHello:(id)arg1
{
%orig;

    NSLog(@"\n\n\n\n\n\n\n\n\n\nonSendSayHello\n%@\n\n\n\n\n\n\n",arg1);
}

- (void)viewDidLoad {
%orig;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)),
    dispatch_get_main_queue(), ^{

    UITextField * t = [[UITextField alloc] init];
    t.text = @"你好！";
        [self onSendSayHello:t];
    });
}

%end

%hook ContactInfoViewController

- (void)viewDidAppear:(BOOL)animated
{
%orig;
    SaulWeChatSayHello *sayHello = [SaulWeChatSayHello sharedInstance];

    if (sayHello.dataDic && [sayHello.dataDic[@"scene"] integerValue] > 0) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popContactInfoViewController) name:@"Notification_PopContactInfoViewController" object:nil];
    }
}

%new
- (void)popContactInfoViewController
{
    SaulWeChatSayHello *sayHello = [SaulWeChatSayHello sharedInstance];
    [sayHello removeDataDic];

    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"Notification_PopContactInfoViewController"
                                                  object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
%orig;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)),
                                dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Notification_PopContactInfoViewController" object:nil userInfo:nil];
    });
}

- (void)viewDidLoad {
%orig;

    SaulWeChatSayHello *sayHello = [SaulWeChatSayHello sharedInstance];
    NSLog(@"\n\n\n\n\n%@ ----------------\n\n\n\n\n",sayHello.dataDic[@"scene"]);
    if (sayHello.dataDic && [sayHello.dataDic[@"scene"] integerValue] > 0) {

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
                [self onSayHello];
        });

        } else {

            [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Notification_PopContactInfoViewController" object:nil];
    }
}

%end

%hook ShakeViewController

- (void)viewWillAppear:(BOOL)animated
{
    %orig;
    SaulWeChatSayHello *sayHello = [SaulWeChatSayHello sharedInstance];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self OnShake];
    });

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        if (sayHello.dataDic[@"item"]) {
            [self GoToSayHello:sayHello.dataDic[@"item"] andScene:[sayHello.dataDic[@"scene"] integerValue]];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    });
}

%end

%hook FindFriendEntryViewController
- (void)viewWillAppear:(BOOL)animated
{
%orig;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)),
    dispatch_get_main_queue(), ^{

    NSIndexPath * indexPatch = [NSIndexPath indexPathForRow:1 inSection:1];
    [self tableView:self.view didSelectRowAtIndexPath:indexPatch];

    });

}
/*
- (void)viewDidLoad {
%orig;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)),
    dispatch_get_main_queue(), ^{

        NSIndexPath * indexPatch = [NSIndexPath indexPathForRow:1 inSection:1];
        [self tableView:self.view didSelectRowAtIndexPath:indexPatch];

    });

}
*/
%end

%hook MMTabBarController

- (void)viewDidLoad {
    %orig;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setSelectedIndex:2];
    });
}

%end

