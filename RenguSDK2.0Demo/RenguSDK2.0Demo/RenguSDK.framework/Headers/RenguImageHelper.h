//
//  RenguImageHelper.h
//  RenguSDKProject
//
//  Created by mac on 16/7/1.
//  Copyright © 2016年 hymac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RenguImageHelper : NSObject

/**
 *  压缩图片质量
 *
 *  @param image
 *  @param percent 压缩比例 0-1
 *
 *  @return
 */
+ (UIImage *)reduceImage:(UIImage *)image percent:(float)percent;

/**
 *  缩放图片尺寸
 *
 *  @param image
 *  @param newSize 新的尺寸
 *
 *  @return
 */
+ (UIImage *)imageWithImageSimple:(UIImage *)image scaledToSize:(CGSize)newSize;

@end
