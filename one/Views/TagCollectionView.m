//
//  TagCollectionView.m
//  one
//
//  Created by JasKang on 15/5/27.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#define kTagCCell @"TagCCell"

#import "JasCollectionViewGridLayout.h"
#import "TagCollectionView.h"
#import "TagCCell.h"

@interface TagCollectionView ()

@property(nonatomic, strong) NSArray *tagArray;

@end

@implementation TagCollectionView


- (instancetype)initWithTags:(NSArray *)tags {
    JasCollectionViewGridLayout *layout = [[JasCollectionViewGridLayout alloc] init];
    layout.numberOfItemsPerLine = 4;
    layout.aspectRatio = 0.75;
    layout.interitemSpacing = 0;
    layout.lineSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15);
    self = [super initWithFrame:CGRectZero collectionViewLayout:layout];
    if (self) {
        _tagArray = tags;

        self.backgroundColor = [UIColor whiteColor];
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[TagCCell class] forCellWithReuseIdentifier:kTagCCell];
    }
    return self;
}

- (void)bindData:(NSArray *)tags {
    _tagArray = tags;
    [self reloadData];
}

- (CGFloat)fullHeight {
    CGFloat height;
    NSInteger line = 1;
    if (_tagArray.count <= 4) {
        height = 20.f + line * ((ScreenWidth - 30) / 4.f / 0.75f);
    } else {
        line = (NSInteger) ceil(_tagArray.count / 4.f);
        height = 20.f + line * ((ScreenWidth - 30) / 4.f / 0.75f);
    }
    return height;
}

#pragma mark - collectionView dataSource Or delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _tagArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                          cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TagCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTagCCell forIndexPath:indexPath];
    TraitModel *trait = (TraitModel *) _tagArray[indexPath.row];
    [cell configWithImageUrl:trait.ability_icon_url Text:trait.ability_name];
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
