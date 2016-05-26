//
//  PhotoCollectionView.m
//  one
//
//  Created by JasKang on 15/5/27.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#define kPhotoCCell @"kPhotoCCell"


#import "ImageCollectionView.h"
#import "JasCollectionViewGridLayout.h"
#import "PhotoCCell.h"

@interface ImageCollectionView ()

@property(nonatomic, strong) NSArray *imageArray;

@end

@implementation ImageCollectionView


- (instancetype)initWithImages:(NSArray *)images {
    JasCollectionViewGridLayout *layout = [[JasCollectionViewGridLayout alloc] init];
    layout.numberOfItemsPerLine = 3;
    layout.aspectRatio = 1;
    layout.interitemSpacing = 10;
    layout.lineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15);
    self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, 25) collectionViewLayout:layout];
    if (self) {
        _imageArray = images;
        self.backgroundColor = [UIColor whiteColor];
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[PhotoCCell class] forCellWithReuseIdentifier:kPhotoCCell];
    }
    return self;
}

- (void)bindData:(NSArray *)images {
    _imageArray = images;
    [self reloadData];
}

- (CGFloat)fullHeight {
    CGFloat height = 0.0f;
    NSInteger line = 1;
    if (_imageArray.count <= 3) {
        height = 20 + line * ((ScreenWidth - 30 - 20) / 3.f) + (line - 1) * 10;
    } else {
        line = (NSInteger) ceil(_imageArray.count / 3.f);
        height = 20 + line * ((ScreenWidth - 30 - 20) / 3.f) + (line - 1) * 10;
    }
    return height;
}

#pragma mark - collectionView dataSource Or delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imageArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                          cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPhotoCCell forIndexPath:indexPath];
    [cell configWithUrl:_imageArray[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
