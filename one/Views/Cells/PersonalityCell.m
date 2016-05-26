//
//  PersonalityCell.m
//  one
//
//  Created by JasKang on 15/5/26.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#import "PersonalityCell.h"

@interface PersonalityCell ()

@property(nonatomic, strong) UIImageView *ivicon;
@property(nonatomic, strong) UILabel *lbname;
@property(nonatomic, strong) UILabel *lbstatustext;
@property(nonatomic, strong) UIImageView *lbstatusicon;
@end

@implementation PersonalityCell

- (void)awakeFromNib {
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!_ivicon) {
            _ivicon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
            _ivicon.layer.masksToBounds = YES;
            _ivicon.layer.cornerRadius = 25.f;
            _ivicon.contentMode = UIViewContentModeScaleAspectFill;
            [self.contentView addSubview:_ivicon];

            //            _ivicon.image = [UIImage imageNamed:@"photo"];
        }
        if (!_lbname) {
            _lbname = [[UILabel alloc] initWithFrame:CGRectMake(80, 20, 150, 30)];
            _lbname.textColor = GetUIColor(0x333333);
            _lbname.font = [UIFont systemFontOfSize:16];
            [self.contentView addSubview:_lbname];

            //            _lbname.text = @"康哥哥";
        }
        if (!_lbstatustext) {
            _lbstatustext = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth - 70 - 50, 20, 70, 30)];
            _lbstatustext.textColor = GetUIColor(0x999999);
            _lbstatustext.font = [UIFont systemFontOfSize:16];
            _lbstatustext.textAlignment = NSTextAlignmentLeft;
            [self.contentView addSubview:_lbstatustext];

            _lbstatustext.text = @"";
        }
        if (!_lbstatusicon) {
            _lbstatusicon = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth - 50, 25, 20, 20)];
            _lbstatusicon.layer.masksToBounds = YES;
            _lbstatusicon.layer.cornerRadius = 4.0;
            [self.contentView addSubview:_lbstatusicon];

            _lbstatusicon.image = [UIImage imageNamed:@"subtract"];
        }
    }
    return self;
}

- (void)configWithUrl:(NSURL *)url Title:(NSString *)title isCheck:(BOOL)check {
    [_ivicon sd_setImageWithURL:url];
    [_lbname setText:title];
    if (!check) {
        _lbstatustext.text = @"";
        _lbstatusicon.image = [UIImage imageNamed:@"add"];
    } else {
        _lbstatustext.text = @"已添加";
        _lbstatusicon.image = [UIImage imageNamed:@"subtract"];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
