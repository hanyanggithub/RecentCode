//
//  ChannelView.h
//  ZhangLOL
//
//  Created by mac on 17/4/3.
//  Copyright © 2017年 rengukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define MAX_TAB_COUNT 5
#define TAB_MIN_WIDTH (SCREEN_WIDTH / MAX_TAB_COUNT)
#define TAB_HEIGHT 44.0

@interface ChannelView : UIView

- (void)updateWithChannelModels:(NSArray *)models;
- (void)setTabClickedWithIndexBlock:(void(^)(NSInteger index))block;
- (void)setSelectedIndex:(NSInteger)index;

@end
