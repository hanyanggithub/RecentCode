//
//  CrashViewController.m
//  RenguSDK2.0Demo
//
//  Created by mac on 16/8/1.
//  Copyright © 2016年 hymac. All rights reserved.
//

#import "CrashViewController.h"

@interface CrashViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}

@end

@implementation CrashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 模拟一个滑动表视图时发生的卡塞现象
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, 100, 200, 50);
    button.backgroundColor = [UIColor orangeColor];
    [button setTitle:@"执行crash代码" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
}
- (void)buttonClicked:(UIButton *)btn {

    // 构造一个数字越界的错误
    NSArray *array = @[@"0"];
    NSString *a = array[2];
    NSLog(@"%@",a);
    
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NSString *cellText = nil;
    if (indexPath.row % 10 == 0)
    {
        usleep(300*1000);
        cellText = @"我需要一些时间";
    }else
    {
        cellText = [NSString stringWithFormat:@"第%ld单元格",indexPath.row];
    }
    
    cell.textLabel.text = cellText;
    return cell;
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
