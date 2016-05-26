//
// Created by JasKang on 15/6/24.
// Copyright (c) 2015 JasKang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PhotoCollectionViewDelegate
@required
-(void)photoCollectionViewTapAdd;
-(void)photoCollectionViewTapByIndex:(NSInteger)index;
- (void)photoCollectionViewUpdate:(NSMutableArray *)array;

@end

@interface PhotoCollectionView : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegate>

@property(assign,nonatomic)id<PhotoCollectionViewDelegate> photoDelegate;

- (instancetype)initWithImages:(NSArray *)images delegate:(id)delegate;

- (CGFloat)fullHeight;

-(void)insetPhoto:(NSURL *)url;
-(void)deletePhoto;
-(void)makeDefault;
@end