//
//  LabeTextFiledCell.m
//  one
//
//  Created by JasKang on 15/5/25.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#import "LabeTextFiledCell.h"

@interface LabeTextFiledCell ()
@property(strong, nonatomic) UITextField *tfvalue;
@property(strong, nonatomic) UILabel *lbtitle;

@property(copy, nonatomic) void(^valueChangeBlock)(NSString *value);

@end

@implementation LabeTextFiledCell

- (void)awakeFromNib {
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.lbtitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 55, self.contentView.frame.size.height)];
        [self.lbtitle setTintColor:GetUIColor(0x666666)];
        [self.lbtitle setFont:[UIFont systemFontOfSize:15]];

        self.tfvalue = [[UITextField alloc] initWithFrame:CGRectMake(70, 0, ScreenWidth - 70, self.contentView.frame.size.height)];
        [self.tfvalue addTarget:self action:@selector(textValueChanged:) forControlEvents:UIControlEventEditingChanged];
        [self.contentView addSubview:self.lbtitle];
        [self.contentView addSubview:self.tfvalue];
    }
    return self;
}

- (void)configWithTitle:(NSString *)title placeholder:(NSString *)placeholder keyboardType:(UIKeyboardType)type
        isEntry:(BOOL)isEntry valueChangeBlock:(void (^)(NSString *value))block {
    [self.lbtitle setText:title];
    [self.tfvalue setPlaceholder:placeholder];
    [self.tfvalue setSecureTextEntry:isEntry];
    if (type) {
        [self.tfvalue setKeyboardType:type];
    }
    self.valueChangeBlock = block;
}

- (void)textValueChanged:(id)sender {
    if (self.valueChangeBlock) {
        self.valueChangeBlock(self.tfvalue.text);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.lbtitle setFrame:CGRectMake(15, 0, 55, self.contentView.frame.size.height)];
    [self.tfvalue setFrame:CGRectMake(70, 0, ScreenWidth - 70, self.contentView.frame.size.height)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
