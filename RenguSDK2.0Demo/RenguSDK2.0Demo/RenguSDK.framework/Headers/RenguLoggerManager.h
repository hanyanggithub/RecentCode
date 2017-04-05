//
//  RenguLoggerManager.h
//  RenguSDKProject
//
//  Created by mac on 16/7/1.
//  Copyright © 2016年 hymac. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RenguLoggerManagerDelegate <NSObject>
@optional
/**
 *  监听到crash
 *
 *  @param exception
 */
- (void)didMonitoredException:(NSException *)exception;

@end


@interface RenguLoggerManager : NSObject

/**
 *  单例
 *
 *  @return
 */
+ (instancetype)sharedManager;

/**
 *  监听异常(app didFinishLaunchingWithOptions)
 *
 *  @param delegate
 */
- (void)monitorExceptionWithDelegate:(id<RenguLoggerManagerDelegate>)delegate;

/**
 *  开始监听卡塞(app didFinishLaunchingWithOptions)
 *
 *  @param block 卡塞发生回调block
 */
- (void)startMonitorBlockWithBlock:(void(^)(NSArray *message))block;

/**
 *  停止监听卡塞
 */
- (void)stopMonitorBlock;

@end
