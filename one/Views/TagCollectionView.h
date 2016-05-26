//
//  TagCollectionView.h
//  one
//
//  Created by JasKang on 15/5/27.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagCollectionView : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegate>

- (instancetype)initWithTags:(NSArray *)tags;

- (CGFloat)fullHeight;

- (void)bindData:(NSArray *)tags;

@end
