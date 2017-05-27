#import "SaulWeChatAddFriend.h"

@implementation SaulWeChatAddFriend
@synthesize isAddFriend;
@synthesize totalCount;
@synthesize isAddFriendSent;

+ (instancetype)sharedInstance {
    
    static dispatch_once_t once;
    static SaulWeChatAddFriend *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[SaulWeChatAddFriend alloc] init];
    });
    return sharedInstance;
}

- (void) doAddFriendAction:(CBaseContactInfoAssist *)infoAssist
{
    [infoAssist onVerifyContactOk];
    self.isAddFriendSent = YES;
}

-(void) doDelegateFriendAction:(SayHelloDataLogic *)dataLogic andCellNum:(NSInteger) num
{
    [dataLogic clearMsg:3 ForIndex:num];
}

//- (void)addUserDataWith:(id)userData withNum:(int)num
//{
//    if (!self.dataDic) {
//        self.dataDic = [NSMutableDictionary dictionaryWithCapacity:(self.totalCount ? self.totalCount : 100)];
//    }
//    [self.dataDic setValue:userData forKey:[NSString stringWithFormat:@"%d",num]];
//}



//- (void)addFriendClass
//{
//    NSLog(@"totalCount is %d",self.totalCount);
//    for (int i = 0 ; i < self.totalCount; i++) {
//        
//        [self OnSayHelloDataVerifyContactOK:[self getContactForIndex:i]];
//    }
//}








@end
