//
//  PageAnimationView.m
//  QuizText
//
//  Created by mac on 15/11/20.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "PageAnimationView.h"

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define AnimationDuration 0.1 //动画时间
#define MaxRotationAngle  M_PI_2 /3.0

//定制移除动画方向（先定制6个方向）(可以随意添加)
typedef NS_ENUM(NSInteger, RemoveDirection)
{
    RemoveDirectionTop,
    RemoveDirectionBottom,
    RemoveDirectionLeftTop,
    RemoveDirectionRightTop,
    RemoveDirectionLeftBottom,
    RemoveDirectionRightBottom
};
@interface PageAnimationView ()

@property (nonatomic,assign)RemoveDirection direction; //移除动画方向
@property (nonatomic,strong)UIImageView *annimationView; //截屏
@property (nonatomic,assign)CGPoint startLocation;  //手指接触屏幕时的坐标
@property (nonatomic,assign)CGPoint endLocation;    //手指离开屏幕时的坐标
@property (nonatomic,assign)CGFloat startCenter_x;  //截屏的视图中心点x坐标
@property (nonatomic,assign)CGFloat startCenter_y;  //截屏的视图中心点y坐标
@property (assign,nonatomic)NSInteger i;     //当前显示的模型数据在模型数组中的位置


@end

@implementation PageAnimationView

- (void)didMoveToSuperview
{
    self.model = [self.models firstObject];
    
}
//触摸开始时截个图 并且记录起始的手指点击位置坐标
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //获取手指接触屏幕的坐标
    UITouch * startTouch = [touches anyObject];
    self.startLocation = [startTouch locationInView:self];
    //截屏
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.bounds.size.width, self.bounds.size.height), YES, 2);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *moveImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //切换下一个模型
     _i++;
    [self changeContent];
    //创建动画视图
    _annimationView = [[UIImageView alloc] initWithFrame:self.frame];
    _annimationView.image = moveImage;
    [self.superview addSubview:_annimationView];
    //获取图片中心点
    _startCenter_x = _annimationView.center.x;
    _startCenter_y = _annimationView.center.y;
}
//手指移动时使截图跟随移动
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
  
    UITouch *moveTouch = [touches anyObject];
    CGPoint movePoint = [moveTouch locationInView:self];
    
    //计算移动偏移量
    CGFloat change_x = movePoint.x - self.startLocation.x;
    CGFloat change_y = movePoint.y - self.startLocation.y;
    //设置的最大旋转角度
    CGFloat max = MaxRotationAngle;
    //计算旋转角度
    CGFloat rotationRadius = change_x / ((SCREENWIDTH - self.bounds.size.width) / 2.0  + self.bounds.size.width) * max;
    //移动截屏视图
    _annimationView.center = CGPointMake(_startCenter_x + change_x, _startCenter_y + change_y);
    //设置旋转方向
    if (self.startLocation.y > SCREENHEIGHT / 2.0) {
        
        _annimationView.transform = CGAffineTransformMakeRotation(-rotationRadius);
    }else{
        
        _annimationView.transform = CGAffineTransformMakeRotation(rotationRadius);
    }
    
}
//判断开始时获得手指离开屏幕时的手指坐标  根据 始 终坐标计算是否显示下一张内容
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //获取结束位置坐标
    UITouch *endTouch = [touches anyObject];
    self.endLocation = [endTouch locationInView:self.self];
    
    //根据手指离开距离时的坐标与初始位置坐标距离判断是否真正切换图片
    CGFloat distance_x = ABS(self.startLocation.x - self.endLocation.x);
    CGFloat distance_y = ABS(self.startLocation.y - self.endLocation.y);
    //取滑动距离超过图片的一半宽或高时作为判断
    if (distance_x >= self.bounds.size.width / 2.0 || distance_y >= self.bounds.size.height / 2.0) {
        //根据结束时坐标计算移除方向
        CGFloat end_x = self.endLocation.x;
        CGFloat end_y = self.endLocation.y;
        //判断动画的移除方向
        if (end_x > SCREENWIDTH / 6.0 * 2 && end_x < SCREENWIDTH / 6.0 * 4 && end_y <= SCREENHEIGHT / 4.0) {
            //向上移除
            self.direction = RemoveDirectionTop;
        }else if (end_x > SCREENWIDTH / 6.0 * 2 && end_x < SCREENWIDTH / 6.0 * 4 && end_y >= SCREENHEIGHT / 4.0 * 3) {
            //向下移除
            self.direction = RemoveDirectionBottom;
        }else if (end_x < SCREENWIDTH / 2.0 && end_y < SCREENHEIGHT / 2.0) {
            //左下移除
            self.direction = RemoveDirectionLeftBottom;
        }else if (end_x < SCREENWIDTH / 2.0 && end_y > SCREENHEIGHT / 2.0){
            //左上移除
            self.direction = RemoveDirectionLeftTop;
        }else if (end_x > SCREENWIDTH / 2.0 && end_y > SCREENHEIGHT / 2.0){
            //右下移除
            self.direction = RemoveDirectionRightBottom;
        }else if (end_x > SCREENWIDTH / 2.0 && end_y < SCREENHEIGHT / 2.0){
            //右上移除
            self.direction = RemoveDirectionRightTop;
        }else{
            //这里做个容错处理防止有没有判断到的情况下导致截屏没有被移除
            //移除动画视图
            [self.annimationView removeFromSuperview];
            self.annimationView = nil;
        }
        //动画中移除视图
        [self removeAnnimationWithDirection:self.direction];
        
    }else{
        //返回原图片
        //切换上一个模型
        _i--;
        [self changeContent];
        [self.annimationView removeFromSuperview];
        self.annimationView = nil;
    }
}
#pragma mark - 移除动画
- (void)removeAnnimationWithDirection:(RemoveDirection)direction
{
    CGFloat x = 0;
    CGFloat y = 0;
    //根据移除方向设置不同的动画结束位置
    if (direction == RemoveDirectionRightBottom) {
        x = SCREENWIDTH;
        y = 10;
    }else if (direction == RemoveDirectionLeftTop) {
        x = - SCREENWIDTH;
        y = self.annimationView.frame.origin.y;
    }else if (direction == RemoveDirectionLeftBottom) {
        x = - SCREENWIDTH;
        y = self.annimationView.frame.origin.y;
    }else if (direction == RemoveDirectionRightTop) {
        x = SCREENWIDTH;
        y = 100;
    }else if (direction == RemoveDirectionTop) {
        x = self.annimationView.frame.origin.x;
        y = - SCREENHEIGHT;
    }else if (direction == RemoveDirectionBottom) {
        x = self.annimationView.frame.origin.x;
        y = SCREENHEIGHT;
    }
    [UIView animateWithDuration:AnimationDuration animations:^{
        
        self.annimationView.frame = CGRectMake(x, y, self.bounds.size.width, self.bounds.size.height);
        
    }completion:^(BOOL finished) {
        //移除动画视图
        if (self.annimationView != nil) {
            [self.annimationView removeFromSuperview];
            self.annimationView = nil;
        }
    }];
}
//切换数据模型
- (void)changeContent
{
    if (_i >= self.models.count) {
        //返回第一张
        _i = 0;
    }
    
    self.model = [self.models objectAtIndex:_i];
}
//子类需要重写的方法
- (void)setModel:(NSObject *)model
{
    
}
@end
