//
//  HalfCell.m
//  one
//
//  Created by JasKang on 15/5/25.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#import "HalfCell.h"

@interface HalfCell ()
@property(nonatomic, strong) UILabel *lbtitle;
@end

@implementation HalfCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.accessoryType = UITableViewCellAccessoryNone;
        if (!_lbtitle) {
            _lbtitle = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, ScreenWidth / 2 - 40, 55)];
            _lbtitle.textColor = GetUIColor(0x333333);
            _lbtitle.font = [UIFont systemFontOfSize:15];
            [self.contentView addSubview:_lbtitle];

        }
    }
    return self;
}

- (void)configTitle:(NSString *)title {
    _lbtitle.text = title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
