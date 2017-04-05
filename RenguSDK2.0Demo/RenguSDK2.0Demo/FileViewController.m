//
//  FileViewController.m
//  RenguSDK2.0Demo
//
//  Created by mac on 16/7/29.
//  Copyright © 2016年 hymac. All rights reserved.
//

#import "FileViewController.h"
#import <RenguSDK/RenguDownloadHelper.h>
#import <RenguSDK/RenguNetService.h>

@interface FileViewController ()

@property (nonatomic , strong) NSURLSessionDownloadTask *downloadTask; // 用于暂停等操作
@property (nonatomic , strong) UILabel * progress; // 进度显示

@end

@implementation FileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view .backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    _progress = [[UILabel alloc] initWithFrame:CGRectMake(50, 200, 300, 50)];
    [self.view addSubview:_progress];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, 100, 200, 50);
    button.backgroundColor = [UIColor orangeColor];
    [button setTitle:@"支持断点下载开始" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button0 = [UIButton buttonWithType:UIButtonTypeCustom];
    button0.frame = CGRectMake(50, 200, 200, 50);
    button0.backgroundColor = [UIColor orangeColor];
    [button0 setTitle:@"上传任务开始" forState:UIControlStateNormal];
    [button0 addTarget:self action:@selector(upLoadButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button0];
    
    NSLog(@"%@",NSHomeDirectory());
}

- (void)buttonClicked:(UIButton *)btn {
    
    // 设置button标题
    if (!_downloadTask) {
        // 未开始任务
        NSString *urlStr = @"http://downmp413.ffxia.com/mp413/%E8%B7%AF%E7%AB%A5_%E5%BC%A0%E5%A9%A1-%E5%85%B6%E5%AE%9E%E7%94%B7%E4%BA%BA%E4%B8%8D%E5%AE%B9%E6%98%93[68mtv.com].mp4"; // 33.1m  mp4
        // 获取单例对象
        RenguDownloadHelper *helper = [RenguDownloadHelper shareHelper];
        // 查询当前的下载任务信息
        NSDictionary *allTask = [helper getDownloadInfo];
        
        BOOL res = NO;
        if (allTask.count > 0) {
            for (NSString *key in [allTask allKeys]) {
                // 遍历url
                if ([key isEqualToString:urlStr]) {
                    res = YES;
                }
            }
        }
        
        if (!res) {
            // 未添加下载任务,添加任务到列表
            [helper addAutoResumeDownloadTask:urlStr];
        }
        __weak typeof(self) weakSelf = self;
        // 开启下载任务
        _downloadTask = [helper httpDownloadTask:urlStr progress:^(NSProgress *downloadProgress) {
            // 主线程刷新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.progress.text = [NSString stringWithFormat:@"已经下载:%lld,总大小:%lld",downloadProgress.completedUnitCount,downloadProgress.totalUnitCount];
            });
        } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
            NSLog(@"%@",targetPath.absoluteString);
            return nil;
        } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
            NSLog(@"下载完成%@,%@",filePath,error);
        }];

        NSLog(@"不阻塞,主线程继续执行");
        // 显示暂停
        [btn setTitle:@"暂停" forState:UIControlStateNormal];
    }else{
        if (_downloadTask.state == NSURLSessionTaskStateRunning) {
            // 暂停
            [_downloadTask suspend];
            // 显示继续下载
            [btn setTitle:@"继续下载" forState:UIControlStateNormal];
            
        }else if (_downloadTask.state == NSURLSessionTaskStateSuspended){
            // 继续下载
            [_downloadTask resume];
            // 显示暂停
            [btn setTitle:@"暂停" forState:UIControlStateNormal];
        }
    }
}

// 上传文件
- (void)upLoadButtonClicked {
    RenguNetService *netService = [RenguNetService service];
    
    NSString *urlStr= @"";
    NSString *filePath = @"";
    
    // 上传
    NSURLSessionUploadTask *task = [netService httpUploadTask:urlStr filePath:filePath progress:^(NSProgress *progress) {
        NSLog(@"已完成:%lld,共:%lld",progress.completedUnitCount,progress.totalUnitCount);
    } completeHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        // 上传完成
        NSLog(@"%@,%@",response,error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
