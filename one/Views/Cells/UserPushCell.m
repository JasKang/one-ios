//
//  UserPushCell.m
//  one
//
//  Created by JasKang on 15/5/28.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#import "UserPushCell.h"


@interface UserPushCell ()

@property(nonatomic, strong) UIImageView *ivimage;
@property(nonatomic, strong) UILabel *lbtitle;
@property(nonatomic, strong) UILabel *lbsubtitle;

@end

@implementation UserPushCell

- (void)awakeFromNib {
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (!_ivimage) {
            _ivimage = [[UIImageView alloc] init];
            _ivimage.layer.masksToBounds = YES;
            _ivimage.layer.cornerRadius = 4.0f;
            [self.contentView addSubview:_ivimage];
            [_ivimage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(50, 50));
                make.left.mas_equalTo(self.mas_left).offset(17);
                make.centerY.equalTo(self.contentView);
            }];
        }
        if (!_lbtitle) {
            _lbtitle = [[UILabel alloc] init];
            _lbtitle.textColor = GetUIColor(0x003333);
            _lbtitle.font = [UIFont systemFontOfSize:18];
            [self.contentView addSubview:_lbtitle];
            [_lbtitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(25);
                make.left.mas_equalTo(self.contentView.mas_left).offset(80);
                make.right.mas_equalTo(self.contentView.mas_right).offset(-35);
                make.centerY.equalTo(self.contentView).with.offset(-12);
            }];
        }
        if (!_lbsubtitle) {
            _lbsubtitle = [[UILabel alloc] init];
            _lbsubtitle.textColor = GetUIColor(0x999999);
            _lbsubtitle.font = [UIFont systemFontOfSize:16];
            [self.contentView addSubview:_lbsubtitle];
            [_lbsubtitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(25);
                make.left.mas_equalTo(self.contentView.mas_left).offset(80);
                make.right.mas_equalTo(self.contentView.mas_right).offset(-35);
                make.centerY.equalTo(self.contentView).with.offset(12);
            }];
        }
    }
    return self;
}

- (void)configWithImageName:(NSString *)imagename Title:(NSString *)title subTitle:(NSString *)subtitle {
    _ivimage.image = [UIImage imageNamed:imagename];
    _lbtitle.text = title;
    _lbsubtitle.text = subtitle;
}

- (void)configWithImageUrl:(NSURL *)imageurl Title:(NSString *)title subTitle:(NSString *)subtitle {
    [_ivimage sd_setImageWithURL:imageurl placeholderImage:[UIImage imageNamed:@"tou_normal"]];
    _lbtitle.text = title;
    _lbsubtitle.text = subtitle;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
