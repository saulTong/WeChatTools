#import "WeChat/CMessageWrap.h"
#import "WeChat/CMessageMgr.h"
#import "WeChat/WeixinContentLogicController.h"
#import "WeChat/CContact.h"




@interface SaulWeChatPublicClass : NSObject
@property (nonatomic, assign)int addGroupNum;
@property (nonatomic, assign)int senMessageCount;
@property (nonatomic, strong)WeixinContentLogicController * logicController;
@property (nonatomic, strong)CMessageMgr * globalMessageMgr;
@property (nonatomic, strong)CContact * atContact;
@property (nonatomic, strong)NSMutableDictionary *addGroupDict;

+ (instancetype)sharedInstance;
- (void)holdWeixinContentLogicController:(WeixinContentLogicController *)logVC;
- (void)holdCMessageMgr:(CMessageMgr *)mgr;
- (void)sendMessage:(CMessageWrap *)arg2;
- (void)getAtCContactWith:(CContact *)contact;
- (void)userSendImageReturnMessage:(CMessageWrap *)arg2;
@end


