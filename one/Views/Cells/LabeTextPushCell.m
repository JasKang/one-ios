//
//  LabeTextPushCell.m
//  one
//
//  Created by JasKang on 15/5/25.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#import "LabeTextPushCell.h"

@interface LabeTextPushCell ()

@property(strong, nonatomic) UILabel *lbtitle;
@property(strong, nonatomic) UITextField *tfvalue;

@end

@implementation LabeTextPushCell

- (void)awakeFromNib {
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        if (!_lbtitle) {
            _lbtitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 80, self.contentView.frame.size.height)];
            [_lbtitle setTintColor:GetUIColor(0x666666)];
            [_lbtitle setFont:[UIFont systemFontOfSize:15]];
            [self.contentView addSubview:_lbtitle];
        }
        if (!_tfvalue) {
            _tfvalue = [[UITextField alloc] initWithFrame:CGRectMake(95, 0, ScreenWidth - 95 - 30, self.contentView.frame.size.height)];
            [_tfvalue setFont:[UIFont systemFontOfSize:15]];
            [_tfvalue setTextColor:GetUIColor(0x666666)];
            [_tfvalue setUserInteractionEnabled:NO];
            [_tfvalue setTextAlignment:NSTextAlignmentRight];
            [self.contentView addSubview:self.tfvalue];
        }
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_lbtitle setFrame:CGRectMake(15, 0, 80, self.contentView.frame.size.height)];
    [_tfvalue setFrame:CGRectMake(95, 0, ScreenWidth - 95 - 30, self.contentView.frame.size.height)];
}

- (void)configWithTitle:(NSString *)title value:(NSString *)value placeholder:(NSString *)placeholder {
    _lbtitle.text = title;
    _tfvalue.text = value;
    _tfvalue.placeholder = placeholder;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
