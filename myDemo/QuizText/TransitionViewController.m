//
//  TransitionViewController.m
//  QuizText
//
//  Created by mac on 15/11/21.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "TransitionViewController.h"
#import "animationTransitionView.h"


@interface TransitionViewController ()

@property (strong,nonatomic)NSArray *images;

@end

@implementation TransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    animationTransitionView *view = [[animationTransitionView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    view.images = self.images;
    [self.view addSubview:view];
}

- (NSArray *)images
{
    if (_images == nil) {
    
        NSMutableArray *imagesM = [NSMutableArray array];
        
        for (int i = 0; i < 4; i++) {
            
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i+1]];
            
            [imagesM addObject:image];
        }
        
        _images = imagesM;
    }
    
    return _images;
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
