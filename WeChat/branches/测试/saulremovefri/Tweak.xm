#import "WeChat/ContactInfoViewController.h"
#import "WeChat/WCTimeLineFooterView.h"
#import "WeChat/WCListViewController.h"
#import "WeChat/WeixinContactInfoAssist.h"
#import "WeChat/CBaseContactInfoAssist.h"
#import "WeChat/ContactsViewController.h"
#import "WeChat/ContactSettingViewController.h"
#import "WeChat/ChatRoomInfoViewController.h"
#import "WeChat/ContactsDataLogic.h"
#import "WeChat/CBaseContact.h"
#import "WeChat/CContact.h"
#import "WeChat/CSetting.h"
#import "SaulWeChatPublicClass.h"
#import "WeChat/MMTabBarController.h"

SaulWeChatPublicClass * saulClass;
NSString * removeFriendNumberKey;
NSDictionary* dic2;
%hook MMTabBarController
- (void)viewDidLoad {
%orig;

    UILabel * label = [[UILabel alloc] init];
    label.frame = CGRectMake(160, 20, 70, 30);
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:12];
    label.text = @"删除好友 →";
    [self.view addSubview:label];

    UISwitch *switch1 = [[UISwitch alloc]init];
    switch1.frame = CGRectMake(230, 20, 0, 0);
    [switch1 setOn:NO];
    [switch1 addTarget:self action:@selector(switchIsRemoveFriendChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:switch1];
}

%new
-(void)switchIsRemoveFriendChanged:(UISwitch *)swith {
    if ([swith isOn]){
        [SaulWeChatPublicClass sharedInstance].isRemoveFriend = YES;
    } else {
        [SaulWeChatPublicClass sharedInstance].isRemoveFriend = NO;
    }
[SaulWeChatPublicClass sharedInstance].dataNumber = 100;
}

%end

%hook ContactsViewController
- (void)viewWillAppear:(_Bool)arg1 {
%orig;

    if (![SaulWeChatPublicClass sharedInstance].isRemoveFriend) {
        return;
    }

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        NSMutableArray * array = [[NSMutableArray alloc] init];
        Ivar mDelegateVar = class_getInstanceVariable(objc_getClass("ContactsViewController"), "m_contactsDataLogic");
        ContactsDataLogic * mDelegate = object_getIvar(self, mDelegateVar);
        array = [mDelegate getAllContacts];


        if (saulClass.dataNumber < array.count) {
            CBaseContact * contact = array[saulClass.dataNumber];
            NSLog(@"\n %@ \n %@ \n %lld \n ↑",[contact getContactTalkRoomName],contact,(long long)saulClass.dataNumber);
            NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
            NSString *path=[paths objectAtIndex:0];
            NSString *filename=[path stringByAppendingPathComponent:@"removeFriendNumberList.plist"];
            NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%lld",(long long)saulClass.dataNumber],removeFriendNumberKey,nil];
            [dic writeToFile:filename atomically:YES];
            saulClass.dataNumber++;

            [self showContactInfoView:contact];

        } else{
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"完事儿" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"okay",nil];
            [alert show];
            saulClass.dataNumber = 0;
            NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
            NSString *path=[paths objectAtIndex:0];
            NSString *filename=[path stringByAppendingPathComponent:@"removeFriendNumberList.plist"];
            NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%lld",(long long)saulClass.dataNumber],removeFriendNumberKey,nil];
            [dic writeToFile:filename atomically:YES];
        }

    });
}

%end

%hook ContactSettingViewController
- (void)viewDidLoad {
 %orig;

    if (![SaulWeChatPublicClass sharedInstance].isRemoveFriend) {
        return ;
    }
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        saulClass.dataNumber--;
        [self doDelete];
});

}
%end

%hook ChatRoomInfoViewController
- (void)viewDidLoad
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];

    });
}
%end

%hook ContactInfoViewController
- (void)viewWillAppear:(BOOL)arg1 {
%orig;

    if (![SaulWeChatPublicClass sharedInstance].isRemoveFriend) {
        return;
    }

    if (!saulClass) {
        saulClass = [SaulWeChatPublicClass sharedInstance];
    }
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        Ivar mDelegateVar = class_getInstanceVariable(objc_getClass("ContactInfoViewController"), "m_oContactInfoAssist");
        CBaseContactInfoAssist * mDelegate = object_getIvar(self, mDelegateVar);
        [mDelegate onAction];
});
}
%end

%hook CSetting
- (id)initWithCoder:(id)arg1
{
id orig = %orig;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        Ivar mDelegateVar = class_getInstanceVariable(objc_getClass("CSetting"), "m_nsAliasName");
        NSString * mDelegate = object_getIvar(self, mDelegateVar);
        removeFriendNumberKey = mDelegate;
        NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *path=[paths objectAtIndex:0];
        NSString *filename=[path stringByAppendingPathComponent:@"removeFriendNumberList.plist"];
        dic2 = [NSDictionary dictionaryWithContentsOfFile:filename];
        if(dic2 == nil) {
            NSFileManager* fm = [NSFileManager defaultManager];
            [fm createFileAtPath:filename contents:nil attributes:nil];
            NSDictionary* dd = [NSDictionary dictionaryWithObjectsAndKeys:@"0",removeFriendNumberKey,nil]; //写入数据
            [dd writeToFile:filename atomically:YES];
        }
    });
return orig;
}

- (void)preInit
{
%orig;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        Ivar mDelegateVar = class_getInstanceVariable(objc_getClass("CSetting"), "m_nsAliasName");
        NSString * mDelegate = object_getIvar(self, mDelegateVar);
        removeFriendNumberKey = mDelegate;

        NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *path=[paths objectAtIndex:0];
        NSString *filename=[path stringByAppendingPathComponent:@"removeFriendNumberList.plist"];
        dic2 = [NSDictionary dictionaryWithContentsOfFile:filename];
        if(dic2 == nil) {
            NSFileManager* fm = [NSFileManager defaultManager];
            [fm createFileAtPath:filename contents:nil attributes:nil];

            NSDictionary* dd = [NSDictionary dictionaryWithObjectsAndKeys:@"0",removeFriendNumberKey,nil]; //写入数据
            [dd writeToFile:filename atomically:YES];
        }
    });
}

%end
