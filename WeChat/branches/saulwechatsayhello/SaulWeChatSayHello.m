#import "SaulWeChatSayHello.h"


@implementation SaulWeChatSayHello

+(instancetype)sharedInstance {
    
    static dispatch_once_t once;
    static SaulWeChatSayHello *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[SaulWeChatSayHello alloc] init];
    });
    return sharedInstance;
}

- (void)setDataDictWith:(id)arg1 andScene:(NSString *)arg2
{
    self.dataDic = @{@"item" : arg1,
                     @"scene": arg2};
}
- (void)removeDataDic
{
    self.dataDic = nil;
}

@end
