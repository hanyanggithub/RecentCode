//
//  RenguDBManager.h
//  DBSDK
//
//  Created by hymac on 15/12/23.
//  Copyright (c) 2015年 rengukeji. All rights reserved.
//

#import <Foundation/Foundation.h>


/* 操作数据库完成后的回调 */
typedef void(^completeBlock)(BOOL result,NSArray *resultData);


/**
 *  人谷SDK数据库操作对象
 */
@interface RenguDBManager : NSObject

/* 当前操作的数据库名 default mySQlite */
@property (copy,nonatomic,readwrite)NSString *libName;

/* 当前操作的数据路径 */
@property (copy,nonatomic,readonly)NSString *DBPath;

/**
 *  DB管理单例对象
 *
 *  @return
 */
+ (RenguDBManager *)manager;


/**
 *  是否开启大批量数据操作模式(循环插入查询多条数据建议开启)
 *
 *  @param
 */
- (void)batchOptionMode:(BOOL)batch;


/**
 *  通过sql语句进行 创建表 添加数据 删除数据 修改数据的方法
 *
 *  @param sql   sql语句
 *  @return
 */
- (BOOL)executeUpdate:(NSString *)sql, ...;


/**
 *  通过sql语句进行 创建表 添加数据 删除数据 修改数据的方法
 *
 *  @param sql      sql语句
 *  @values values  匹配占位符的数组
 *  @return
 */
- (BOOL)executeUpdate:(NSString *)sql values:(NSArray *)values;


/**
 *  通过sql语句进行查询的方法
 *
 *  @param sql   sql语句
 *  @return      满足条件的结果
 */
- (NSArray *)executeSelect:(NSString *)sql,...;


/**
 *  通过sql语句进行查询的方法
 *
 *  @param sql      sql语句
 *  @values values  匹配占位符的数组
 *  @return
 */
- (NSArray *)executeSelect:(NSString *)sql values:(NSArray *)values;



/**
 *  创建表
 *
 *  @param tableName  表名
 *  @param parameter  字典中的key为需要加入的字段名，value为字段的类型（oc数据类型 媒体数据转成NSData）
 *  @param primaryKey 如果有主键 传入主键的字段名
 *
 *  @param block 回调
 */
- (void)createTableWithName:(NSString *)tableName
                  parameter:(NSDictionary *)parameter
                 primaryKey:(NSString *)primaryKey
              completeBlock:(completeBlock)block;



/**
 *  判断表是否存在
 *
 *  @param tableName 表名
 *
 *  @return 是否存在
 */
- (BOOL)isExistsTableWithName:(NSString *)tableName;




/**
 *  在已有的表中添加字段
 *
 *  @param tableName 表名
 *  @param parameter 字典中的key为需要加入的字段名，value为字段的类型（oc数据类型 媒体数据转成NSData）
 *  @param block     回调
 */
- (void)alterAddParamWithTableName:(NSString *)tableName
                         parameter:(NSDictionary *)parameter
                     completeBlock:(completeBlock)block;


/**
 *  删除表
 *
 *  @param tableName
 */
- (void)dropTableWithName:(NSString *)tableName completeBlock:(completeBlock)block;


/**
 *  插入数据
 *
 *  @param tableName 表名
 *  @param parameter 字典中的key为需要加入的字段名，value需要加入内容(oc数据类型)
 *  @param block     回调
 */
- (void)insertDataInTableWithName:(NSString *)tableName
                        parameter:(NSDictionary *)parameter
                    completeBlock:(completeBlock)block;


/**
 *  精确删除数据
 *
 *  @param tableName 表名
 *  @param parameter 字典中的key和value对应该条数据满足 key = value 可设置多个键值对达到要删除数据的唯一性
 *  @param block     回调
 */
- (void)deleteDataInTableWithName:(NSString *)tableName
                   whereParameter:(NSDictionary *)parameter
                    completeBlock:(completeBlock)block;

/**
 *  范围删除数据
 *
 *  @param tableName   表名
 *  @param rangeString 范围语句
 *  @param value       需要删除的内容
 *  @param block       回调
 */
- (void)deleteDataInTableWithName:(NSString *)tableName
                       whereRange:(NSString *)rangeString
                    completeBlock:(completeBlock)block;


/**
 *  精确修改数据
 *
 *  @param tableName       表名
 *  @param whereParameter  字典中的key和value对应该条数据满足 key = value 可设置多个键值对达到要修改数据的唯一性
 *  @param updateParameter 需要更新的数据键值对
 *  @param block           回调
 */
- (void)updateDataInTableWithName:(NSString *)tableName
                   whereParameter:(NSDictionary *)whereParameter
                  updateParameter:(NSDictionary *)updateParameter
                    completeBlock:(completeBlock)block;


/**
 *  范围修改数据
 *
 *  @param tableName       表名
 *  @param rangeString     范围语句
 *  @param updateParameter 需要更新的数据键值对
 *  @param block           回调
 */
- (void)updateDataInTableWithName:(NSString *)tableName
                       whereRange:(NSString *)rangeString
                  updateParameter:(NSDictionary *)updateParameter
                    completeBlock:(completeBlock)block;



/**
 *  精确查询数据
 *
 *  @param tableName       表名
 *  @param whereParameter  字典中的key和value对应该条数据满足 key = value 可设置多个键值对达到要查询数据的唯一性
 *  @param block           回调
 */
- (void)selectDataInTableWithName:(NSString *)tableName
                   whereParameter:(NSDictionary *)whereParameter
                    completeBlock:(completeBlock)block;



/**
 *  查询某些字段数据
 *
 *  @param tableName       表名
 *  @param parameter       数组中为要查找的字段字符串
 *  @param block           回调
 */
- (void)selectDataInTableWithName:(NSString *)tableName
                   parameterArray:(NSArray *)parameter
                    completeBlock:(completeBlock)block;



/**
 *  范围和模糊查询数据可自定义排序类型
 *
 *  @param tableName   表名
 *  @param string      范围和模糊的条件语句
 *  @param block       回调
 */
- (void)selectDataInTableWithName:(NSString *)tableName
                       whereRange:(NSString *)string
                    completeBlock:(completeBlock)block;


/**
 *  在一个范围内或模糊查询的情况下查询某些字段的数据
 *
 *  @param tableName       表名
 *  @param parameter       数组中为要查找的字段字符串
 *  @param string          范围和模糊的条件语句
 *  @param block           回调
 */
- (void)selectDataInTableWithName:(NSString *)tableName
                   parameterArray:(NSArray *)parameter
                       whereRange:(NSString *)string
                    completeBlock:(completeBlock)block;


@end
