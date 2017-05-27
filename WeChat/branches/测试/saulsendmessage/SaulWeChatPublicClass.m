
#import "SaulWeChatPublicClass.h"
#import <objc/runtime.h>




@implementation SaulWeChatPublicClass

@synthesize friendArray,massViewController,friendContactDic,sessionSelectView,groupContactDic,isUpdataInfo;

+ (instancetype)sharedInstance {
    
    static dispatch_once_t once;
    static SaulWeChatPublicClass *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[SaulWeChatPublicClass alloc] init];
    });
    
    return sharedInstance;
}

- (void)holdSessionSelectView:(SessionSelectView *)viewC {
    if (_sessionSelectView) {
        _sessionSelectView = nil;
    }
    self.sessionSelectView = [viewC retain];
}

- (void)holdMMMassSendContactSelectorViewController:(MMMassSendContactSelectorViewController *)viewC {
    if (_massViewController) {
        _massViewController = nil;
    }
    _massViewController = [viewC retain];
}

- (void)saveFriend:(NSMutableArray *)array {
    if (!_friendArray) {
        _friendArray = [[NSMutableArray arrayWithCapacity:array.count] mutableCopy];
    }
    _friendArray = [NSMutableArray arrayWithObject:array];
    
}

- (void)saveFriendContactDic:(NSDictionary *)dict {
    _friendContactDic =  [NSMutableDictionary dictionary];
    [_friendContactDic addEntriesFromDictionary:dict];
    self.friendContactDic = _friendContactDic;
    [self updataUserInfo:self.friendContactDic];
    
}

- (void)updataUserInfo:(NSMutableDictionary *)dict {
    if (!self.groupContactDic) {
        self.groupContactDic = [[NSMutableDictionary alloc] init];
    } else {
        [self.groupContactDic removeAllObjects];
    }
    for (NSString * key in [dict allKeys]) {
        if ([key hasSuffix:@"@chatroom"]) {                     // 群
            [self.groupContactDic setValue:[dict objectForKey:key] forKey:key];
            [self.friendContactDic removeObjectForKey:key];
        } else if ([key hasPrefix:@"gh_"]) {                    // 公众号
            [self.friendContactDic removeObjectForKey:key];
        } else if ([key isEqualToString:@"iwatchholder"] || [key isEqualToString:@"weixin"] || [key isEqualToString:@"notification_messages"]) {    // 系统
            [self.friendContactDic removeObjectForKey:key];
        }
    }
}

- (int)totalSectionWithArray:(NSMutableArray *)array {
    
    int count = array.count / 200;
    int mCount = array.count % 200;
    
    if (mCount > 0) {
        count += 1;
    }
    
    return count;
}

- (void)registerNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectDoneAndJump:) name:@"MASS_SEND_MESSAGE" object:nil];
}

- (void)removeNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MASS_SEND_MESSAGE" object:nil];
}

- (void)jumpToFriendListViewController {
    MassTableViewController * viewController = [[MassTableViewController alloc] init];
    [_massViewController presentViewController:viewController animated:YES completion:nil];
}

- (void)selectDoneAndJump:(NSNotification *)notification {
    [self addMassUserInfo:[[notification object] integerValue]];
}

- (void)addMassUserInfo:(int)count {
    NSMutableSet *set = [NSMutableSet setWithCapacity:200];
    
    int num = (count + 1) * 200;
    
    if (num > self.friendArray.count) {
        num -= num;
        int tmp = self.friendArray.count % 200;
        for (int i = 0; i < tmp; i++) {
            int tmpNum = num * 200 + i;
            [set addObject:self.friendArray[tmpNum]];
        }
    } else {
        for (int i = 0; i < 200; i++) {
            int tmpNum = count * 200 + i;
            [set addObject:self.friendArray[tmpNum]];
        }
    }
    _massViewController.setSelectedContacts = set;

    [_massViewController onDone:nil];
}












@end


