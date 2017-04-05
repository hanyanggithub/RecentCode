//
//  RenguPackManager.h
//  8583
//
//  Created by hymac on 15/12/29.
//  Copyright © 2015年 rengukeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RenguPackObject.h"

/**
 *  人谷SDK报文操作对象
 */
@interface RenguPackManager : NSObject

/**
*  生成8583报文
*
*  @param parameters RenguPackObject对象包装参数信息，将相关参数赋值给该对象后调用此方法
*
*  @return pack8583
*/
- (NSString *)packetWithParameters:(RenguPackObject *)parameters;



/**
 *  解析8583报文
 *
 *  @param packString 8583报文字符串
 *
 *  @return 解包结束或者解析出错后的模型对象
 */
- (RenguPackObject *)unpackWithString:(NSString *)packString;



@end
