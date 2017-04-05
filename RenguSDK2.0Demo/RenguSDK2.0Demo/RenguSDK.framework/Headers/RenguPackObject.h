//
//  RenguPackObject.h
//  8583
//
//  Created by hymac on 15/12/29.
//  Copyright (c) 2015年 rengukeji. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  报文信息对象
 */
@interface RenguPackObject : NSObject


@property (strong,nonatomic)NSArray *domains;                         // 存在的域数组
@property (strong,nonatomic)NSDictionary *domainsDatas;               // 域的原数据(解析时压缩之前的数据)
@property (strong,nonatomic)NSError *error;                           // 错误信息(解析发生错误时会出现，信息为当前发生错误的域名)

@property (copy,nonatomic)NSString *tpdu;                             // TPDU
@property (copy,nonatomic)NSString *packHeader;                       // 报文头
@property (copy,nonatomic)NSString *msgType;                          // 消息类型
@property (copy,nonatomic)NSString *bitMap;                           // 位图

/********************* 以下属性为域的数据  **********************/
@property (copy,nonatomic)NSString *domain_02;                        // 域 2  主账号
@property (copy,nonatomic)NSString *domain_03;                        // 域 3  交易处理码
@property (copy,nonatomic)NSString *domain_04;                        // 域 4  交易金额
@property (copy,nonatomic)NSString *domain_11;                        // 域 11 受卡方系统跟踪号
@property (copy,nonatomic)NSString *domain_12;                        // 域 12 受卡方所在地时间
@property (copy,nonatomic)NSString *domain_13;                        // 域 13 受卡方所在地日期
@property (copy,nonatomic)NSString *domain_14;                        // 域 14 卡有效期
@property (copy,nonatomic)NSString *domain_15;                        // 域 15 清算日期
@property (copy,nonatomic)NSString *domain_22;                        // 域 22 服务点输入方式码
@property (copy,nonatomic)NSString *domain_23;                        // 域 23 卡序列号
@property (copy,nonatomic)NSString *domain_25;                        // 域 25 服务点条件码
@property (copy,nonatomic)NSString *domain_26;                        // 域 26 服务点 PIN 获取码
@property (copy,nonatomic)NSString *domain_32;                        // 域 32 受理机构标识码
@property (copy,nonatomic)NSString *domain_35;                        // 域 35 2 磁道数据
@property (copy,nonatomic)NSString *domain_36;                        // 域 36 3 磁道数据
@property (copy,nonatomic)NSString *domain_37;                        // 域 37 检索参考号
@property (copy,nonatomic)NSString *domain_38;                        // 域 38 授权标识应答码
@property (copy,nonatomic)NSString *domain_39;                        // 域 39 应答码
@property (copy,nonatomic)NSString *domain_41;                        // 域 41 受卡机终端标识码
@property (copy,nonatomic)NSString *domain_42;                        // 域 42 受卡方标识码
@property (copy,nonatomic)NSString *domain_44;                        // 域 44 附加响应数据
@property (copy,nonatomic)NSString *domain_48;                        // 域 48 附加数据-私有
@property (copy,nonatomic)NSString *domain_49;                        // 域 49 交易货币代码
@property (copy,nonatomic)NSData   *domain_52;                        // 域 52 个人标识码数据
@property (copy,nonatomic)NSString *domain_53;                        // 域 53 安全控制信息
@property (copy,nonatomic)NSString *domain_54;                        // 域 54 余额
@property (copy,nonatomic)NSData   *domain_55;                        // 域 55 IC 卡数据域
@property (copy,nonatomic)NSString *domain_58;                        // 域 58 PBOC 电子钱包标准的交易信息
@property (copy,nonatomic)NSString *domain_60;                        // 域 60 自定义域
@property (copy,nonatomic)NSString *domain_61;                        // 域 61 原始信息域
@property (copy,nonatomic)NSData   *domain_62;                        // 域 62 自定义域
@property (copy,nonatomic)NSData   *domain_63;                        // 域 63 自定义域
@property (copy,nonatomic)NSString *domain_64;                        // 域 64 报文鉴别码



@end
