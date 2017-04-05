//
//  AutolayoutCell.m
//  QuizText
//
//  Created by mac on 15/11/3.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "AutolayoutCell.h"


@implementation AutolayoutCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.user_icon.layer.cornerRadius = 5;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.user_icon.image = [UIImage imageNamed:@"ig_profile_photo_default.png"];
    self.pic_imageView.image = [UIImage imageNamed:@"ig_holder_image.png"];
   // NSLog(@"%f",self.frame.size.width);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
