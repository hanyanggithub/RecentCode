//
//  CollectionView.m
//  QuizText
//
//  Created by mac on 15/11/5.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CollectionView.h"

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define CellWidth SCREENWIDTH / 5.0 * 4
#define CellHeight (SCREENHEIGHT - 64)
#define ContentInset SCREENWIDTH / 10.0
#define imageViewWidth CellWidth
#define imageViewHeight CellHeight

static NSString *collectionCellId = @"colleid";

@implementation CollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:collectionCellId];
        _imageNames = @[@"1.png",@"2.png",@"3.png",@"4.png"];

    }
    return self;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageNames.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellId forIndexPath:indexPath];
    
    if (cell.contentView.subviews.count == 0) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((CellWidth - imageViewWidth) / 2.0 ,(CellHeight - imageViewHeight) / 2.0 ,imageViewWidth ,imageViewHeight)];
        [cell.contentView addSubview:imageView];
    }
    UIImageView *imageView = [cell.contentView.subviews firstObject];
    imageView.image = [UIImage imageNamed:_imageNames[indexPath.item]];
    [cell setNeedsLayout];
    return cell;
}
//通过该代理方法实现分页效果
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (velocity.x > 0.3) {
        // 滑动到下一个单元格
        self.centerIndexPath = [NSIndexPath indexPathForItem:_centerIndexPath.item + 1 inSection:0];
    } else if (velocity.x < - 0.3) {
        // 滑动到上一个单元格
        self.centerIndexPath = [NSIndexPath indexPathForItem:_centerIndexPath.item - 1 inSection:0];
    } else {
        // 计算当前哪一个单元格该显示
        NSInteger a = (NSInteger)(self.contentOffset.x + ContentInset + CellWidth / 2.0);
        NSInteger b = (NSInteger)CellWidth;
        NSInteger centerCellIndex = a / b;
        
        // 记录当前中心单元格
        self.centerIndexPath = [NSIndexPath indexPathForItem:centerCellIndex inSection:0];
    }
    
    // 让滑动视图滑动到指定位置
    targetContentOffset->x = CellWidth * _centerIndexPath.item - ContentInset;
}
//通过滑动视图代理方法实现缩放动画效果
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //获取屏幕上瀑布流视图的有效单元格对应的索引位置
    if (self != nil) {
        
        NSArray *visibleItems = [self indexPathsForVisibleItems];
        //遍历索引位置
        for (NSIndexPath *indexPath in visibleItems) {
            
            //计算当前索引位置对应的单元格当显示在中间位置时瀑布流视图的偏移量
            CGFloat cellCenter_x = indexPath.item * CellWidth - ContentInset;
            // 计算当前单元格离中心的距离
            CGFloat distance = scrollView.contentOffset.x - cellCenter_x;
            // 获取当前单元格设置缩放
            UICollectionViewCell *cell = [self cellForItemAtIndexPath:indexPath];
            // 设置缩放比例
            CGFloat scale = 1.0 - (ABS(distance) / CellWidth) * .2;
            UIImageView *imageView = (UIImageView *)[cell.contentView.subviews firstObject];
            imageView.transform = CGAffineTransformMakeScale(scale, scale);
        }
    }
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
   
    [super drawRect:rect];
    
    [self scrollViewDidScroll:self];
}


@end
