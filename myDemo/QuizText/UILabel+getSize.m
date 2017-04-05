//
//  UILabel+getSize.m
//  QuizText
//
//  Created by mac on 15/11/20.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "UILabel+getSize.h"

@implementation UILabel (getSize)

- (CGSize)boundingRectWithSize:(CGSize)size
{
    
    NSDictionary *attribute = @{NSFontAttributeName:self.font};
    
    CGSize endSize = [self.text boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine| NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    return endSize;
}

@end
