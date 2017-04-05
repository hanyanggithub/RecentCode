//
//  RenguGestureUnlockView.h
//  RenguSDKProject
//
//  Created by mac on 16/7/29.
//  Copyright © 2016年 hymac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RenguGestureUnlockView <NSObject>

- (void)renguGestureUnlockViewDidFinishedUnlockWithPath:(NSString *)path;

@end

@interface RenguGestureUnlockView : UIView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
                 defaultImage:(UIImage *)defaultImage
               highlightImage:(UIImage *)highlightImage;


- (instancetype)initWithFrame:(CGRect)frame
                 defaultImage:(UIImage *)defaultImage
               highlightImage:(UIImage *)highlightImage;

// 背景色default org
@property (nonatomic , strong) UIColor * bgColor;
// 绘制路线颜色default green
@property (nonatomic , strong) UIColor * lineColor;
// 绘制线宽default 5
@property (nonatomic , assign) CGFloat lineWidth;
// delegate
@property (nonatomic , weak) id<RenguGestureUnlockView> delegate;
// 每个按钮的尺寸 default 74 * 74 pix
@property (nonatomic , assign) CGSize buttonSize;

@end
