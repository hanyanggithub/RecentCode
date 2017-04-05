//
//  CUIViewController.m
//  RenguSDK2.0Demo
//
//  Created by mac on 16/8/1.
//  Copyright © 2016年 hymac. All rights reserved.
//

#import "CUIViewController.h"
#import <RenguSDK/RenguTabBar.h>
#import <RenguSDK/RenguGestureUnlockView.h>

@interface CUIViewController ()<RenguTabBarDelegate,RenguGestureUnlockView>

@property (nonatomic , strong) RenguTabBar * tabBar;

@end

@implementation CUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // 创建tabbar
    NSArray *titles = @[@"工作台",@"消息",@"我的"];
    UIColor *titleDefaultColor = [UIColor grayColor];
    UIColor *titleSelectedColor = [UIColor blueColor];
    NSArray *images = @[[UIImage imageNamed:@"iconfont-home"],[UIImage imageNamed:@"iconfont-message"],[UIImage imageNamed:@"iconfont-account"]];
    NSArray *selectedImages = @[[UIImage imageNamed:@"iconfont-homes"],[UIImage imageNamed:@"iconfont-messages"],[UIImage imageNamed:@"iconfont-accounts"]];
    UIColor *bgViewColor = [UIColor whiteColor];
    
    // 创建tab
    _tabBar = [RenguTabBar initWithTitles:titles titleDefaultColor:titleDefaultColor titleSelectedColor:titleSelectedColor titleHeight:13 images:images selectedImages:selectedImages imageSize:CGSizeMake(32, 32) vSpace:3 bgViewColor:bgViewColor superView:self.view];
    // 设置delegate对象
    _tabBar.delegate = self;
    
    // 创建手势解锁视图
    RenguGestureUnlockView *gestureView = [[RenguGestureUnlockView alloc] initWithFrame:CGRectMake(0, 200, 375, 400) defaultImage:[UIImage imageNamed:@"iconfont-account"] highlightImage:[UIImage imageNamed:@"iconfont-accounts"]];
    gestureView.bgColor = [UIColor purpleColor];
    gestureView.lineColor = [UIColor redColor];
    gestureView.lineWidth = 5;
    gestureView.buttonSize = CGSizeMake(60, 60);
    gestureView.delegate = self;
    [self.view addSubview:gestureView];
    
}

#pragma mark - RenguTabBarDelegate
- (void)renguTabBarDidSelectedOneItem:(NSInteger)index {
    NSLog(@"标签栏选中%ld",index);
}
#pragma mark - RenguGestureUnlockView
- (void)renguGestureUnlockViewDidFinishedUnlockWithPath:(NSString *)path {
    NSLog(@"本次解锁的密码为:%@",path);
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
