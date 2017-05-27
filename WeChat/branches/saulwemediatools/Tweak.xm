#import <CoreLocation/CoreLocation.h>
#import <mapkit/mapkit.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SaulWeChatPublicClass.h"
#import "AccountListController.h"
#import "WeChat/MMTableViewInfo.h"
#import "WeChat/MMTableViewCellInfo.h"
#import "WeChat/MoreViewController.h"
#import "WeChat/FindFriendEntryViewController.h"
#import "WeChat/MMTabBarController.h"
#import "WeChat/ShakeViewController.h"
#import "WeChat/ContactInfoViewController.h"
#import "WeChat/MMSayHelloViewController.h"
#import "WeChat/EnterLbsViewController.h"
#import "WeChat/SeePeopleNearbyViewController.h"
#import "WeChat/LbsContactInfoList.h"
#import "WeChat/WCActionSheet.h"
#import "WeChat/WCAccountControlData.h"
#import "WeChat/WCAccountLoginLastUserViewController.h"
#import "WeChat/WCAccountLoginLastUserViewControllerDelegate-Protocol.h"
#import "WeChat/WCAccountLoginControlLogic.h"
#import "WeChat/WCBaseTextFieldItem.h"
#import "WeChat/SayHelloViewController.h"
#import "WeChat/SayHelloDataLogic.h"
#import "WeChat/CBaseContactInfoAssist.h"
#import "WeChat/MMMainTableView.h"
#import "WeChat/WCTimeLineFooterView.h"
#import "WeChat/WCListViewController.h"
#import "WeChat/CContact.h"
#import "WeChat/CBaseContact.h"
#import "WeChat/WeixinContactInfoAssist.h"
#import "WeChat/ContactsViewController.h"
#import "WeChat/ContactSettingViewController.h"
#import "WeChat/ChatRoomInfoViewController.h"
#import "WeChat/ContactsDataLogic.h"
#import "WeChat/NewSettingViewController.h"
#import "WeChat/ChatRoomListViewController.h"
#import "WeChat/BaseMsgContentViewController.h"
#import "WeChat/RoomContactSelectViewController.h"
#import "WeChat/SendVerifyMsgViewController.h"
#import "WeChat/RoomContentLogicController.h"
#import "WeChat/SelectAttachmentViewController.h"
#import "WeChat/SharePreConfirmView.h"
#import "WeChat/SessionSelectController.h"
#import "WeChat/FTSContactMgr.h"
#import "WeChat/SettingGeneralViewController.h"
#import "WeChat/SettingPluginsViewController.h"
#import "WeChat/CMessageWrap.h"
#import "WeChat/MMServiceCenter.h"
#import "WeChat/CMessageMgr.h"
#import "WeChat/CContactMgr.h"



%hook NewMainFrameViewController
- (void)viewWillAppear:(_Bool)arg1 {
    %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (publicClass.isS7On && publicClass.isAddFirendBegin) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [publicClass.tabBarViewController setSelectedIndex:1];
            publicClass.isAddFirendBegin = NO;
        });
    }
}
%end

%hook SendVerifyMsgViewController
- (void)viewDidLoad {
    %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (publicClass.isS7On) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self onSendVerifyMsg];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self onReturn];
            });
        });
    }
}
%end

%hook RoomContentLogicController
- (void)viewDidLoad {
    %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (publicClass.isS7On) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self OpenDetailInfo];
        });
    }
}
%end

%hook RoomContactSelectViewController
- (void)viewWillAppear:(_Bool)arg1 {
    %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (publicClass.isS7On) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
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
}
%end

%hook BaseMsgContentViewController
- (void)viewDidLoad {
    %orig;
    static BOOL tmpIsIn = NO;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (publicClass.isS7On) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
            [self openChatInfo:[self GetContact]];
            publicClass.isAddFirendBegin = YES;
        });
    }
    else if (publicClass.isS11On) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
            if (tmpIsIn) {
                [publicClass.massSendContentLogicController onNewMassSend:nil];
            }
            tmpIsIn = !tmpIsIn;
        });
    }
}

%end

%hook MMGrowTextView
- (_Bool)textview:(id)arg1 shouldPasteImage:(id)arg2 {
    return YES;
}
%end

%hook MassSendContentLogicController
- (void)ViewDidInit {
    %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    [publicClass holdMassSendContentLogicController:self];
}

%end

%hook ChatRoomListViewController
- (long long)tableView:(id)arg1 numberOfRowsInSection:(long long)arg2 {
    long long orig = %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (publicClass.isS7On) {
        if (publicClass.chatRoomCount != orig && orig != 0) {
            publicClass.chatRoomCount = orig;
            //NSLog(@"\n\n %lld -- %d",orig,publicClass.chatRoomCount);
        }
    }
    return orig;
}
- (void)viewDidLoad {
%orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (publicClass.isS7On) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (publicClass.chatRoomTag < publicClass.chatRoomCount) {
                [self didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:publicClass.chatRoomTag inSection:0]];
                publicClass.chatRoomTag++;
            } else {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"完事儿" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"okay",nil];
                [alert show];
                publicClass.floatButton.hidden = YES;
                publicClass.isAddFirendBegin = publicClass.isS7On = NO;
                publicClass.chatRoomTag = 0;
            }
        });
    }
}
%end


//////////////////////////////////////////////////
//////////////////////////////////////////////////
//////////////////////////////////////////////////

%hook CExtendInfoOfVideo

- (NSString *)xmlOfStreamVideo {
    NSString * orig = %orig;

    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];

    if (publicClass.videoString.length > 0 && publicClass.videoString) {
        NSArray * videoDetailArray = [publicClass.videoString componentsSeparatedByString:@"&&"];
        NSString * vTitle = @"<streamvideo><streamvideourl><![CDATA[]]></streamvideourl><streamvideototaltime>0</streamvideototaltime><streamvideotitle><![CDATA[";
        NSString * vWord  = @"]]></streamvideotitle>            <streamvideowording><![CDATA[";
        NSString * vURL   = @"]]></streamvideowording><streamvideoweburl><![CDATA[";
        NSString * vImage = @"]]></streamvideoweburl><streamvideothumburl><![CDATA[";
        NSString * vEnding= @"]]></streamvideothumburl><streamvideopublishid><![CDATA[12476481592974710637]]></streamvideopublishid><streamvideoaduxinfo><![CDATA[1603222444|wx0fmd5vtjkq3zyc||1|1488794839]]></streamvideoaduxinfo></streamvideo></streamvideo>";
        orig = vTitle;
        orig = [orig stringByAppendingString:@"saulTong"];
        orig = [orig stringByAppendingString:vWord];
        orig = [orig stringByAppendingString:videoDetailArray[0]];
        orig = [orig stringByAppendingString:vURL];
        orig = [orig stringByAppendingString:videoDetailArray[1]];
        orig = [orig stringByAppendingString:vImage];
        orig = [orig stringByAppendingString:@"http://wemedia.cn/Public/static/mypublic/images/ab.jpg"];
        orig = [orig stringByAppendingString:vEnding];
    }

    return orig;
}

%end

//////////////////////////////////////////////////
//////////////////////////////////////////////////
//////////////////////////////////////////////////

%hook ContactSettingViewController
- (void)viewDidLoad {
    %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (publicClass.isS5On) {
        if (publicClass.isCheckDone) {
            if (publicClass.isNotFriend) { // 不是好友
                publicClass.dataNumber--;
                publicClass.isNotFriend = NO;
                [self doDelete];
            }
        }
    }
}
%end

%hook ChatRoomInfoViewController
- (void)viewDidLoad {
    %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];

    if (publicClass.isS7On) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
            [self showMoreMemberEx];
        });
    }

    if (publicClass.isS5On) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            publicClass.isCheckDone = NO;
            [self.navigationController popViewControllerAnimated:YES];
        });
    }
}
%end

%hook WCListViewController
- (void)reloadData {
    %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (publicClass.isS5On) {
        publicClass.isNotFriend = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"REMOVE_SINGLE_FRIEND" object:@"这个是好友"];
    }
}
- (void)viewDidLoad {
    %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (publicClass.isS5On) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self refreshFooter];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToContactInfoViewController:) name:@"REMOVE_SINGLE_FRIEND" object:nil];
        });
    }
}
- (void)viewWillDisappear:(_Bool)arg1 {
    %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (publicClass.isS5On) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"REMOVE_SINGLE_FRIEND" object:nil];
    }
}
%new

- (void)goToContactInfoViewController:(NSNotification *)notification {
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (publicClass.isS5On) {
        //NSLog(@"\n\n\n\n 好友判断:  %@",[notification object]);
        publicClass.isCheckDone = YES;
        [self onDissmiss];
    }
}
%end


%hook WCTimeLineFooterView
- (void)onStateOfNoMoreData:(id)arg1 {
    %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (publicClass.isS5On) {
        Ivar mDelegateVar = class_getInstanceVariable(objc_getClass("WCTimeLineFooterView"), "m_label");
        UILabel * mDelegate = object_getIvar(self, mDelegateVar);
        if (mDelegate.text.length == 0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                publicClass.isNotFriend = NO;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"REMOVE_SINGLE_FRIEND" object:@"朋友圈是空的"];
            });
        }
        if ([arg1 isEqualToString:@"非对方的朋友只显示最多十张照片"]) {
            publicClass.isNotFriend = YES;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"REMOVE_SINGLE_FRIEND" object:@"单项好友"];
        }
    }
}
%end


%hook CSetting // 获取用户ID
- (id)initWithCoder:(id)arg1 {
    id orig = %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        Ivar mDelegateVar = class_getInstanceVariable(objc_getClass("CSetting"), "m_nsAliasName");
        NSString * mDelegate = object_getIvar(self, mDelegateVar);
        [publicClass saveRemoveUserInfo:mDelegate AndValue:nil];
    });

    return orig;
}

- (void)preInit {
    %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        Ivar mDelegateVar = class_getInstanceVariable(objc_getClass("CSetting"), "m_nsAliasName");
        NSString * mDelegate = object_getIvar(self, mDelegateVar);
        [publicClass saveRemoveUserInfo:mDelegate AndValue:nil];
    });
}
%end


//////////////////////////////////////////////////
////////////////////////////////////////////////// 登陆
//////////////////////////////////////////////////
%hook NewSettingViewController
- (void)viewDidLoad {
    %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (publicClass.isTmpUser) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self tryQuit];
        });
    } else if (publicClass.isS11On) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self showGeneralView];
        });
    }
    [publicClass.addGroupDict removeAllObjects];
}
%end

%hook WCAccountLoginLastUserViewController
- (void)viewDidLoad {
    %orig;
    UIButton * transparentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [transparentButton setTitle:@"切换账号" forState:UIControlStateNormal];
    [transparentButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    transparentButton.titleLabel.font = [UIFont systemFontOfSize:15];
    transparentButton.titleLabel.textColor = [UIColor lightGrayColor];
    transparentButton.frame = CGRectMake(((UIViewController *)self).view.frame.size.width - 100, ((UIViewController *)self).view.frame.size.height - 100, 90, 90);
    [transparentButton.layer setMasksToBounds:YES];
    [transparentButton.layer setCornerRadius:45.0];
    transparentButton.layer.borderWidth = 1;
    transparentButton.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [transparentButton addTarget:self action:@selector(clickImage) forControlEvents:UIControlEventTouchUpInside];
    [((UIViewController *)self).view addSubview:transparentButton];

    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (publicClass.isTmpUser) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            WCAccountLoginControlLogic *m_delegate = MSHookIvar<WCAccountLoginControlLogic *>(self, "m_delegate");
            [m_delegate onLastUserLoginUserName:publicClass.userInfoWithName Pwd:publicClass.userInfoWithPWD];
            publicClass.isTmpUser = NO;
            publicClass.userInfoWithName = publicClass.userInfoWithPWD = nil;
        });
    }

}

%new
- (void)setAccount:(AccountInfo *)ai {
    WCBaseTextFieldItem * &m_textFieldPwdItem = MSHookIvar<WCBaseTextFieldItem *>(self, "m_textFieldPwdItem");
    [m_textFieldPwdItem setText:ai.userPwd];
    UILabel * &m_labelUserName = MSHookIvar<UILabel *>(self, "m_labelUserName");
    m_labelUserName.text = ai.userName;
    WCAccountLoginControlLogic *m_delegate = MSHookIvar<WCAccountLoginControlLogic *>(self, "m_delegate");
    [m_delegate onLastUserLoginUserName:ai.userName Pwd:ai.userPwd];
}

%new
- (void)clickImage {
    AccountListController * alc = [[AccountListController alloc] init];
    alc.parent = self;
    UINavigationController * unc = [[UINavigationController alloc] initWithRootViewController:alc];
    [self presentViewController:unc animated:YES completion:^{}];
}

- (void)onNext {
    %orig;
    WCBaseTextFieldItem * &m_textFieldPwdItem = MSHookIvar<WCBaseTextFieldItem *>(self, "m_textFieldPwdItem");
    UILabel * &m_labelUserName = MSHookIvar<UILabel *>(self, "m_labelUserName");
    AccountInfo * ai = [[AccountInfo alloc] init];
    ai.userName = m_labelUserName.text;
    ai.userPwd = [m_textFieldPwdItem getValue];
    [AccountInfo updateAccount:ai];
}
%end

%hook WCAccountLoginFirstUserViewController
- (void)onNext {
    %orig;
    WCBaseTextFieldItem * &m_textFieldUserNameItem = MSHookIvar<WCBaseTextFieldItem *>(self, "m_textFieldUserNameItem");
    WCBaseTextFieldItem * &m_textFieldPwdItem = MSHookIvar<WCBaseTextFieldItem *>(self, "m_textFieldPwdItem");
    AccountInfo * ai = [[AccountInfo alloc] init];
    ai.userName = [m_textFieldUserNameItem getValue];
    ai.userPwd = [m_textFieldPwdItem getValue];
    [AccountInfo updateAccount:ai];
}
%end

//////////////////////////////////////////////////
//////////////////////////////////////////////////
//////////////////////////////////////////////////

%hook ContactsViewController
- (void)viewWillAppear:(_Bool)arg1 {
    %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];

    if (publicClass.isS7On) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self handleSelectdChatRoom];
        });
    }

    if (publicClass.isS5On) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSMutableArray * array = [[NSMutableArray alloc] init];
            Ivar mDelegateVar = class_getInstanceVariable(objc_getClass("ContactsViewController"), "m_contactsDataLogic");
            ContactsDataLogic * mDelegate = object_getIvar(self, mDelegateVar);
            array = [mDelegate getAllContacts];
            if (publicClass.dataNumber < array.count) {
                CBaseContact * contact = array[publicClass.dataNumber];
                //NSLog(@"\n %@ \n %@ \n %lld \n ↑",[contact getContactTalkRoomName],contact,(long long)publicClass.dataNumber);

                [publicClass saveRemoveUserInfo:publicClass.removeFriendNumberKey AndValue:[NSString stringWithFormat:@"%lld",(long long)publicClass.dataNumber]];
                publicClass.dataNumber++;
                [self showContactInfoView:contact];
            } else {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"完事儿" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"okay",nil];
                [alert show];
                publicClass.dataNumber = 0;
                [publicClass saveRemoveUserInfo:publicClass.removeFriendNumberKey AndValue:[NSString stringWithFormat:@"%lld",(long long)publicClass.dataNumber]];
            }
        });
    }

    if (publicClass.isS4On) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            Ivar mDelegateVar = class_getInstanceVariable(objc_getClass("ContactsViewController"), "m_tableView");
            MMMainTableView * mDelegate = object_getIvar(self, mDelegateVar);
            [self tableView:mDelegate didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        });
    }
}
%end

%hook SayHelloViewController
- (void)willAppear {
    %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (publicClass.isS4On) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            static NSInteger row = publicClass.totalCount - 1;
            static NSInteger tmpNum = publicClass.totalCount;
            for(UIView *view in self.view.subviews) {
                if([view isKindOfClass:[UITableView class]]) {
                    if (row < 0) {
                        row = publicClass.totalCount;
                        publicClass.floatButton.hidden = YES;
                        publicClass.isS4On = NO;
                        [self.navigationController popToRootViewControllerAnimated:YES];
                        return;
                    }
                    if (tmpNum < publicClass.totalCount) {
                        row += publicClass.totalCount - tmpNum + 1;
                        tmpNum = publicClass.totalCount;
//NSLog(@"tmp==%ld_%ld_%ld",(long)publicClass.totalCount,(long)row,(long)tmpNum);
                    } else {
//NSLog(@"\n\n\n\n\n\n nothing \n\n\n\n\n\n\n");
                    }
//NSLog(@"row++%ld_%ld_%ld",(long)publicClass.totalCount,(long)row,(long)tmpNum);

                    if (row + 2 == publicClass.totalCount) {
                        Ivar mDelegateVar = class_getInstanceVariable(objc_getClass("SayHelloViewController"), "m_DataLogic");
                        id mDelegate = object_getIvar(self, mDelegateVar);
                        [publicClass doDelegateFriendAction:mDelegate andCellNum:row + 1];
//NSLog(@"删除成功++row = %ld -- total = %ld",(long)(row+1),(long)publicClass.totalCount);
                        tmpNum = publicClass.totalCount;
//NSLog(@"删除成功——row = %ld -- total = %ld",(long)(row+1),(long)publicClass.totalCount);
                    }
                    NSIndexPath * indexPatch = [NSIndexPath indexPathForRow:row inSection:0];
                    row--;
//NSLog(@"row--%ld_%ld_%ld",(long)publicClass.totalCount,(long)row,(long)tmpNum);
                    [self tableView:view didSelectRowAtIndexPath:indexPatch];
                }
            }
        });
    }
}
%end

%hook SayHelloDataLogic
- (unsigned int)getHelloCount {
    int orgin = %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (publicClass.isS4On) {
        publicClass.totalCount = orgin;
    }
    return orgin;
}

%end

//////////////////////////////////////////////////
//////////////////////////////////////////////////
//////////////////////////////////////////////////

%hook WCActionSheet
- (void)showInView:(id)arg1 {
%orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (publicClass.isS3On) {
        [publicClass getActionSheetWith:self];
    }
}
%end

%hook SeePeopleNearbyViewController
- (void)viewDidLoad {
%orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (publicClass.isS3On) {
        [self showOperationMenu:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [publicClass.actionSheet dismissWithClickedButtonIndex:publicClass.nearbyType animated:YES];
            publicClass.isCanUserInfo = YES;
        });
    }
}

- (void)viewWillDisappear:(_Bool)arg1 {
%orig;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SAY_HELLO_WITH_NEARBY" object:nil];
}

- (void)viewWillAppear:(_Bool)arg1 {
    %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (publicClass.isS3On) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToContactInfoViewController:) name:@"SAY_HELLO_WITH_NEARBY" object:nil];
    }
}

%new
- (void)goToContactInfoViewController:(NSNotification *)notification {
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (publicClass.isS3On) {
        if ([[notification object] isEqualToString:@"BACK"]) {
            [self goBackToRootView];
            publicClass.floatButton.hidden = YES;
            publicClass.isS3On = NO;
        } else {
            [self showPeopleInfoView:publicClass.tmpNearByUserInfo];
            publicClass.tmpNearByUserNum++;
        }
    }
}
%end

%hook PeopleNearByListViewController
- (void)reloadWithLbsContactInfoList:(id)arg1{
%orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (publicClass.isCanUserInfo) {
        publicClass.isGetUserInfo = YES;
        publicClass.isCanUserInfo = NO;
    }
}


- (void)viewDidLayoutSubviews{
%orig;

    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (publicClass.isS3On) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            LbsContactInfoList * infoList = object_getIvar(self, class_getInstanceVariable(objc_getClass("PeopleNearByListViewController"), "m_lbsContactList"));
            if (infoList) {
                if (publicClass.tmpNearByUserNum < [infoList countOfLbsContactList]) {
                    if (publicClass.isGetUserInfo) {
                        publicClass.isGetUserInfo = NO;
                        publicClass.tmpNearByUserInfo = [infoList objectInLbsContactListAtIndex:publicClass.tmpNearByUserNum];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"SAY_HELLO_WITH_NEARBY" object:nil];
                    }
                } else {
                    publicClass.tmpNearByUserNum = 0;
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"SAY_HELLO_WITH_NEARBY" object:@"BACK"];
                }
            }
        });
    }
}
%end

%hook EnterLbsViewController
- (void)viewDidLoad {
    %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (publicClass.isS3On) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self OnOpenLbs];
        });
    }
}
%end


//////////////////////////////////////////////////

%hook FindFriendEntryViewController
- (void)viewWillAppear:(_Bool)arg1 {
%orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    [publicClass openWeMediaToolsWithViewController:self];
}
%end

//////////////////////////////////////////////////

%hook MMSayHelloViewController
- (void)viewDidLoad {
    %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (publicClass.isS2On || publicClass.isS3On) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UITextField * myDelegate = object_getIvar(self, class_getInstanceVariable(objc_getClass("MMSayHelloViewController"), "m_sayHelloTextView"));
            myDelegate.text = publicClass.sayHelloString;
            [self onSendSayHello:nil];
        });
    }
}
%end

%hook ContactInfoViewController
- (void)viewWillAppear:(_Bool)arg1 {
    %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];

    if (publicClass.isS7On) {
        static BOOL isSend = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
    } else if (publicClass.isS5On) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (publicClass.isCheckDone) {
                if (!publicClass.isNotFriend) {
                    publicClass.isCheckDone = NO;
                    [self.navigationController popViewControllerAnimated:YES];
                } else {
                    Ivar mDelegateVar = class_getInstanceVariable(objc_getClass("ContactInfoViewController"), "m_oContactInfoAssist");
                    CBaseContactInfoAssist * mDelegate = object_getIvar(self, mDelegateVar);
                    [mDelegate onAction];
                }
            } else {
                Ivar mDelegateVar = class_getInstanceVariable(objc_getClass("ContactInfoViewController"), "m_oContactInfoAssist");
                CBaseContactInfoAssist * mDelegate = object_getIvar(self, mDelegateVar);
                Ivar mDelegateVar1 = class_getInstanceVariable(objc_getClass("ContactInfoViewController"), "m_contact");
                CContact * mDelegate1 = object_getIvar(self, mDelegateVar1);
                if ([mDelegate1 isBrandContact]) {
                    publicClass.isCheckDone = NO;
                    [self.navigationController popViewControllerAnimated:YES];
                } else {
                    [mDelegate showAlbumList];
                }
            }
        });
    } else if (publicClass.isS1On || publicClass.isS2On || publicClass.isS3On) {
        if (publicClass.isS3On) {
            publicClass.isGetUserInfo = YES;
        }
        if (publicClass.isS1On || publicClass.isShakeDone) {
            [self.navigationController popViewControllerAnimated:YES];
            publicClass.isShakeDone = NO;
        } else {
            [self onSayHello];
            publicClass.isShakeDone = YES;
        }
    } else if (publicClass.isS11On) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            Ivar mDelegateVar1 = class_getInstanceVariable(objc_getClass("ContactInfoViewController"), "m_contact");
            CContact * mDelegate1 = object_getIvar(self, mDelegateVar1);
            [self jumpToContentViewController:mDelegate1];
        });

    }
}

- (void)viewDidLoad {
    %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (publicClass.isS4On) {
        Ivar mDelegateVar = class_getInstanceVariable(objc_getClass("ContactInfoViewController"), "m_oContactInfoAssist");
        id mDelegate = object_getIvar(self, mDelegateVar);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)),
        dispatch_get_main_queue(), ^{
            if ([self isInMyContactList]) {
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                [publicClass doAddFriendAction:mDelegate];
            }
        });
    }
}

- (void)reloadContactAssist {
    %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (publicClass.isS4On) {
        if ([self isInMyContactList] && publicClass.isAddFriendSent) {
            [self.navigationController popViewControllerAnimated:YES];
            publicClass.isAddFriendSent = NO;
        }
    }
}
%end

%hook ShakeSingleView
- (id)initWithItem:(id)arg1 andScene:(unsigned int)arg2 {
    id orig = %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (publicClass.isS1On || publicClass.isS2On || publicClass.isS3On) {
        publicClass.shakeItem = arg1;
        publicClass.shakeSence = [NSString stringWithFormat:@"%d",arg2];
    }
    return orig;
}
- (void)finishShowAnimation {
    %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (publicClass.isS1On || publicClass.isS2On || publicClass.isS3On) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SHAKE_VIEW_USERINFO_GO" object:nil];
    }
}
%end

%hook ShakeViewController
- (void)viewWillDisappear:(_Bool)arg1 {
    %orig;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SHAKE_VIEW_USERINFO_GO" object:nil];
}
- (void)viewWillAppear:(_Bool)arg1  {
    %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (publicClass.isS1On || publicClass.isS2On) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToContactInfoViewController:) name:@"SHAKE_VIEW_USERINFO_GO" object:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self OnShake];
        });
    }
}
%new
- (void)goToContactInfoViewController:(id)notification {
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (publicClass.isS1On || publicClass.isS2On) {
        [self GoToSayHello:publicClass.shakeItem andScene:[publicClass.shakeSence integerValue]];
    }
}
%end



%hook MMTabBarController
- (void)viewDidAppear:(_Bool)arg1{
    %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    [publicClass getTabBarViewWith:self];
}



- (void)showTabBarForIndex:(long long)arg1 {
%orig;
    if (arg1 == 4) [SaulWeChatPublicClass sharedInstance].isMoreViewController = YES;
    else [SaulWeChatPublicClass sharedInstance].isMoreViewController = NO;
}
- (void)showTabBarWithNoViewHeightUpdateForIndex:(long long)arg1 {
    %orig;
    if (arg1 == 4) [SaulWeChatPublicClass sharedInstance].isMoreViewController = YES;
    else [SaulWeChatPublicClass sharedInstance].isMoreViewController = NO;
}
%end

%hook MoreViewController
- (void)viewWillAppear:(_Bool)arg1 {
%orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    [publicClass getMoreViewControllerWith:self];

    [SaulWeChatPublicClass sharedInstance].isMoreViewController = YES;

    if (publicClass.isTmpUser) {
        [self showSettingView];
    }

    [publicClass shareVideoAndMassMessage];

}
- (void)viewWillPush:(_Bool)arg1 {
    %orig;
    [SaulWeChatPublicClass sharedInstance].isMoreViewController = NO;
}

- (void)showEmoticonStoreView {
    WeMediaToolsTableViewController * viewController = [[WeMediaToolsTableViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}


/*
#import "WeChat/WeMediaToolsTableViewController.h"
添加到moreviewcontroller
- (void)showEmoticonStoreView {
WeMediaToolsTableViewController * viewController = [[WeMediaToolsTableViewController alloc] init];
self.hidesBottomBarWhenPushed = YES;
[self.navigationController pushViewController:viewController animated:YES];
self.hidesBottomBarWhenPushed = NO;
}
*/


%end

%hook MMTableViewInfo
- (long long)tableView:(id)arg1 numberOfRowsInSection:(long long)arg2 {
    long long orig = %orig;
    if (arg2 == 4 && [SaulWeChatPublicClass sharedInstance].isMoreViewController)  return 1;
    return orig;
}

- (double)tableView:(id)arg1 heightForRowAtIndexPath:(id)arg2 {
    double orig = %orig;
    NSIndexPath *indexPath = (NSIndexPath *)arg2;
    if (indexPath.section == 4 && [SaulWeChatPublicClass sharedInstance].isMoreViewController) return 45.f;
    return orig;
}

- (long long)numberOfSectionsInTableView:(id)arg1 {
    long long orig = %orig;
    if ([SaulWeChatPublicClass sharedInstance].isMoreViewController)    return 5;
    return orig;
}
- (double)tableView:(id)arg1 heightForFooterInSection:(long long)arg2 {
    double orig = %orig;
    if (arg2 == 4 && [SaulWeChatPublicClass sharedInstance].isMoreViewController) return 10;
    return orig;
}

- (double)tableView:(id)arg1 heightForHeaderInSection:(long long)arg2 {
    double orig = %orig;
    if (arg2 == 5 && [SaulWeChatPublicClass sharedInstance].isMoreViewController) return 10;
    return orig;
}

- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2 {
    id orig = %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];

    if ([publicClass buildToolsCellWith:arg2]) {
        return [publicClass buildToolsCellWith:arg2];
    }
    return orig;
}

- (void)tableView:(id)arg1 didSelectRowAtIndexPath:(id)arg2
{
    %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    [publicClass pushToolsViewController:arg2];
}


%end


//////////////////////////////////////////////////
////////////////////群发///////////////////////////
//////////////////////////////////////////////////
// 获取好友列表
%hook MMMassSendContactSelectorViewController
- (void)viewDidLoad {
    %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (!publicClass.isS11On) {
        return;
    }
    [publicClass registerNotification];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        Ivar mDelegateVar = class_getInstanceVariable(objc_getClass("MMMassSendContactSelectorViewController"), "_arrAllContacts");
        NSMutableArray * mDelegate = object_getIvar(self, mDelegateVar);
        publicClass.friendArray = mDelegate;
        [publicClass holdMMMassSendContactSelectorViewController:self];
    });
}

- (void)onSelectAll:(id)arg1 {
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (!publicClass.isS11On) {
        %orig;
        return;
    }
    [publicClass jumpToFriendListViewController];
}
%end

// 移除消息
%hook BaseMsgContentViewController
- (void)viewWillDisappear:(_Bool)arg1 {
    %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (!publicClass.isS11On) {
        return;
    }
    [publicClass removeNotification];
}
%end

//////////////////////////////////////////////////
////////////////////转发///////////////////////////
//////////////////////////////////////////////////
%hook SessionSelectView
- (NSMutableDictionary *)m_dicMultiSelect {
    NSMutableDictionary * orig = %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    [publicClass holdSessionSelectView:self];
    return orig;
}

%end

%hook SessionSelectController
- (void)viewDidLoad {
    %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (!publicClass.isS9On && !publicClass.isS10On) {
        return;
    }
    [publicClass holdSessionSelectController:self];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self onShowMultiSelect:nil];
    });
}

- (void)onMultiDone {
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (!publicClass.isS9On && !publicClass.isS10On) {
        %orig;
        return;
    }

    if (!publicClass.isPushUserInfo && publicClass.isS9On) {
        publicClass.isPushUserInfo = !publicClass.isPushUserInfo;
        [publicClass jumpToSelectListViewController];
        return;
    } else {
        %orig;
        if (publicClass.isS9On) {
            publicClass.sessionSelectView.m_dicMultiSelect = publicClass.sharefriendContactDic;
        } else {
            publicClass.sessionSelectView.m_dicMultiSelect = publicClass.groupContactDic;
        }
    }
}
%end

%hook SharePreConfirmView
- (NSArray *)m_arrToContacts {
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (!publicClass.isS9On && !publicClass.isS10On) {
        NSArray * orig = %orig;
        return orig;
    }
    return publicClass.friendArray;
}

- (void)initContentView {
    %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (!publicClass.isS9On && !publicClass.isS10On) {
        return;
    }

    if (publicClass.isUpdataInfo) {
        publicClass.isUpdataInfo = !publicClass.isUpdataInfo;
    } else {
        [self onCancel];
        publicClass.isUpdataInfo = !publicClass.isUpdataInfo;
    }
}

%end

%hook FTSContactMgr
- (id)init {
    id orig = %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    [publicClass saveFriendContactDic:[self getContactDictionary]];
    return orig;
}
%end

%hook MyFavoritesViewController
- (void)viewWillAppear:(_Bool)arg1 {
    %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    publicClass.isPushUserInfo = NO;


}
%end

%hook SettingGeneralViewController
- (void)viewDidLoad {
    %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (publicClass.isS11On) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self showPluginsView];
        });
    }
}
%end

%hook SettingPluginsViewController
- (void)viewDidLoad {
    %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (publicClass.isS11On) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self openContactInfoView:13];
        });
    }
}
%end



%hook  WeixinContentLogicController

- (void)ViewDidAppear {
%orig;
    SaulWeChatPublicClass * saul = [SaulWeChatPublicClass sharedInstance];
    [saul holdWeixinContentLogicController:self];
}
%end

%hook CMessageMgr

- (CMessageMgr *)init {
    CMessageMgr *result = %orig;
    SaulWeChatPublicClass * saul = [SaulWeChatPublicClass sharedInstance];
    [saul holdCMessageMgr:result];
    return result;
}


- (void)AsyncOnPreAddMsg:(id)arg1 MsgWrap:(CMessageWrap *)arg2 {
    %orig;
/*
    NSLog((@"\n\n函数名\n%s "),__FUNCTION__);
    NSLog(@"\n发信人 %@ \n 收信人 %@ \n 正文 %@\n 类型 %lld\n ID %@ \n  %@ \n end",
    arg2.m_nsFromUsr,arg2.m_nsRealChatUsr,arg2.m_nsContent,(long long)arg2.m_uiMessageType,arg2.m_nsRealChatUsr,arg2.m_nsToUsr);
    CContactMgr *contactManager = [[objc_getClass("MMServiceCenter") defaultCenter] getService:[objc_getClass("CContactMgr") class]];
    CContact *selfContact = [contactManager getSelfContact];
    NSLog(@"\n\n\nself = %@  ---- %@",selfContact.m_nsUsrName,arg2.m_nsToUsr);
*/
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (![arg1 hasSuffix:@"@chatroom"] || !publicClass.isS12On) {
        return;
    }

    NSArray *result = (NSArray *)[objc_getClass("CContact") getChatRoomMemberWithoutMyself:arg2.m_nsFromUsr];
    for (CContact * contact in result) {
        if ([contact.m_nsUsrName isEqualToString: arg2.m_nsRealChatUsr]) {
            SaulWeChatPublicClass * saul = [SaulWeChatPublicClass sharedInstance];
            [saul getAtCContactWith:contact];
        }
    }

    switch(arg2.m_uiMessageType) {
        case 10002: { // 扫码入群
            SaulWeChatPublicClass * saul = [SaulWeChatPublicClass sharedInstance];
            if ([arg2.m_nsFromUsr hasSuffix:@"@chatroom"]) {
                if ([saul.addGroupDict objectForKey:arg2.m_nsFromUsr]) {
                    int num = [[saul.addGroupDict objectForKey:arg2.m_nsFromUsr] integerValue];
                    NSString * value = [NSString stringWithFormat:@"%lld",(long long)num+1];
                    [saul.addGroupDict setValue:value forKey:arg2.m_nsFromUsr];
                } else {
                    [saul.addGroupDict setValue:@"1" forKey:arg2.m_nsFromUsr];
                }
                NSString * imgKey = [NSString stringWithFormat:@"%@Img",arg2.m_nsFromUsr];
                if ([saul.addGroupDict objectForKey:imgKey]) {
                    int num = [[saul.addGroupDict objectForKey:imgKey] integerValue];
                    NSString * value = [NSString stringWithFormat:@"%lld",(long long)num+1];
                    [saul.addGroupDict setValue:value forKey:imgKey];
                } else {
                    [saul.addGroupDict setValue:@"1" forKey:imgKey];
                }
            }
            NSString * imgKey = [NSString stringWithFormat:@"%@Img",arg2.m_nsFromUsr];
            saul.sendImgCount = [[saul.addGroupDict objectForKey:imgKey] integerValue];
            saul.addGroupNum = [[saul.addGroupDict objectForKey:arg2.m_nsFromUsr] integerValue];
            if (saul.addGroupNum >= saul.senMessageCount) {
                [saul sendMessage:arg2];
                saul.addGroupNum = 0;
                [saul.addGroupDict setValue:@"1" forKey:arg2.m_nsFromUsr];
            }
            if (saul.sendImgCount == 30) {
                [saul showThirtyCountImageWith:arg2];
                [saul.addGroupDict setValue:@"1" forKey:imgKey];
                saul.sendImgCount = 1;
            }
            break;
        }
        case 3: { // 图片
            SaulWeChatPublicClass * saul = [SaulWeChatPublicClass sharedInstance];
            [saul userSendImageReturnMessage:arg2];
            break;
        }
        default:
            break;
        }
}

%end

%hook MMLocationMgr

- (void)locationManager:(id)arg1 didUpdateToLocation:(id)arg2 fromLocation:(id)arg3 {
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    if (publicClass.isS13On) {
        NSString *lat = publicClass.locationArray[0];
        NSString *lon = publicClass.locationArray[1];
        float tmpLat = [lat floatValue] + 0.000000001;
        float tmpLon = [lon floatValue] + 0.000000001;
        CLLocation *location = [[CLLocation alloc] initWithLatitude:[lat floatValue] longitude:[lon floatValue]];
        CLLocation *location1 = [[CLLocation alloc] initWithLatitude:tmpLat longitude:tmpLon];
        arg2 = location;
        arg3 = location1;
    }
    %orig;

}
%end


