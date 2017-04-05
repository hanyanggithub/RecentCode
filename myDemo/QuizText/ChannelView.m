//
//  ChannelView.m
//  ZhangLOL
//
//  Created by mac on 17/4/3.
//  Copyright © 2017年 rengukeji. All rights reserved.
//

#import "ChannelView.h"
#import "UIView+Extension.h"
#import "ChannelModel.h"


@interface ChannelView ()
@property(nonatomic, strong)NSMutableArray<UILabel *> *labels;
@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, strong)UIImageView *indicator;
@property(nonatomic, copy) void(^block)(NSInteger index);
@property(nonatomic, assign)NSInteger currentIndex;

@end

@implementation ChannelView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.labels = [NSMutableArray array];
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.scrollView];
        self.indicator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tab_selected"]];
        [self.scrollView addSubview:self.indicator];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.labels = [NSMutableArray array];
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.scrollView];
        self.indicator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tab_selected"]];
        [self.scrollView addSubview:self.indicator];
    }
    return self;
}

- (void)updateWithChannelModels:(NSArray *)models {
    // 移除
    if (self.labels.count > 0 && models.count != self.labels.count) {
        for (UIView *subview in self.scrollView.subviews) {
            [subview removeFromSuperview];
        }
        [self.labels removeAllObjects];
    }
    // 创建
    if (self.labels.count == 0) {
        CGFloat tabWidth = 0;
        if (models.count < 5) {
            tabWidth = SCREEN_WIDTH / models.count;
        }else{
            tabWidth = TAB_MIN_WIDTH;
        }
        self.scrollView.contentSize = CGSizeMake(tabWidth * models.count, self.height);
        for (int i = 0; i < models.count; i++) {
            UIControl *tabContainer = [[UIControl alloc] initWithFrame:CGRectMake(i * tabWidth, 0, tabWidth, TAB_HEIGHT)];
            [tabContainer addTarget:self action:@selector(clickedTab:) forControlEvents:UIControlEventTouchUpInside];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(tabContainer.width * 0.25, tabContainer.height * 0.25, tabContainer.width * 0.5, tabContainer.height * 0.5)];
            label.textColor = [UIColor grayColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:13.0];
            ChannelModel *model = models[i];
            label.text = model.name;
            [self.scrollView addSubview:tabContainer];
            [tabContainer addSubview:label];
            [self.labels addObject:label];
        }
    }
    // 设置值
    if (models.count == self.labels.count) {
        for (int i = 0; i < models.count; i++) {
            UILabel *label = self.labels[i];
            ChannelModel *model = models[i];
            label.text = model.name;
        
        }
    }
    // 设置indicator
    UILabel *label = [self.labels firstObject];
    self.indicator.frame = CGRectMake(label.left, label.bottom, label.width, label.width/78.0 *11.0);
    [self.scrollView bringSubviewToFront:self.indicator];
    [self setSelectedIndex:0];
    
}


- (void)setTabClickedWithIndexBlock:(void(^)(NSInteger index))block {
    self.block = block;
}

- (void)clickedTab:(UIControl *)tabContainer {
    UILabel *label = [tabContainer.subviews firstObject];
    NSInteger index = [self.labels indexOfObject:label];
    // 做动作
    [self actionWithIndex:index];
    // 反馈
    if (self.block) {
        self.block(index);
    }
    
}
- (void)setSelectedIndex:(NSInteger)index {
    // 做动作
    [self actionWithIndex:index];
}

- (void)actionWithIndex:(NSInteger)index {
    // 1.清空选中状态
    UILabel *labelFont = [self.labels objectAtIndex:self.currentIndex];
    labelFont.textColor = [UIColor grayColor];
    // 2.scrollView滑动到某位置
    // 1.1 label.centerx - screenwidth /2.0
    UILabel *labelNow = [self.labels objectAtIndex:index];
    labelNow.textColor = [UIColor blackColor];
    
    UIView *container = labelNow.superview;
    // 将要滑动的位置 >0 && < contentOffset - self.width
    CGFloat target_x = container.center.x  - self.width * 0.5;
    // 边界判断
    if (target_x < 0) {
        target_x = 0;
    }
    if (target_x > self.scrollView.contentSize.width - self.width) {
        target_x = self.scrollView.contentSize.width - self.width;
    }
    [self.scrollView setContentOffset:CGPointMake(target_x, 0) animated:YES];
    
    // 2.indicator和label对应
    [UIView animateWithDuration:0.2 animations:^{
        self.indicator.center = CGPointMake(container.center.x, self.indicator.center.y);
    } completion:^(BOOL finished) {
        
    }];
    self.currentIndex = index;
}

@end
