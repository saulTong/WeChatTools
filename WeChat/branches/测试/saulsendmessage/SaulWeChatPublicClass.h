#import "WeChat/MassTableViewController.h"
#import "WeChat/MMMassSendContactSelectorViewController.h"
#import "WeChat/SessionSelectView.h"


@interface SaulWeChatPublicClass : NSObject
{
    NSMutableArray * _friendArray;
    MMMassSendContactSelectorViewController * _massViewController;
    NSMutableDictionary * _friendContactDic;
    NSMutableDictionary * _groupContactDic;
    SessionSelectView * _sessionSelectView;
    BOOL _isUpdataInfo;

}
@property (nonatomic, strong) SessionSelectView * sessionSelectView;
@property (nonatomic, strong) MMMassSendContactSelectorViewController * massViewController;
@property (nonatomic, strong) NSMutableArray * friendArray;
@property (nonatomic, strong) NSMutableDictionary * friendContactDic;
@property (nonatomic, strong) NSMutableDictionary * groupContactDic;
@property (nonatomic, assign) BOOL isUpdataInfo;
+ (instancetype)sharedInstance;

- (void)registerNotification;

- (void)removeNotification;

- (void)saveFriend:(NSMutableArray *)array;

- (void)saveFriendContactDic:(NSDictionary *)dict;

- (int)totalSectionWithArray:(NSMutableArray *)array;

- (void)jumpToFriendListViewController;

- (void)holdMMMassSendContactSelectorViewController:(MMMassSendContactSelectorViewController *)viewC;

- (void)holdSessionSelectView:(SessionSelectView *)viewC;


@end


