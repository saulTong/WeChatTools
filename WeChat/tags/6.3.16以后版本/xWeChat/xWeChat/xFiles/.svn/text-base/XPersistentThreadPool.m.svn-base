//
//  XPersistentThreadPool.m
//  XPersistentThreadPool
//
//  Created by _Finder丶Tiwk on 16/3/15.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "XPersistentThreadPool.h"
#pragma mark - ###线程池元素
@interface XThreadPoolItem : NSObject
@property (nonatomic,strong) NSTimer  *timer;
@property (nonatomic,strong) NSThread *thread;
@end

@implementation XThreadPoolItem
@end

////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////
#pragma mark - ### 常驻线程池
@interface XPersistentThreadPool ()
@property (nonatomic,strong) NSMutableDictionary<NSString *,XThreadPoolItem *> *threadMap;
@end

@implementation XPersistentThreadPool

static XPersistentThreadPool *__instance;
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [super allocWithZone:zone];
        __instance.threadMap = [NSMutableDictionary dictionaryWithCapacity:5];
    });
    return __instance;
}
+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [[self alloc] init];
    });
    return __instance;
}

#pragma mark - 添加一个常驻线程
- (void)addTaskThreadWithID:(NSString *)ID{
    [self addTaskThreadWithID:ID name:@"XPersistentDefaultThread"];
}

- (void)addTaskThreadWithID:(NSString *)ID name:(NSString *)name{
    [self addTaskThreadWithID:ID name:name stackSize:256];
}

- (void)addTaskThreadWithID:(NSString *)ID name:(NSString *)name stackSize:(NSUInteger)stackSize{
    [self addTaskThreadWithID:ID name:name stackSize:stackSize priority:NSQualityOfServiceBackground];
}

- (void)addTaskThreadWithID:(NSString *)ID name:(NSString *)name stackSize:(NSUInteger)stackSize priority:(NSQualityOfService)priority{
    NSParameterAssert(ID);
    NSParameterAssert(name);
    NSAssert(stackSize >= 16 , @"stackSize 最小应该为16KB");
    NSAssert(stackSize <= 512, @"stackSize 最大应该为512KB");
    NSAssert(stackSize%4 == 0, @"stackSize 应该为4的倍数");
    
    NSThread *taskThread = [[NSThread alloc] initWithTarget:self selector:@selector(taskRun) object:nil];
    taskThread.name             = name;
    taskThread.stackSize        = stackSize*1024;
    taskThread.qualityOfService = priority;
    [taskThread start];
    
    XThreadPoolItem *item = [XThreadPoolItem new];
    item.thread = taskThread;
    [_threadMap setObject:item forKey:ID];
}

#pragma mark - 其它方法
- (NSThread *)threadWithID:(NSString *)ID{
    NSParameterAssert(ID);
    return [_threadMap valueForKey:ID].thread;
}

- (void)removeThreadWithID:(NSString *)ID{
    NSParameterAssert(ID);
    XThreadPoolItem *poolItem = [_threadMap valueForKey:ID];
    if (poolItem) {
        // 1.退出线程
        NSThread *specifyThread = poolItem.thread;
        if (specifyThread) {
            [specifyThread cancel];
        }
        // 2.停止定时器
        NSTimer *timer = poolItem.timer;
        if (timer) {
            [timer invalidate];
            timer = nil;
        }
        // 3.将item从池中移除
        [_threadMap removeObjectForKey:ID];
    }
}

- (void)removeAllThread{
    [_threadMap enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, XThreadPoolItem * _Nonnull obj, BOOL * _Nonnull stop) {
        // 1.退出线程
        NSThread *specifyThread = obj.thread;
        if (specifyThread) {
            [specifyThread cancel];
        }
        // 2.停止定时器
        NSTimer *timer = obj.timer;
        if (timer) {
            [timer invalidate];
            timer = nil;
        }
        [_threadMap removeObjectForKey:key];
    }];
}

#pragma mark - 具体实现
#pragma mark  普通任务的实现
- (BOOL)executeTask:(void (^)())task withID:(NSString *)ID{
    NSParameterAssert(task);
    NSThread *specifyThread = [self threadWithID:ID];
    if (specifyThread) {
        [self performSelector:@selector(executeTask:) onThread:specifyThread withObject:task waitUntilDone:NO];
        return YES;
    }else{
        NSLog(@"此ID(%@)对应的线程不存在",ID);
        return NO;
    }
}

- (void)executeTask:(void (^)())task{
    task();
}

#pragma mark 定时任务的实现
- (BOOL)executeTask:(void (^)())task withID:(NSString *)ID interval:(NSTimeInterval)interval{
    return [self executeTask:task withID:ID interval:interval delay:0];
}
- (BOOL)executeTask:(void (^)())task withID:(NSString *)ID interval:(NSTimeInterval)interval delay:(NSTimeInterval)delay{
    return [self executeTask:task withID:ID interval:interval delay:delay repeat:NO];
}

- (BOOL)executeTask:(void (^)())task withID:(NSString *)ID interval:(NSTimeInterval)interval delay:(NSTimeInterval)delay repeat:(BOOL)repeat{
    NSParameterAssert(task);
    NSParameterAssert(ID);
    XThreadPoolItem *item = [_threadMap valueForKey:ID];
    NSThread *specifyThread = item.thread;
    if (specifyThread) {
        NSTimer *timer = [[NSTimer alloc] initWithFireDate:[NSDate dateWithTimeIntervalSinceNow:delay] interval:interval target:self selector:@selector(runTimer:) userInfo:@{@"task":task} repeats:repeat];
        item.timer = timer;
        
        [self performSelector:@selector(executeTimer:) onThread:specifyThread withObject:timer waitUntilDone:NO];
        return YES;
    }else{
        NSLog(@"此ID(%@)对应的线程不存在",ID);
        return NO;
    }
}

- (void)executeTimer:(NSTimer *)timer{
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (void)runTimer:(NSTimer *)timer{
    void (^task)() = timer.userInfo[@"task"];
    task();
}

- (void)taskRun{
    @autoreleasepool {
        NSLog(@"启动%@线程中的Runloop",[NSThread currentThread].name);
        [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
    }
}

////////////////////////////////////////////////////////////////
/////////////////////请干了这碗心灵鸡汤////////////////////////////

// 1.任务执行完成,线程就消亡了 #issue: attempt to start the thread again

// 2.This value must be in bytes and a multiple of 4KB.minimum 16KB default 512KB subThread  ,1M mainThread

// 3.线程创建大约消耗90毫秒

// 4.NSRunLoop[Set<CFRunLoopSourceRef>,Array<CFRunLoopTimerRef>,Array<CFRunLoopObserverRef>],如果RunLoop当前模式里没有 Source Timer runLoop就退出了

// 5.CFRunLoopSourceRef 事件源(performSelector,点击触摸事件等)
//      Source1 -->Source0
//      Source0(应用程序内部发出的事件)
//      Source1(内核系统线程发出的事件)

// 6.常见的几种RunLoop模式：NSDefaultRunLoopMode,UITrackingRunLoopMode,NSDefaultRunLoopMode

// 7.autoreleasepool 在runLoop开启时(kCFRunLoopEntry)创建,休眠前(kCFRunLoopBeforeWaiting)销毁并创建,退出时(kCFRunLoopExit)再销毁

// 8.CFRunLoopObserverRef 负责监听RunLoop状态
//- (void)note_CFRunLoopObserverRef{
//    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
//        switch (activity) {
//            case kCFRunLoopEntry: {// 即将进入Loop(1UL << 0)
//                NSLog(@"runLoop进入< %@ >状态",@"kCFRunLoopEntry");
//                break;
//            }
//            case kCFRunLoopBeforeTimers: {// 即将处理 Timer(1UL << 1)
//                NSLog(@"runLoop进入< %@ >状态",@"kCFRunLoopBeforeTimers");
//                break;
//            }
//            case kCFRunLoopBeforeSources: {// 即将处理 Source(1UL << 2)
//                NSLog(@"runLoop进入< %@ >状态",@"kCFRunLoopBeforeSources");
//                break;
//            }
//            case kCFRunLoopBeforeWaiting: {// 即将进入休眠(1UL << 5)
//                NSLog(@"runLoop进入< %@ >状态",@"kCFRunLoopBeforeWaiting");
//                break;
//            }
//            case kCFRunLoopAfterWaiting: {// 刚从休眠中唤醒(1UL << 6)
//                NSLog(@"runLoop进入< %@ >状态",@"kCFRunLoopAfterWaiting");
//                break;
//            }
//            case kCFRunLoopExit: {// 即将退出Loop(1UL << 7)
//                //RunLoop发生意外或超时时会进入,所以基本不会退出
//                NSLog(@"runLoop进入< %@ >状态",@"kCFRunLoopExit");
//                break;
//            }
//            case kCFRunLoopAllActivities: {// 监听所有状态(0x0FFFFFFFU)
//                NSLog(@"runLoop进入< %@ >状态",@"kCFRunLoopAllActivities");
//                break;
//            }
//        }
//    });
//    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
//    CFRelease(observer);
//}

@end
