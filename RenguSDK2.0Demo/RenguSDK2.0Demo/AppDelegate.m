//
//  AppDelegate.m
//  RenguSDK2.0Demo
//
//  Created by mac on 16/7/29.
//  Copyright © 2016年 hymac. All rights reserved.
//

#import "AppDelegate.h"
#import "JPEngine.h"
#import "CocoaLumberjack.h"
#import <RenguSDK/RenguLoggerManager.h>

@interface AppDelegate ()<RenguLoggerManagerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // jspatch 配置
    [self jspatchStart];
    // CocoaLumberjack 配置
    [self cocoaLumberjackStart];
    // 开启监听系统exceptionCrash
    RenguLoggerManager *manager = [RenguLoggerManager sharedManager];
    [manager monitorExceptionWithDelegate:self];
    // 开启监听卡塞(卡塞的监听会消耗掉一定的性能,一般是在有复杂视图的控制器开启卡顿检测，在控制器销毁时关闭卡塞的检测以提高app性能)
    [manager startMonitorBlockWithBlock:^(NSArray *message) {
        // 发生卡塞,卡塞时的堆栈信息
        NSLog(@"%@",message);
        // 可以使用日志收集框架PLCrashReporter的API获取更详细的信息,附代码:
//        // 创建config
//        PLCrashReporterConfig *config = [[PLCrashReporterConfig alloc] initWithSignalHandlerType:PLCrashReporterSignalHandlerTypeBSD symbolicationStrategy:PLCrashReporterSymbolicationStrategyAll];
//        // 创建crashReporter
//        PLCrashReporter *crashReporter = [[PLCrashReporter alloc] initWithConfiguration:config];
//        
//        NSData *data = [crashReporter generateLiveReport];
//        PLCrashReport *reporter = [[PLCrashReport alloc] initWithData:data error:NULL];
//        NSString *report = [PLCrashReportTextFormatter stringValueForCrashReport:reporter
//                                                                  withTextFormat:PLCrashReportTextFormatiOS];
//        
//        NSLog(@"------------\n%@\n------------", report);
    }];
    return YES;
}
#pragma mark - RenguLoggerManagerDelegate
- (void)didMonitoredException:(NSException *)exception {
    // 检测到exception类型引起程序crash
    // 堆栈
    NSArray *arr = [exception callStackSymbols];
    // reason
    NSString *reason = [exception reason];
    // name
    NSString *name = [exception name];
    NSLog(@"name = %@",name);
    NSLog(@"reason = %@",reason);
    NSLog(@"callStackSymbols = %@",arr);
    
}

- (void)cocoaLumberjackStart {
    // 开启向xcode控制台打印
    [DDLog addLogger:[DDTTYLogger sharedInstance]]; // TTY = Xcode console
    // 开启向系统发送日志
    [DDLog addLogger:[DDASLLogger sharedInstance]]; // ASL = Apple System Logs
    // 开启写入本地日志
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init]; // File Logger
    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [DDLog addLogger:fileLogger];
}

- (void)jspatchStart {
    // 启动
    [JPEngine startEngine];
    // 加载js文件路径
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"js"];
    // 获得js文件中的代码
    NSString *script = [NSString stringWithContentsOfFile:sourcePath encoding:NSUTF8StringEncoding error:nil];
    // 执行js
    [JPEngine evaluateScript:script];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
