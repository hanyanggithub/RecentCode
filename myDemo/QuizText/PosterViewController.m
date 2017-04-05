//
//  PosterViewController.m
//  QuizText
//
//  Created by mac on 15/11/4.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "PosterViewController.h"
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define CellWidth SCREENWIDTH / 5.0 * 4
#define CellHeight (SCREENHEIGHT - 64)
#define ContentInset SCREENWIDTH / 10.0
#define imageViewWidth CellWidth
#define imageViewHeight CellHeight

@interface PosterViewController ()


@end

@implementation PosterViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(CellWidth,CellHeight);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[CollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.contentInset = UIEdgeInsetsMake(0, ContentInset, 0, ContentInset);
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    [self.view addSubview:_collectionView];
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
