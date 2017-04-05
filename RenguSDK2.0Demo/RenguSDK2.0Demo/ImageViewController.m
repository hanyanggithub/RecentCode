//
//  ImageViewController.m
//  RenguSDK2.0Demo
//
//  Created by mac on 16/7/29.
//  Copyright © 2016年 hymac. All rights reserved.
//

#import "ImageViewController.h"
#import "UIImageView+WebCache.h"
#import <RenguSDK/RenguImageHelper.h>

@interface ImageViewController ()

@property (nonatomic , strong) UIImageView * imageView;

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    
    // 加载一张网络图片并实现图片的缓存
    _imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:_imageView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, 100, 200, 50);
    button.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
    [button setTitle:@"加载图片" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *optionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    optionButton.frame = CGRectMake(50, 200, 200, 50);
    optionButton.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
    [optionButton setTitle:@"操作图片" forState:UIControlStateNormal];
    [optionButton addTarget:self action:@selector(optionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:optionButton];
}

- (void)buttonClicked:(UIButton *)btn {
    
    NSURL *url = [NSURL URLWithString:@"http://e.hiphotos.baidu.com/zhidao/pic/item/f3d3572c11dfa9ec7ec7521866d0f703908fc1d0.jpg"];
    NSLog(@"%@",NSHomeDirectory());
    [_imageView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 加载完成
        NSLog(@"%ld",cacheType);
    }];
    
}
- (void)optionButtonClicked:(UIButton *)btn {
    
    NSURL *url = [NSURL URLWithString:@"http://e.hiphotos.baidu.com/zhidao/pic/item/f3d3572c11dfa9ec7ec7521866d0f703908fc1d0.jpg"];
    
    UIImage *image = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:url.absoluteString];
    // 图片质量压缩
    UIImage *image1 = [RenguImageHelper reduceImage:image percent:0.1];
    NSLog(@"图片尺寸缩放前:宽:%f,高:%f,图片尺寸缩放后:宽:%f,高:%f",image.size.width,image.size.height,image1.size.width,image1.size.height);
    NSLog(@"图片质量压缩前:%lu,图片质量压缩前后:%lu,",UIImagePNGRepresentation(image).length,UIImagePNGRepresentation(image1).length);
    _imageView.image = image1;
    
    // 图片大小缩放
    UIImage *image2 = [RenguImageHelper imageWithImageSimple:image scaledToSize:CGSizeMake(375 * 2.0,667 *2.0)];
    NSLog(@"图片尺寸缩放前:宽:%f,高:%f,图片尺寸缩放后:宽:%f,高:%f",image.size.width,image.size.height,image2.size.width,image2.size.height);
    NSLog(@"图片质量压缩前:%lu,图片质量压缩前后:%lu,",UIImagePNGRepresentation(image).length,UIImagePNGRepresentation(image2).length);
    _imageView.image = image2;

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
