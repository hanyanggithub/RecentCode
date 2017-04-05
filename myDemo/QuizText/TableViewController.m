//
//  TableViewController.m
//  QuizText
//
//  Created by mac on 15/11/3.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "TableViewController.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#define cellTopViewHeight ScreenWidth/7  //单元格顶部视图高度
#define cellBottomViewHeight ScreenWidth/7 *0.8 //单元格底部部视图高度
#define cellMiddelViewTitleHeight ScreenWidth/7 //单元格中间文本视图标题视图高度
#define cellMiddelViewSubTitleHeight ScreenWidth/7 //单元格中间文本视图子标题视图高度
#define cellMiddelImageViewAndSpaceBottomHeight ScreenWidth/2 + 5
#define cellMiddelViewContentWidth  ScreenWidth - ScreenWidth/7 - 10 //单元格中间文本视图内容视图宽度

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"identifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"AutolayoutCell" owner:nil options:nil];
        
        cell = [cellArray lastObject];
    }
    
    return cell;
}
//这里动态计算设置单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self cellHeight:indexPath];
}
- (CGFloat)cellHeight:(NSIndexPath *)indexPath
{
    //计算单元格所需高度
    //计算文本内容所需要的高度  // 200- 1200 随机数
    CGFloat contentHeight =  arc4random()%101;//(- (CGSize)boundingRectWithSize:(CGFloat)labelWidth)计算高度
    
    NSLog(@"%f",contentHeight);
    
    CGFloat cellHeight = cellTopViewHeight + cellBottomViewHeight + cellMiddelViewTitleHeight + cellMiddelViewSubTitleHeight + cellMiddelImageViewAndSpaceBottomHeight  + contentHeight;

    return cellHeight;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
