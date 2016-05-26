//
//  PhotoCCell.m
//  one
//
//  Created by JasKang on 15/5/27.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//
#import "PhotoCCell.h"

@interface PhotoCCell ()

@property(nonatomic, strong) UIImageView *ivPhoto;

@end

@implementation PhotoCCell

- (void)configWithUrl:(NSURL *)url {
    if (!_ivPhoto) {
        _ivPhoto = [[UIImageView alloc] init];
        _ivPhoto.layer.cornerRadius = 4;
        _ivPhoto.layer.masksToBounds = YES;
        [self.contentView addSubview:_ivPhoto];
        [_ivPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.bottom.equalTo(self);
            make.left.equalTo(self);
            make.right.equalTo(self);
        }];
    }
    [_ivPhoto sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"tou_normal"]];
}

- (void)configWithImage:(NSString *)imagename {
    if (!_ivPhoto) {
        _ivPhoto = [[UIImageView alloc] init];
        _ivPhoto.layer.cornerRadius = 4;
        _ivPhoto.layer.masksToBounds = YES;
        [self.contentView addSubview:_ivPhoto];
        [_ivPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.bottom.equalTo(self);
            make.left.equalTo(self);
            make.right.equalTo(self);
        }];
    }
    [_ivPhoto setImage:[UIImage imageNamed:imagename]];
}

@end
