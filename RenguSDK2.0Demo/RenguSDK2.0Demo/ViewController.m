//
//  ViewController.m
//  RenguSDK2.0Demo
//
//  Created by mac on 16/7/29.
//  Copyright © 2016年 hymac. All rights reserved.
//

#import "ViewController.h"
#import "JSViewController.h"
#import "LoggerViewController.h"
#import "ImageViewController.h"
#import "FileViewController.h"
#import "CrashViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.item == 0) {
        // js
        JSViewController *jsVC = [[JSViewController alloc] init];
        [self.navigationController pushViewController:jsVC animated:YES];
    }else if (indexPath.item == 1) {
        // logger
        LoggerViewController *loggerVC = [[LoggerViewController alloc] init];
        [self.navigationController pushViewController:loggerVC animated:YES];
    }else if (indexPath.item == 2) {
        // image
        ImageViewController *imageVC = [[ImageViewController alloc] init];
        [self.navigationController pushViewController:imageVC animated:YES];
    }else if (indexPath.item == 3) {
        // file
        FileViewController *fileVC = [[FileViewController alloc] init];
        [self.navigationController pushViewController:fileVC animated:YES];
    }else if (indexPath.item == 4) {
        // crashMonitor
        CrashViewController *crashVC = [[CrashViewController alloc] init];
        [self.navigationController pushViewController:crashVC animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
