//
// Created by JasKang on 15/6/24.
// Copyright (c) 2015 JasKang. All rights reserved.
//
#define kPhotoEditCCell @"kPhotoEditCCell"

#import "PhotoCollectionView.h"
#import "PhotoCCell.h"
#import "JasCollectionViewGridLayout.h"

@interface PhotoCollectionView ()
@property(nonatomic, strong) NSMutableArray *imageArray;
@property(nonatomic, assign) NSInteger index;
@end

@implementation PhotoCollectionView


- (instancetype)initWithImages:(NSArray *)images delegate:(id)delegate{
    JasCollectionViewGridLayout *layout = [[JasCollectionViewGridLayout alloc] init];
    layout.numberOfItemsPerLine = 3;
    layout.aspectRatio = 1;
    layout.interitemSpacing = 10;
    layout.lineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15);
    self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, 25) collectionViewLayout:layout];
    if (self) {
        self.photoDelegate=delegate;
        _imageArray = [[NSMutableArray alloc] initWithArray:images];
        self.backgroundColor = [UIColor whiteColor];
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[PhotoCCell class] forCellWithReuseIdentifier:kPhotoEditCCell];
    }
    return self;
}

- (CGFloat)fullHeight {
    CGFloat height = 0.0f;
    NSInteger line = 1;
    if ((_imageArray.count+1) <= 3) {
        height = 20 + line * ((ScreenWidth - 30 - 20) / 3.f) + (line - 1) * 10;
    } else {
        line = (NSInteger) ceil((_imageArray.count+1) / 3.f);
        height = 20 + line * ((ScreenWidth - 30 - 20) / 3.f) + (line - 1) * 10;
    }
    return height;
}

- (void)insetPhoto:(NSURL *)url {
    if(self.index==_imageArray.count){
        [_imageArray addObject:url];
        NSIndexPath *rowPath = [NSIndexPath indexPathForRow:self.index inSection:0];
        [self insertItemsAtIndexPaths:@[rowPath]];
    }else{
        _imageArray[self.index]=url;
        NSIndexPath *rowPath = [NSIndexPath indexPathForRow:self.index inSection:0];
        [self reloadItemsAtIndexPaths:@[rowPath]];
       
    }
    [self.photoDelegate photoCollectionViewUpdate:_imageArray];
    
}

- (void)deletePhoto{
    [_imageArray removeObjectAtIndex:self.index];
    NSIndexPath *rowPath = [NSIndexPath indexPathForRow:self.index inSection:0];
    [self deleteItemsAtIndexPaths:@[rowPath]];
    [self.photoDelegate photoCollectionViewUpdate:_imageArray];
    
}

- (void)makeDefault {
    [_imageArray moveObjectFromIndex:self.index toIndex:0];
    NSIndexPath *rowPath = [NSIndexPath indexPathForRow:self.index inSection:0];
    NSIndexPath *rowDefault = [NSIndexPath indexPathForRow:0 inSection:0];
    [self reloadItemsAtIndexPaths:@[rowPath,rowDefault]];
    [self.photoDelegate photoCollectionViewUpdate:_imageArray];
}

#pragma mark - collectionView dataSource Or delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imageArray.count+1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPhotoEditCCell forIndexPath:indexPath];
    if(indexPath.row==_imageArray.count){
        [cell configWithImage:@"select_photo"];
    }else{
        [cell configWithUrl:_imageArray[indexPath.row]];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.index=indexPath.row;
    if(indexPath.row==_imageArray.count){
        [self.photoDelegate photoCollectionViewTapAdd];
    }else{
        [self.photoDelegate photoCollectionViewTapByIndex:indexPath.row];
    }
}

@end