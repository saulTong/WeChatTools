#import "WeChat/CBaseContactInfoAssist.h"
#import "WeChat/SayHelloDataLogic.h"


@interface SaulWeChatAddFriend : NSObject
@property (nonatomic, assign) BOOL isAddFriend;
@property (nonatomic, assign) int totalCount;
@property (nonatomic, assign) BOOL isAddFriendSent;

+(instancetype)sharedInstance;
- (void)doAddFriendAction:(CBaseContactInfoAssist *)infoAssist;
- (void)doDelegateFriendAction:(SayHelloDataLogic *)dataLogic andCellNum:(NSInteger)num;


@end
