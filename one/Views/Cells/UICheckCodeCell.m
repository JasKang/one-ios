//
//  UICheckCodeCell.m
//  one
//
//  Created by JasKang on 15/5/25.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#import "UICheckCodeCell.h"
#import "DownButton.h"

@interface UICheckCodeCell ()
@property(nonatomic, copy) void(^valueChangeBlock)(NSString *value);

@property(strong, nonatomic) UITextField *tfvalue;
@property(strong, nonatomic) NSString *phonenumber;
@end

@implementation UICheckCodeCell

- (void)awakeFromNib {
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.frame = CGRectMake(0, 0, ScreenWidth, 55);
        // Initialization code
        if (!_phonenumber) {
            _phonenumber = @"";
        }
        if (!_tfvalue) {

            _tfvalue = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 55)];
            [_tfvalue addTarget:self action:@selector(textValueChanged:) forControlEvents:UIControlEventEditingChanged];
            _tfvalue.placeholder = @"验证码";
            _tfvalue.backgroundColor = [UIColor clearColor];
            _tfvalue.font = [UIFont systemFontOfSize:18];
            _tfvalue.textColor = GetUIColor(0x666666);
            _tfvalue.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:_tfvalue];
        }
        DownButton *btnSend = [DownButton buttonWithType:UIButtonTypeCustom];
        btnSend.frame = CGRectMake(200, 0, ScreenWidth - 200, 55);
        btnSend.backgroundColor = [UIColor clearColor];
        [btnSend setTitle:@"获取验证码" forState:UIControlStateNormal];
        [btnSend setTitleColor:UIColorBule forState:UIControlStateNormal];
        btnSend.titleLabel.font = [UIFont systemFontOfSize:18];
        btnSend.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:btnSend];
        [btnSend addToucheHandler:^(DownButton *sender, NSInteger tag) {
            [OApiManager sendCodeWithPhoneNumber:self.phonenumber smsType:SmsEnumReg success:^(NSString *info) {
                _tfvalue.text = info;
                if (self.valueChangeBlock) {
                    self.valueChangeBlock(_tfvalue.text);
                }
            }                    failure:^(NSNumber *code, NSString *error) {
                [Hud showText:error];
                [sender stop];
            }];
            sender.enabled = NO;
            [sender startWithSecond:60];
            [sender didChange:^NSString *(DownButton *countDownButton, int second) {
                NSString *title = [NSString stringWithFormat:@"剩余%d秒", second];
                return title;
            }];
            [sender didFinished:^NSString *(DownButton *countDownButton, int second) {
                countDownButton.enabled = YES;
                return @"重新获取";
            }];
        }];
    }
    return self;
}

- (void)configPhoneumber:(NSString *)phonenumber valueChangeBlock:(void (^)(NSString *value))block {
    _phonenumber = phonenumber;
    _valueChangeBlock = block;
}

- (void)textValueChanged:(id)sender {
    if (self.valueChangeBlock) {
        self.valueChangeBlock(self.tfvalue.text);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
