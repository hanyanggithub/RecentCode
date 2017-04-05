//
//  RenguDeviceManager.h
//  RenguSDK
//
//  Created by hymac on 16/1/6.
//  Copyright (c) 2016年 rengukeji. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  人谷SDK设备信息操作对象
 */
@interface RenguDeviceManager : NSObject

/* 判断手机是否越狱 */
+ (BOOL)phoneJailBreak;

/* 获取设备硬件信息 */
+ (NSDictionary *)getDeviceInfo;

@end
