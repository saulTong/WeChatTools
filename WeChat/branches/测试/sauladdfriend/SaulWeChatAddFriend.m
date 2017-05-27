#import "SaulWeChatAddFriend.h"

@implementation SaulWeChatAddFriend

+ (instancetype)sharedInstance {
    
    static dispatch_once_t once;
    static SaulWeChatAddFriend *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[SaulWeChatAddFriend alloc] init];
    });
    return sharedInstance;
}

- (void)doAddFriendAction:(CBaseContactInfoAssist *)infoAssist {
    [infoAssist onVerifyContactOk];
    self.isAddFriendSent = YES;
}

- (void)doDelegateFriendAction:(SayHelloDataLogic *)dataLogic andCellNum:(NSInteger)num {
    [dataLogic clearMsg:3 ForIndex:num];
}









@end
