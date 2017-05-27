//
//  XPersistentThreadPool.h
//  XPersistentThreadPool
//
//  Created by _Finder丶Tiwk on 16/3/15.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  @author _Finder丶Tiwk, 16-03-15 13:03:23
 *
 *  @brief 常驻线程池
 *  @since v1.0.0
 */
@interface XPersistentThreadPool : NSObject

+ (instancetype)shareInstance;

/**
 *  @author _Finder丶Tiwk, 16-03-15 12:03:44
 *
 *  @brief 向线程池中加入一个常驻线程
 *  @param ID         线程唯一标识,用于获取指定线程
 *  @param name       线程名称 default is XPersistentDefaultThread
 *  @param stackSize  线程栈空间大小 此值应该为4的倍数 最小16KB 最大 512KB default is 256KB
 *  @param priority   线程优先级 default is NSQualityOfServiceBackground
 *  @since v1.0.0
 */
- (void)addTaskThreadWithID:(NSString *)ID;
- (void)addTaskThreadWithID:(NSString *)ID name:(NSString *)name;
- (void)addTaskThreadWithID:(NSString *)ID name:(NSString *)name stackSize:(NSUInteger)stackSize;
- (void)addTaskThreadWithID:(NSString *)ID name:(NSString *)name stackSize:(NSUInteger)stackSize priority:(NSQualityOfService)priority;

/*! 从线程池中删除ID对应的线程*/
- (void)removeThreadWithID:(NSString *)ID;
/*! 删除所有线程*/ 
- (void)removeAllThread;

/*! 从线程池中获取ID对应的线程*/
- (NSThread *)threadWithID:(NSString *)ID;

/**
 *  @author _Finder丶Tiwk, 16-03-15 13:03:44
 *
 *  @brief 执行定时周期任务(若ID后面没有参数 只是执行一个普通的任务)
 *  @param task     要执行的任务
 *  @param ID       在执行任务的线程ID
 *  @param interval 执行时间间隔(单位为秒)
 *  @param delay    延时执行时间(单位为秒，默认0秒)
 *  @param repeat   是否重复执行(默认为NO执行一次)
 *  @return 是否执行成功
 *  @since v1.0.0
 */

- (BOOL)executeTask:(void(^)())task withID:(NSString *)ID;
- (BOOL)executeTask:(void(^)())task withID:(NSString *)ID interval:(NSTimeInterval)interval;
- (BOOL)executeTask:(void(^)())task withID:(NSString *)ID interval:(NSTimeInterval)interval delay:(NSTimeInterval)delay;
- (BOOL)executeTask:(void(^)())task withID:(NSString *)ID interval:(NSTimeInterval)interval delay:(NSTimeInterval)delay repeat:(BOOL)repeat;

@end
