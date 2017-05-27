

@interface SaulWeChatPublicClass : NSObject


@property (nonatomic, strong) NSMutableDictionary * dataItem;

@property (nonatomic, assign) BOOL isThumbOn;
+(instancetype)sharedInstance;

- (void)addDataItemWihtKey:(NSString *)key andValue:(id)value;
    
- (void)removeDataIeamWihtKey:(NSString *)key;
    
- (void)removeDataItem;

@end
