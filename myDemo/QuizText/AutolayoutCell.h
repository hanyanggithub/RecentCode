//
//  AutolayoutCell.h
//  QuizText
//
//  Created by mac on 15/11/3.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AutolayoutCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *user_icon;
@property (strong, nonatomic) IBOutlet UILabel *user_nickName;
@property (strong, nonatomic) IBOutlet UILabel *date;
@property (strong, nonatomic) IBOutlet UILabel *title_label;
@property (strong, nonatomic) IBOutlet UILabel *subtTitle_label;
@property (strong, nonatomic) IBOutlet UILabel *content_label;
@property (strong, nonatomic) IBOutlet UIImageView *pic_imageView;
@property (strong, nonatomic) IBOutlet UILabel *view_count;
@property (strong, nonatomic) IBOutlet UILabel *conment_count;
@property (strong, nonatomic) IBOutlet UILabel *praise_count;

@end
