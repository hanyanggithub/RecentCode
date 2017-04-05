//
//  PageView.m
//  QuizText
//
//  Created by mac on 15/11/21.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "PageView.h"

@interface PageView ()

@property (strong,nonatomic)UIImageView *imageView;
@property (strong,nonatomic)UILabel *label;

@end

@implementation PageView

@synthesize models;

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.backgroundColor = [UIColor purpleColor];
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 300)];
        [self addSubview:_imageView];
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(100, 300, 100, 50)];
        _label.backgroundColor = [UIColor orangeColor];
        [self addSubview:_label];
    }
    return self;
}
- (NSArray *)models
{
    if (!models) {
        
        models = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pageViewDataList" ofType:@"plist"]];
    }
    
    return models;
}
- (void)setModel:(NSArray *)model
{
    _imageView.image = [UIImage imageNamed:model[0]];
    _label.text = model[1];
}

@end
