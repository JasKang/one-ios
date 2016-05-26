//
//  PushCell.m
//  one
//
//  Created by JasKang on 15/5/28.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#import "PushCell.h"


@interface PushCell ()
@property(nonatomic, strong) UILabel *lbtitle;
@property(nonatomic, strong) UILabel *lbsubtitle;

@end

@implementation PushCell

- (void)awakeFromNib {
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (!_lbtitle) {
            _lbtitle = [[UILabel alloc] init];
            _lbtitle.textColor = GetUIColor(0x666666);
            _lbtitle.font = [UIFont systemFontOfSize:16];
            [self.contentView addSubview:_lbtitle];
            [_lbtitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(25);
                make.left.mas_equalTo(self.contentView.mas_left).offset(15);
                make.right.mas_equalTo(self.contentView.mas_right).offset(135);
                make.centerY.equalTo(self.contentView);
            }];
        }
        if (!_lbsubtitle) {
            _lbsubtitle = [[UILabel alloc] init];
            _lbsubtitle.textColor = GetUIColor(0x666666);
            _lbsubtitle.font = [UIFont systemFontOfSize:16];
            _lbsubtitle.textAlignment = NSTextAlignmentRight;
            [self.contentView addSubview:_lbsubtitle];
            [_lbsubtitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(25);
                make.width.mas_equalTo(100);
                make.right.mas_equalTo(self.contentView.mas_right);
                make.centerY.equalTo(self.contentView);
            }];
        }
    }
    return self;
}

- (void)configWithTitle:(NSString *)title subTitle:(NSString *)subtitle {
    _lbtitle.text = title;
    _lbsubtitle.text = subtitle;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
