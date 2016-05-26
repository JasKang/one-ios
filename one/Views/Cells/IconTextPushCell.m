//
//  IconTextPushCell.m
//  one
//
//  Created by JasKang on 15/5/28.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#import "IconTextPushCell.h"

@interface IconTextPushCell ()

@property(nonatomic, strong) UIImageView *ivicon;
@property(nonatomic, strong) UILabel *lbtitle;

@end

@implementation IconTextPushCell

- (void)awakeFromNib {
    // Initialization code

}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (!_ivicon) {
            _ivicon = [[UIImageView alloc] init];
            [self.contentView addSubview:_ivicon];
            [_ivicon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(26, 26));
                make.left.mas_equalTo(self.mas_left).offset(17);
                make.centerY.equalTo(self.contentView);
            }];
        }
        if (!_lbtitle) {
            _lbtitle = [[UILabel alloc] init];
            _lbtitle.textColor = GetUIColor(0x999999);
            _lbtitle.font = [UIFont systemFontOfSize:16];
            [self.contentView addSubview:_lbtitle];
            [_lbtitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(21);
                make.left.mas_equalTo(self.mas_left).offset(61);
                make.right.mas_equalTo(self.contentView.mas_right).offset(-35);
                make.centerY.equalTo(self.contentView);
            }];
        }
    }
    return self;
}

- (void)configWithTitle:(NSString *)title imageName:(NSString *)imagename {
    _ivicon.image = [UIImage imageNamed:imagename];
    _lbtitle.text = title;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
