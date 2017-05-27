
#import "SaulWeChatPublicClass.h"
#import "WeChat/SelectAttachmentViewController.h"
#import "WeChat/SharePreConfirmView.h"
#import "WeChat/SessionSelectController.h"






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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self onShowMultiSelect:nil];
    });
}

- (void)onMultiDone {
    %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    //publicClass.sessionSelectView.m_dicMultiSelect = publicClass.friendContactDic;
    publicClass.sessionSelectView.m_dicMultiSelect = publicClass.groupContactDic;
}

%end


%hook SharePreConfirmView
- (NSArray *)m_arrToContacts {
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    return publicClass.friendArray;
}

- (void)initContentView {
 %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
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

//////////////////////////////////////////////
/////////////     前 期 准 备      ////////////
/////////////////////////////////////////////
// 显示收藏按钮
%hook SelectAttachmentViewController

- (void)viewDidLoad {
    %orig;
    self.allowFavEntry = YES;
}

%end

// 获取好友列表
%hook MMMassSendContactSelectorViewController

- (void)viewDidLoad {
%orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
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
    [publicClass jumpToFriendListViewController];
}

%end

// 移除消息
%hook BaseMsgContentViewController
- (void)viewWillDisappear:(_Bool)arg1 {
    %orig;
    SaulWeChatPublicClass * publicClass = [SaulWeChatPublicClass sharedInstance];
    [publicClass removeNotification];
}


%end
