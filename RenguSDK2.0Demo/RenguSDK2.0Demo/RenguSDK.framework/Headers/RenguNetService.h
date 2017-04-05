//
//  RenguNetService.h/Users/mac/Desktop/SDK/RenguSDKProject /RenguSDKProject.xcodeproj
//  RenguSDK
//
//  Created by hymac on 16/1/6.
//  Copyright (c) 2016年 rengukeji. All rights reserved.
//

#import <Foundation/Foundation.h>

/* 请求数据格式 */
typedef NS_ENUM(NSInteger, HttpRequestForm) {
    HttpRequestFormJson,          //请求数据为Json default
    HttpRequestFormData           //请求数据为Data
};

/* 响应数据格式 */
typedef NS_ENUM(NSInteger, HttpResponseForm) {
    HttpResponseFormJson,          //响应数据为Json default
    HttpResponseFormXml,           //响应数据为Xml
    HttpResponseFormData           //响应数据为Data
};

/* 当前网络状态 */
typedef NS_ENUM(NSInteger, NetReachabilityStatus) {
    NetReachabilityStatusWWAN,          // 手机运营商网络
    NetReachabilityStatusWiFi,          // WIFI
    NetReachabilityStatusUnknown,       // 未知网络
    NetReachabilityStatusNotReachable   // 没有可用的网络
};

/* 网络监听的回调 */
typedef void (^NetReachabilityHandler) (BOOL availableNet, NetReachabilityStatus status);
/* 网络请求任务成功的回调 */
typedef void(^DataTaskSucceed) (NSURLSessionDataTask *task, id responseObject);
/* 网络请求任务失败的回调 */
typedef void(^DataTaskFailed) (NSURLSessionDataTask *task, NSError *error);
/* 网络下载任务完成的回调 */
typedef void(^DownloadHandler) (NSURLResponse *response, NSURL *filePath, NSError *error);
/* 网络上传任务完成的回调 */
typedef void(^UploadHandler) (NSURLResponse *response, id responseObject, NSError *error);
/* 进度回调 */
typedef void(^ProgressHandler) (NSProgress *progress);


/**
 *  人谷SDK网络服务
 */
@interface RenguNetService : NSObject

@property (assign, nonatomic) HttpRequestForm requestForm;

@property (assign, nonatomic) HttpResponseForm responseForm;
/* 网络状态 */
@property (assign, nonatomic) NetReachabilityStatus status;
/* 请求超时时间 默认60 */
@property (assign, nonatomic) NSTimeInterval timeoutInterval;

/* 是否使用本地的CA证书用于https的签名验证 */
@property (assign, nonatomic) BOOL useLocalCer;


/* 快速获得一个网络服务对象 */
+ (RenguNetService *)service;


/* 获得单例网络服务对象 */
+ (RenguNetService *)sharedService;

/**
 *  监听当前网络状态
 *
 *  @param block 回调 网络可用性 当前可用网络类型
 */
- (void)netReachabilityNetReachabilityHandler:(NetReachabilityHandler)block;


/**
 *  HTTP网路请求任务
 *
 *  @param method     @"GET" @"POST"
 *  @param urlString  URL
 *  @param parameters 请求参数
 *  @param progress   回调进度对象
 *  @param succeed    成功回调
 *  @param failed     失败回调
 *
 *  @return 数据任务
 */
- (NSURLSessionDataTask *)httpDataTaskMethod:(NSString *)method
                                         url:(NSString *)urlString
                                  parameters:(NSDictionary *)parameters
                                    progress:(ProgressHandler)progress
                                     succeed:(DataTaskSucceed)succeed
                                      failed:(DataTaskFailed)failed;


/**
 *  HTTP自定义报文头网路请求任务
 *
 *  @param method               @"GET" @"POST"
 *  @param urlString            URL
 *  @param parameters           请求参数
 *  @param headerParam          自定义报文头数据
 *  @param progress             回调进度对象
 *  @param succeed              成功回调
 *  @param failed               失败回调
 *
 *  @return 数据任务
 */
- (NSURLSessionDataTask *)httpDataTaskMethod:(NSString *)method
                                         url:(NSString *)urlString
                                   parameter:(NSDictionary *)parameters
                                 headerParam:(NSDictionary *)headerParam
                                    progress:(ProgressHandler)progress
                                     succeed:(DataTaskSucceed)succeed
                                      failed:(DataTaskFailed)failed;


/**
 *  HTTP表单提交数据
 *
 *  @param urlString                    URL
 *  @param formDataParameters           提交的数据参数 字典中的key为字段名 value为字典类型 其中value的结构为@{@"data":上传的数据(NSData),@"name":@"上传到服务器的文件名字",@"type":@"为数据类型"}  data字段不可为空
 *  @param progress                     回调进度对象
 *  @param succeed                      成功回调
 *  @param failed                       失败回调
 *
 *  @return 数据任务
 */
- (NSURLSessionDataTask *)httpDataTaskPostFormData:(NSString *)urlString
                                     formDataParam:(NSDictionary *)formDataParam
                                          progress:(ProgressHandler)progress
                                           succeed:(DataTaskSucceed)succeed
                                            failed:(DataTaskFailed)failed;


/**
 *  HTTP同步网路请求任务
 *
 *  @param  method     @"GET" @"POST"
 *  @param  urlString  url
 *  @param  task       回调的用于操作数据任务的对象
 *  @param  parameters 参数
 *
 *  @return 成功返回NSMutableArray NSMutableDictionary NSData 错误返回NSError 请自行判断
 */
- (id)httpSynchronousDataTaskMethod:(NSString *)method
                                url:(NSString *)urlString
                         optionTask:(void(^)(NSURLSessionDataTask *))task
                         parameters:(NSDictionary *)parameters;

/**
 *  HTTP自定义网路请求任务
 *
 *  @param request          自定义NSURLRequest
 *  @param configuration    自定义NSURLSessionConfiguration (可为空)
 *  @param succeed          成功回调
 *  @param failed           失败回调
 *
 *  @return 数据任务
 */
- (NSURLSessionDataTask *)httpDataTaskRequest:(NSURLRequest *)request
                                configuration:(NSURLSessionConfiguration *)configuration
                                      succeed:(DataTaskSucceed)succeed
                                       failed:(DataTaskFailed)failed;

/**
 *  HTTP协议下载任务
 *
 *  @param urlString        下载链接字符串
 *  @param progress         回调进度对象
 *  @param targetUrl        下载完毕的路径字符串如果不设置默认为Documents
 *  @param block            下载完成的回调
 */
- (NSURLSessionDownloadTask *)httpDownloadTask:(NSString *)urlString
                                     targetUrl:(NSString *)targetUrlStr
                                      progress:(ProgressHandler)progress
                               completeHandler:(DownloadHandler)block;




/**
 *  HTTP协议上传文件任务
 *
 *  @param urlString 上传链接字符串
 *  @param filePath  本地文件路径
 *  @param progress  回调进度对象
 *  @param block     上传完成回调
 */
- (NSURLSessionUploadTask *)httpUploadTask:(NSString *)urlString
                                  filePath:(NSString *)filePath
                                  progress:(ProgressHandler)progress
                           completeHandler:(UploadHandler)block;




@end
