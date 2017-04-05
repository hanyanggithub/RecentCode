//
//  RenguTabBar.h
//  RenguSDKProject
//
//  Created by mac on 16/7/26.
//  Copyright © 2016年 hymac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RenguTabBarDelegate <NSObject>

/**
 *  选择某个item的委托方法
 *
 *  @param index item索引
 */
- (void)renguTabBarDidSelectedOneItem:(NSInteger)index;

@end


@interface RenguTabBar : UIView

@property (nonatomic , weak) id<RenguTabBarDelegate> delegate;


/**
 *  自定义标签栏
 *
 *  @param titles      所有标题数组
 *  @param titleHeight 标题label高度
 *  @param images      所有图片数组
 *  @param imageHeght  图片高度
 *  @param space       图片和标题间距
 *  @param color       标签栏背景颜色
 *  @param superView   父视图
 *
 *  @return 
 */
+ (instancetype)initWithTitles:(NSArray *)titles
             titleDefaultColor:(UIColor *)titleDefaultColor
            titleSelectedColor:(UIColor *)titleSelectedColor
                   titleHeight:(CGFloat)titleHeight
                        images:(NSArray *)images
                selectedImages:(NSArray *)selectedImages
                     imageSize:(CGSize)imageSize
                        vSpace:(CGFloat)space
                   bgViewColor:(UIColor *)color
                     superView:(UIView *)superView;


/**
 *  使tab选择某个item
 *
 *  @param index 
 */
- (void)selectItem:(NSInteger)index;

@end
