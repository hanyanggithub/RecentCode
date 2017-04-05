//
//  ChannelModel.m
//  ZhangLOL
//
//  Created by mac on 17/4/3.
//  Copyright © 2017年 rengukeji. All rights reserved.
//

#import "ChannelModel.h"

@implementation ChannelModel

- (instancetype)initWithDic:(NSDictionary *)dic {
//    self = [super initWithDic:dic];
    self = [self init];
    if (self) {
        self.bgcolor = dic[@"bgcolor"];
        self.chnl_type = dic[@"chnl_type"];
        self.channel_id = dic[@"id"];
        self.img = dic[@"img"];
        self.intent = dic[@"intent"];
        self.is_entry = dic[@"is_entry"];
        self.name = dic[@"name"];
        self.showhot = dic[@"showhot"];
        self.shownew = dic[@"shownew"];
        self.specil = dic[@"specil"];
        self.subtitle = dic[@"subtitle"];
        self.tag_custom = dic[@"tag_custom"];
        self.url = dic[@"url"];
    }
    return self;
}

@end
