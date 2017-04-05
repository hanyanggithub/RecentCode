//
//  animationTransitionView.m
//
//  Created by mac on 15/11/18.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "animationTransitionView.h"

#define screenWidth [UIScreen mainScreen].bounds.size.width
#define changeDistance screenWidth *0.1  //触发动画的起始坐标间距
#define animationDuration .5f     //动画时间

@interface animationTransitionView ()

@property (assign,nonatomic)CGFloat beginLocation_X; // 手指接触屏幕时的X坐标
@property (assign,nonatomic)CGFloat currentLocation_X; // X坐标
@property (assign,nonatomic)CGFloat endLocation_X;   // 手指离开屏幕时的X坐标
@property (assign,nonatomic)NSInteger currenImagesIndexs; //当前显示的索引位置

@end

@implementation animationTransitionView

- (NSArray *)imageRefWithImages:(NSArray *)images
{
    NSMutableArray *M = [NSMutableArray array];
    
    for (int i = 0;  i < images.count; i++) {
        
        UIImage *image = images[i];
        
        CGImageRef refImage = image.CGImage;
        
        [M addObject:(__bridge id)(refImage)];
        
    }
    return M;
}

- (void)setImages:(NSArray *)images
{
    _images = [self imageRefWithImages:images];
    //设置默认图片
    self.layer.contents = [_images firstObject];
    self.currenImagesIndexs = 0;
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
    }
    return self;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //获取beginLocation_X
    UITouch *beginTouch = [touches anyObject];
    self.beginLocation_X = [beginTouch locationInView:self].x;
    
}
// 设置根据偏移量发生渐变效果 2个layer不同content根据偏移量动态改变透明度
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    //获取endLocation_X
//    UITouch *moveTouch = [touches anyObject];
//    self.currentLocation_X = [moveTouch locationInView:self].x;
//    [self changeImageWithBeginLocationX:self.beginLocation_X endLocationX:self.currentLocation_X];
//
//    
//}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //获取endLocation_X
    UITouch *endTouch = [touches anyObject];
    self.endLocation_X = [endTouch locationInView:self].x;
    [self changeImageWithBeginLocationX:self.beginLocation_X endLocationX:self.endLocation_X];
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}
- (void)changeImageWithBeginLocationX:(CGFloat)begin endLocationX:(CGFloat)end
{
    CGFloat distance = end - begin;
    //创建动画
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"contents"];
    basicAnimation.duration = animationDuration;
    
    if (distance < - changeDistance) {
        if (self.currenImagesIndexs <= 0) {
            
            
        }else{
            //切换前一张图片
            basicAnimation.fromValue = self.images[self.currenImagesIndexs];
            basicAnimation.toValue = self.images[self.currenImagesIndexs - 1];
            self.currenImagesIndexs--;
            self.layer.contents = self.images[self.currenImagesIndexs];
        }
    }else if (distance > changeDistance) {
        if (self.currenImagesIndexs >= self.images.count - 1) {
            
            
        }else{
            //切换后一张图片
            basicAnimation.fromValue = self.images[self.currenImagesIndexs];
            basicAnimation.toValue = self.images[self.currenImagesIndexs + 1];
            self.currenImagesIndexs++;
            self.layer.contents = self.images[self.currenImagesIndexs];
        }
    }
    [self.layer addAnimation:basicAnimation forKey:nil];
}



@end
