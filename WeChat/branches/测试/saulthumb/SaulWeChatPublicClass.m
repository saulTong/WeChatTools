
#import "SaulWeChatPublicClass.h"


@implementation SaulWeChatPublicClass

+(instancetype)sharedInstance {
    
    static dispatch_once_t once;
    static SaulWeChatPublicClass *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[SaulWeChatPublicClass alloc] init];
    });
    
    return sharedInstance;
}

- (void)addDataItemWihtKey:(NSString *)key andValue:(id)value
{
    if (!_dataItem) {
        _dataItem = [[NSMutableDictionary alloc] init];
    }
    [_dataItem setValue:value forKey:key];
}

- (void)removeDataIeamWihtKey:(NSString *)key
{
    [_dataItem removeObjectForKey:key];
}

- (void)removeDataItem
{
    [_dataItem removeAllObjects];
}


@end
