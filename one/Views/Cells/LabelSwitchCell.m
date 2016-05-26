//
//  LabelSwitchCell.m
//  one
//
//  Created by JasKang on 15/5/28.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#import "LabelSwitchCell.h"

@interface LabelSwitchCell ()

@property(nonatomic, strong) UILabel *lbtitle;
@property(nonatomic, strong) UISwitch *lbswitch;

@end

@implementation LabelSwitchCell

- (void)awakeFromNib {
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!_lbswitch) {
            _lbswitch = [[UISwitch alloc] init];
            [self.contentView addSubview:_lbswitch];
            [_lbswitch mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(31);
                make.width.mas_equalTo(51);
                make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
                make.centerY.equalTo(self.contentView);
            }];
        }
        if (!_lbtitle) {
            _lbtitle = [[UILabel alloc] init];
            _lbtitle.textColor = GetUIColor(0x666666);
            _lbtitle.font = [UIFont systemFontOfSize:16];
            [self.contentView addSubview:_lbtitle];
            [_lbtitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(21);
                make.left.mas_equalTo(self.mas_left).offset(15);
                make.right.mas_equalTo(self.contentView.mas_right).offset(-70);
                make.centerY.equalTo(self.contentView);
            }];
        }

    }
    return self;
}

- (void)configWithTitle:(NSString *)title selected:(BOOL)selected {
    _lbtitle.text = title;
    _lbswitch.selected = selected;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
