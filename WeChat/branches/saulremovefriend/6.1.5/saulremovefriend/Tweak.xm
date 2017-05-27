#import "WeChat/ContactInfoViewController.h"
#import "WeChat/WCTimeLineFooterView.h"
#import "WeChat/WCListViewController.h"
#import "WeChat/WeixinContactInfoAssist.h"
#import "WeChat/CBaseContactInfoAssist.h"
#import "WeChat/ContactsViewController.h"
#import "WeChat/ContactSettingViewController.h"
#import "WeChat/ContactsDataLogic.h"
#import "WeChat/CBaseContact.h"
#import "WeChat/CContact.h"
#import "SaulWeChatPublicClass.h"
#import "WeChat/MMTabBarController.h"
#import "WeChat/CSetting.h"

NSMutableArray * array;

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
        if(!array) {
            array =  [[NSMutableArray alloc] init];
        }
    } else {
        [SaulWeChatPublicClass sharedInstance].isRemoveFriend = NO;
    }

    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
    NSString * filename = [path stringByAppendingPathComponent:@"removeFriendNumberList.plist"];
    dic2 = [NSDictionary dictionaryWithContentsOfFile:filename];
    if (dic2) {
        NSString * valueString = [dic2 objectForKey:[SaulWeChatPublicClass sharedInstance].removeFriendNumberKey];
        if (valueString) {
            [SaulWeChatPublicClass sharedInstance].dataNumber = [valueString integerValue];
        } else {
            [SaulWeChatPublicClass sharedInstance].dataNumber = 0;
        }
    } else {
        [SaulWeChatPublicClass sharedInstance].dataNumber = 0;
    }
}

%end

%hook ContactsViewController
- (void)viewWillAppear:(_Bool)arg1 {
%orig;
    if (![SaulWeChatPublicClass sharedInstance].isRemoveFriend) {
        return;
    }

if (![SaulWeChatPublicClass sharedInstance].isGetUserList) {


    Ivar mDelegateVar = class_getInstanceVariable(objc_getClass("ContactsViewController"), "m_contactsDataLogic");
    ContactsDataLogic * mDelegate = object_getIvar(self, mDelegateVar);



    for (int i = 0; i <= 26; i++) {
        if (i == 26) {
            for (CBaseContact * contact in [mDelegate getContactsArrayWith:@"#"]) {
                [array addObject:contact];
            }
            break;
        }
        NSString * str = [NSString stringWithFormat:@"%c",(char)(65 + i)];
        if ([mDelegate getContactsArrayWith:str]) {
            for (CBaseContact * contact in [mDelegate getContactsArrayWith:str]) {
                [array addObject:contact];
            }
        }
    }
    [SaulWeChatPublicClass sharedInstance].isGetUserList = YES;
}


    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        if (![SaulWeChatPublicClass sharedInstance].isGetUserList) {
            UIAlertView*alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"好友列表未加载完，请切换到其他页面，稍后在试" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"okay",nil];
            [alert show];
        }

        if ([SaulWeChatPublicClass sharedInstance].dataNumber < array.count) {
            CBaseContact * contact = array[[SaulWeChatPublicClass sharedInstance].dataNumber];
            NSLog(@"\n %@ \n %@ \n %lld \n ↑",[contact getContactTalkRoomName],contact,(long long)[SaulWeChatPublicClass sharedInstance].dataNumber);

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
            NSString *filename = [path stringByAppendingPathComponent:@"removeFriendNumberList.plist"];
            NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%lld",(long long)[SaulWeChatPublicClass sharedInstance].dataNumber],[SaulWeChatPublicClass sharedInstance].removeFriendNumberKey,nil];
            [dic writeToFile:filename atomically:YES];
            [SaulWeChatPublicClass sharedInstance].dataNumber++;
        });
            [self showContactInfoView:contact];
        } else{
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"完事儿" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"okay",nil];
            [alert show];
            [SaulWeChatPublicClass sharedInstance].dataNumber = 0;
            NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
            NSString *filename = [path stringByAppendingPathComponent:@"removeFriendNumberList.plist"];
            NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%lld",(long long)[SaulWeChatPublicClass sharedInstance].dataNumber],[SaulWeChatPublicClass sharedInstance].removeFriendNumberKey,nil];
            [dic writeToFile:filename atomically:YES];
        }

    });
}

%end

%hook ContactInfoViewController
- (void)viewWillAppear:(BOOL)arg1 {
%orig;


    if (![SaulWeChatPublicClass sharedInstance].isRemoveFriend) {
        return;
    }

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

    if ([SaulWeChatPublicClass sharedInstance].isCheckDone) {
        if (![SaulWeChatPublicClass sharedInstance].isNotFriend) {
            [SaulWeChatPublicClass sharedInstance].isCheckDone = NO;
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            Ivar mDelegateVar = class_getInstanceVariable(objc_getClass("ContactInfoViewController"), "m_oContactInfoAssist");
            WeixinContactInfoAssist * mDelegate = object_getIvar(self, mDelegateVar);
            [mDelegate onAction];
        }
    } else {
        Ivar mDelegateVar = class_getInstanceVariable(objc_getClass("ContactInfoViewController"), "m_oContactInfoAssist");
        CBaseContactInfoAssist * mDelegate = object_getIvar(self, mDelegateVar);


        Ivar mDelegateVar1 = class_getInstanceVariable(objc_getClass("ContactInfoViewController"), "m_contact");
        CContact * mDelegate1 = object_getIvar(self, mDelegateVar1);
        if ([mDelegate1 isBrandContact]) {
            [SaulWeChatPublicClass sharedInstance].isCheckDone = NO;
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [mDelegate showAlbum];
        }
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

    if ([SaulWeChatPublicClass sharedInstance].isCheckDone) {
        if ([SaulWeChatPublicClass sharedInstance].isNotFriend) { // 不是好友
            [SaulWeChatPublicClass sharedInstance].isNotFriend = NO;
            [self doDelete];
        }
    }
}

%end

%hook WCListViewController // 判断是否是好友
- (void)viewDidLoad {
%orig;

    if (![SaulWeChatPublicClass sharedInstance].isRemoveFriend) {
        return;
    }

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SaulWeChatPublicClass sharedInstance].isCheckDone = YES;
        [self onDissmiss];
    });
}

%end

%hook WCTimeLineFooterView

- (id)initWithFrame:(struct CGRect)arg1 {
id orig = %orig;

    if (![SaulWeChatPublicClass sharedInstance].isRemoveFriend) {
        return orig;
    }

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self onClick];
    });

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        Ivar mDelegateVar = class_getInstanceVariable(objc_getClass("WCTimeLineFooterView"), "m_label");
        UILabel * mDelegate = object_getIvar(self, mDelegateVar);
        if ([mDelegate.text isEqualToString:@"非对方的朋友只显示最多十张照片"]) {
            [SaulWeChatPublicClass sharedInstance].isNotFriend = YES;
        }
    });

return orig;
}

%end

%hook CSetting
- (id)initWithCoder:(id)arg1
{
id orig = %orig;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        Ivar mDelegateVar = class_getInstanceVariable(objc_getClass("CSetting"), "m_nsAliasName");
        NSString * mDelegate = object_getIvar(self, mDelegateVar);
    if (mDelegate) {
        [SaulWeChatPublicClass sharedInstance].removeFriendNumberKey = mDelegate;
        NSLog(@"\n\n\n\n USER_ID is %@ \n\n\n %@ \n\n initWithCoder",[SaulWeChatPublicClass sharedInstance].removeFriendNumberKey,mDelegate);
        NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
        NSString * filename = [path stringByAppendingPathComponent:@"removeFriendNumberList.plist"];
        dic2 = [NSDictionary dictionaryWithContentsOfFile:filename];
        if(dic2 == nil) {
            NSFileManager* fm = [NSFileManager defaultManager];
            [fm createFileAtPath:filename contents:nil attributes:nil];
            NSDictionary* dd = [NSDictionary dictionaryWithObjectsAndKeys:@"0",[SaulWeChatPublicClass sharedInstance].removeFriendNumberKey,nil]; //写入数据
            [dd writeToFile:filename atomically:YES];
        }
    }
    });
return orig;
}

- (void)preInit
{
%orig;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        Ivar mDelegateVar = class_getInstanceVariable(objc_getClass("CSetting"), "m_nsAliasName");
    NSString * mDelegate = object_getIvar(self, mDelegateVar);
    if (mDelegate) {
        [SaulWeChatPublicClass sharedInstance].removeFriendNumberKey = [NSString stringWithString:mDelegate];
        NSLog(@"\n\n\n\n USER_ID is %@ \n\n\n %@ \n\n preInit",[SaulWeChatPublicClass sharedInstance].removeFriendNumberKey,mDelegate);

        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
        NSString *filename = [path stringByAppendingPathComponent:@"removeFriendNumberList.plist"];
        dic2 = [NSDictionary dictionaryWithContentsOfFile:filename];
        if(dic2 == nil) {
            NSFileManager* fm = [NSFileManager defaultManager];
            [fm createFileAtPath:filename contents:nil attributes:nil];

            NSDictionary* dd = [NSDictionary dictionaryWithObjectsAndKeys:@"0",[SaulWeChatPublicClass sharedInstance].removeFriendNumberKey,nil]; //写入数据
            [dd writeToFile:filename atomically:YES];
        }
    }
    });
}

%end
