//
//  PhotoCollectionView.h
//  one
//
//  Created by JasKang on 15/5/27.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCollectionView : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegate>

- (instancetype)initWithImages:(NSArray *)images;

- (void)bindData:(NSArray *)images;

- (CGFloat)fullHeight;

@end
