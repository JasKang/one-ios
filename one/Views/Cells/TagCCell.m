//
//  TagCCell.m
//  one
//
//  Created by JasKang on 15/5/27.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//
#import "TagCCell.h"

@interface TagCCell ()

@property(nonatomic, strong) UIImageView *ivIcon;
@property(nonatomic, strong) UILabel *lbText;

@end

@implementation TagCCell

- (void)configWithImageUrl:(NSURL *)imageurl Text:(NSString *)text {
    if (!_ivIcon) {
        _ivIcon = [[UIImageView alloc] init];
        _ivIcon.layer.cornerRadius = 30;
        _ivIcon.layer.masksToBounds = YES;
        [self.contentView addSubview:_ivIcon];
        [_ivIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(60, 60));
            make.centerX.equalTo(self);
        }];
        _lbText = [[UILabel alloc] init];
        _lbText.textColor = GetUIColor(0x666666);
        _lbText.font = [UIFont systemFontOfSize:15];
        _lbText.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_lbText];
        [_lbText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_ivIcon.mas_bottom);
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.height.mas_equalTo(30);
        }];
    }
    [_ivIcon sd_setImageWithURL:imageurl];
    [_lbText setText:text];
}


@end
