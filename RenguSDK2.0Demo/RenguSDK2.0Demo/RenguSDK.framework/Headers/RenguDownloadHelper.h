//
//  RenguDownloadHelper.h
//  RenguSDKProject
//
//  Created by mac on 16/6/15.
//  Copyright © 2016年 hymac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RenguDownloadHelper : NSObject

/* 是否使用本地的CA证书用于https的签名验证 */
@property (assign, nonatomic) BOOL useLocalCer;
/**
 *  获得RenguDownloadHelper单例
 *
 *  @return
 */
+ (instancetype)shareHelper;


/**
 *  返回当前已经添加的未完成的下载任务信息
 *
 *  @return
 */
- (NSDictionary *)getDownloadInfo;

/**
 *  添加一个支持自动断点续传的下载任务
 *
 *  @param urlString
 */
- (BOOL)addAutoResumeDownloadTask:(NSString *)urlString;

/**
 *  移除一个支持自动断点续传的下载任务
 *
 *  @param urlString
 */
- (BOOL)removeAutoResumeDownloadTask:(NSString *)urlString;


/**
 *  下载任务
 *
 *  @param urlString             下载链接字符串
 *  @param downloadProgressBlock 回调进度block
 *  @param destination           下载完毕的路径字符串如果不设置默认为Documents/rengu/download/response.suggestedFilename
 *  @param completionHandler     下载完成的回调
 *
 *  @return
 */
- (NSURLSessionDownloadTask *)httpDownloadTask:(NSString *)urlString
                                      progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                                   destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                             completionHandler:(void (^)(NSURLResponse *response, NSURL * filePath, NSError * error))completionHandler;


// 获取设备硬盘总大小
- (NSNumber *)totalDiskSpace;

// 获取设备硬盘剩余大小
- (NSNumber *)freeDiskSpace;

@end
