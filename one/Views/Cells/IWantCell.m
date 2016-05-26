//
//  IWantCell.m
//  one
//
//  Created by JasKang on 15/5/25.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#import "IWantCell.h"


@interface IWantCell ()

@property(nonatomic, strong) UIImageView *ivcheck;
@property(nonatomic, strong) UILabel *lbtitle;
@end

@implementation IWantCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.accessoryType = UITableViewCellAccessoryNone;
        if (!_lbtitle) {
            _lbtitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, ScreenWidth - 60, 55)];
            _lbtitle.textColor = GetUIColor(0x333333);
            _lbtitle.font = [UIFont systemFontOfSize:15];
            [self.contentView addSubview:_lbtitle];

        }
    }
    return self;
}

- (void)configWithTitle:(NSString *)title {
    _lbtitle.text = title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    if (selected) {
        self.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
