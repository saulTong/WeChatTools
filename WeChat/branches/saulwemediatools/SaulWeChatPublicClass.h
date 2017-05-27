#import "WeChat/WeMediaToolsTableViewController.h"
#import "WeChat/MoreViewController.h"
#import "WeChat/FindFriendEntryViewController.h"
#import "WeChat/MMTabBarController.h"
#import "WeChat/WCActionSheet.h"
#import "WeChat/CBaseContactInfoAssist.h"
#import "WeChat/SayHelloDataLogic.h"
#import "WeChat/CSetting.h"
#import "WeChat/MassTableViewController.h"
#import "WeChat/MMMassSendContactSelectorViewController.h"
#import "WeChat/SessionSelectView.h"
#import "WeChat/SessionSelectController.h"
#import "WeChat/MassSendContentLogicController.h"
#import "WeChat/CMessageWrap.h"
#import "WeChat/CMessageMgr.h"
#import "WeChat/WeixinContentLogicController.h"
#import "WeChat/CContact.h"


@interface SaulWeChatPublicClass : NSObject {
    BOOL isCheckDone;
    BOOL isNotFriend;
    BOOL isRemoveFriend;
    int dataNumber;
    BOOL isCreatFloatButton;
    BOOL isS1On;
    BOOL isS2On;
    BOOL isS3On;
    BOOL isS4On;
    BOOL isS5On;
    BOOL isS7On;
    BOOL isS9On;
    BOOL isS10On;
    BOOL isS11On;
    UIButton * floatButton;
    MMTabBarController * _tabBarViewController;
    MoreViewController * _moreViewController;
    BOOL isMoreViewController;
    id shakeItem;
    NSString * shakeSence;
    BOOL isShakeDone;
    NSString * sayHelloString;
    id tmpNearByUserInfo;
    int tmpNearByUserNum;
    BOOL isGetUserInfo;
    BOOL isCanUserInfo;
    WCActionSheet * _actionSheet;
    int nearbyType;
    int totalCount;
    BOOL isAddFriendSent;
    NSString * removeFriendNumberKey;
    BOOL isTmpUser;
    NSString * userInfoWithName;
    NSString * userInfoWithPWD;
    int chatRoomCount;
    int chatRoomTag;
    BOOL isAddFirendBegin;
    NSString * videoString;
    NSMutableArray * _friendArray;
    MMMassSendContactSelectorViewController * _massViewController;
    NSMutableDictionary * _friendContactDic;
    NSMutableDictionary * _sharefriendContactDic;
    NSMutableDictionary * _groupContactDic;
    SessionSelectView * _sessionSelectView;
    BOOL _isUpdataInfo;
    BOOL _isPushUserInfo;
    SessionSelectController * _sessionSelectViewController;
    MassSendContentLogicController * _massSendContentLogicController;
}


@property (nonatomic, assign) BOOL isAddFirendBegin;
@property (nonatomic, assign) BOOL isCheckDone;
@property (nonatomic, assign) BOOL isNotFriend;
@property (nonatomic, assign) BOOL isRemoveFriend;
@property (nonatomic, assign) int dataNumber;
@property (nonatomic, assign) int chatRoomCount;
@property (nonatomic, assign) int chatRoomTag;
@property (nonatomic, assign) BOOL isCreatFloatButton;
@property (nonatomic, assign) BOOL isS1On;
@property (nonatomic, assign) BOOL isS2On;
@property (nonatomic, assign) BOOL isS3On;
@property (nonatomic, assign) BOOL isS4On;
@property (nonatomic, assign) BOOL isS5On;
@property (nonatomic, assign) BOOL isS7On;
@property (nonatomic, assign) BOOL isS9On;
@property (nonatomic, assign) BOOL isS10On;
@property (nonatomic, assign) BOOL isS11On;
@property (nonatomic, assign) BOOL isS12On;
@property (nonatomic, assign) BOOL isS13On;
@property (nonatomic, strong) UIButton * floatButton;
@property (nonatomic, strong) id shakeItem;
@property (nonatomic, strong) NSString * shakeSence;
@property (nonatomic, strong) NSString * sayHelloString;
@property (nonatomic, strong) NSString * videoString;
@property (nonatomic, strong) NSString * userInfoWithName;
@property (nonatomic, strong) NSString * userInfoWithPWD;
@property (nonatomic, strong) NSString * removeFriendNumberKey;
@property (nonatomic, strong) WCActionSheet * actionSheet;
@property (nonatomic, strong) MMTabBarController * tabBarViewController;
@property (nonatomic, strong) MoreViewController * moreViewController;
@property (nonatomic, assign) BOOL isShakeDone;
@property (nonatomic, assign) BOOL isTmpUser;
@property (nonatomic, assign) BOOL isMoreViewController;
@property (nonatomic, assign) id tmpNearByUserInfo;
@property (nonatomic, assign) int tmpNearByUserNum;
@property (nonatomic, assign) int nearbyType;
@property (nonatomic, assign) BOOL isGetUserInfo;
@property (nonatomic, assign) BOOL isCanUserInfo;
@property (nonatomic, assign) int totalCount;
@property (nonatomic, assign) BOOL isAddFriendSent;
@property (nonatomic, strong) SessionSelectView * sessionSelectView;
@property (nonatomic, strong) MMMassSendContactSelectorViewController * massViewController;
@property (nonatomic, strong) NSMutableArray * friendArray;
@property (nonatomic, strong) NSMutableDictionary * friendContactDic;
@property (nonatomic, strong) NSMutableDictionary * sharefriendContactDic;
@property (nonatomic, strong) NSMutableDictionary * groupContactDic;
@property (nonatomic, assign) BOOL isUpdataInfo;
@property (nonatomic, assign) BOOL isPushUserInfo;
@property (nonatomic, strong) SessionSelectController * sessionSelectViewController;
@property (nonatomic, strong) MassSendContentLogicController * massSendContentLogicController;
@property (nonatomic, assign)int addGroupNum;
@property (nonatomic, assign)int senMessageCount;
@property (nonatomic, assign)int sendImgCount;
@property (nonatomic, strong)WeixinContentLogicController * logicController;
@property (nonatomic, strong)CMessageMgr * globalMessageMgr;
@property (nonatomic, strong)CContact * atContact;
@property (nonatomic, strong)NSMutableDictionary *addGroupDict;
@property (nonatomic, strong)NSArray *locationArray;


+ (instancetype)sharedInstance;
- (void)getTabBarViewWith:(MMTabBarController *)viewController;
- (id)getTabBarViewController;
- (void)getMoreViewControllerWith:(MoreViewController *)viewController;
- (id)getMoreViewController;
- (void)getActionSheetWith:(WCActionSheet *)viewController;
- (id)getActionSheet;
- (void)buildFloatCloseButton;
- (void)pushToolsViewController:(id)arg2;
- (UITableViewCell *)buildToolsCellWith:(id)arg2;
- (void)openWeMediaToolsWithViewController:(FindFriendEntryViewController *)viewController;
- (void)doAddFriendAction:(CBaseContactInfoAssist *)infoAssist;
- (void)doDelegateFriendAction:(SayHelloDataLogic *)dataLogic andCellNum:(NSInteger)num;
- (NSString *)getRemoveUserFileAdress;
- (void)saveRemoveUserInfo:(NSString *)userID AndValue:(NSString *)numValue;
- (void)registerNotification;
- (void)removeNotification;
- (void)saveFriend:(NSMutableArray *)array;
- (void)saveFriendContactDic:(NSDictionary *)dict;
- (int)totalSectionWithArray:(NSMutableArray *)array;
- (void)jumpToFriendListViewController;
- (void)holdMMMassSendContactSelectorViewController:(MMMassSendContactSelectorViewController *)viewC;
- (void)holdMassSendContentLogicController:(MassSendContentLogicController *)viewC;
- (void)holdSessionSelectView:(SessionSelectView *)viewC;
- (void)holdSessionSelectController:(SessionSelectController *)viewC;
- (void)jumpToSelectListViewController;
- (int)totalSectionWithDictionary:(NSMutableDictionary *)dict;
- (void)addShareUserInfo :(int)count;
- (void)shareVideoAndMassMessage;
- (void)holdWeixinContentLogicController:(WeixinContentLogicController *)logVC;
- (void)holdCMessageMgr:(CMessageMgr *)mgr;
- (void)sendMessage:(CMessageWrap *)arg2;
- (void)getAtCContactWith:(CContact *)contact;
- (void)userSendImageReturnMessage:(CMessageWrap *)arg2;
- (void)showThirtyCountImageWith:(CMessageWrap *)arg2;

@end
