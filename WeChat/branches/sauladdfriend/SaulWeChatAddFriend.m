#import "SaulWeChatAddFriend.h"


@implementation SaulWeChatAddFriend
@synthesize isAddFriend;

+(instancetype)sharedInstance {
    
    static dispatch_once_t once;
    static SaulWeChatAddFriend *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[SaulWeChatAddFriend alloc] init];
    });
    return sharedInstance;
}


@end
