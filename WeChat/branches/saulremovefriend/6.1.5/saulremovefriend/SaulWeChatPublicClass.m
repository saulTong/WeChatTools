
#import "SaulWeChatPublicClass.h"

@implementation SaulWeChatPublicClass


@synthesize isCheckDone;
@synthesize isNotFriend;
@synthesize isRemoveFriend;
@synthesize isGetUserList;
@synthesize dataNumber;
@synthesize removeFriendNumberKey;

+ (instancetype)sharedInstance {
    
    static dispatch_once_t once;
    static SaulWeChatPublicClass *sharedInstance = nil;
    dispatch_once(&once, ^{
        sharedInstance = [[SaulWeChatPublicClass alloc] init];
    });
    
    return sharedInstance;
}





@end
