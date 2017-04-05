//
//  CollectionView.h
//  QuizText
//
//  Created by mac on 15/11/5.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface CollectionView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong)NSArray * imageNames;
@property (nonatomic,strong)NSIndexPath *centerIndexPath;

@end
