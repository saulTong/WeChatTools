#import "WeChat/CBaseContactInfoAssist.h"
#import "WeChat/SayHelloDataLogic.h"


@interface SaulWeChatAddFriend : NSObject
{
    BOOL isAddFriend;
    int totalCount;
    BOOL isAddFriendSent;
}

@property (nonatomic, assign) BOOL isAddFriend;
@property (nonatomic, assign) int totalCount;
@property (nonatomic, assign) BOOL isAddFriendSent;

+(instancetype)sharedInstance;
-(void) doAddFriendAction:(CBaseContactInfoAssist *)infoAssist;
-(void) doDelegateFriendAction:(SayHelloDataLogic *)dataLogic andCellNum:(NSInteger)num;
//- (void)addUserDataWith:(id)userData withNum:(int)num;


@end
