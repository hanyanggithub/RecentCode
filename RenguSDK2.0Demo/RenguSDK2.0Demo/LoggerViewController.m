//
//  LoggerViewController.m
//  RenguSDK2.0Demo
//
//  Created by mac on 16/7/29.
//  Copyright © 2016年 hymac. All rights reserved.
//

#import "LoggerViewController.h"
#import "CocoaLumberjack.h"

@interface LoggerViewController ()

@end

@implementation LoggerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 日志的使用，什么时候使用日志，在用户进行关键性操作时，比如网络请求前,点击某个按钮时等等。
    // 日志的作用，当程序出现Bug是获取日志信息从而找出bug的位置
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, 50, 200, 200);
    button.backgroundColor = [UIColor orangeColor];
    [button setTitle:@"用户点击事件" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonClicked:(UIButton *)btn {
    // 假如这里用户做了登陆按钮的点击事件
    
    // 或许可以记录一下日志，记录下用户登陆的行为(时间，信息)
    
    // CocoaLumberjack分为三种日志形式
    
    // app 端重要的本地日志写入 使用DDFileLogger类
    LOG_MACRO(YES, DDLogLevelInfo, DDLogFlagInfo, 0, nil, __PRETTY_FUNCTION__, @"用户操作:点击了登陆按钮");
    
    NSLog(@"%@",NSHomeDirectory());
    
    NSArray *allLogger = [DDLog allLoggers];
    //
    DDFileLogger *fileLogger = [allLogger lastObject];
    // 日志文件信息
    DDLogFileInfo *info = [fileLogger currentLogFileInfo];
    NSLog(@"%@",info.filePath);
    NSLog(@"%@",info.fileName);
    NSLog(@"%lld",info.fileSize);
    NSLog(@"%@",info.creationDate);
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
