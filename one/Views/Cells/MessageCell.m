//
//  MessageCell.m
//  one
//
//  Created by JasKang on 15/5/25.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#import "MessageCell.h"

@interface MessageCell ()

@property(nonatomic, strong) UIImageView *ivphoto;
@property(nonatomic, strong) UILabel *lbnick_name;
@property(nonatomic, strong) UILabel *lbtime;
@property(nonatomic, strong) UILabel *lbsubtitle;
@property(nonatomic, strong) UIButton *lbbadge;

@property(nonatomic, strong) MsgModel *model;

@end

@implementation MessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if (!_ivphoto) {
            _ivphoto = [[UIImageView alloc] init];
            _ivphoto.layer.masksToBounds = YES;
            _ivphoto.layer.cornerRadius = 4.0;
            [self.contentView addSubview:_ivphoto];
            [_ivphoto mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(60, 60));
                make.left.mas_equalTo(self.mas_left).offset(7);
                make.centerY.equalTo(self);
            }];

            //_ivphoto.image = [UIImage imageNamed:@"photo"];
        }
        if (!_lbbadge) {
            _lbbadge = [[UIButton alloc] init];
            _lbbadge.tintColor = [UIColor whiteColor];
            [_lbbadge setBackgroundImage:[UIImage imageWithColor:[UIColor redColor] size:CGSizeMake(16, 16)] forState:UIControlStateNormal];
            [_lbbadge setBackgroundImage:[UIImage imageWithColor:[UIColor redColor] size:CGSizeMake(16, 16)] forState:UIControlStateHighlighted];
            _lbbadge.layer.masksToBounds = YES;
            _lbbadge.layer.cornerRadius = 8.0f;
            _lbbadge.titleLabel.font = [UIFont systemFontOfSize:10];
            _lbbadge.titleLabel.textAlignment = NSTextAlignmentCenter;
            _lbbadge.translatesAutoresizingMaskIntoConstraints = NO;
            [self.contentView addSubview:_lbbadge];
            [_lbbadge mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(16, 16));
                make.centerY.mas_equalTo(_ivphoto.mas_top).offset(4);
                make.centerX.mas_equalTo(_ivphoto.mas_right);
            }];
        }
        if (!_lbtime) {
            _lbtime = [[UILabel alloc] init];
            _lbtime.textColor = GetUIColor(0x999999);
            _lbtime.font = [UIFont systemFontOfSize:11];
            _lbtime.textAlignment = NSTextAlignmentRight;
            _lbtime.translatesAutoresizingMaskIntoConstraints = NO;
            [self.contentView addSubview:_lbtime];
            [_lbtime mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(70, 21));
                make.right.mas_equalTo(self.mas_right).offset(-15);
                make.top.mas_equalTo(self.mas_top).offset(7);
            }];
            //_lbtime.text = @"刚刚";
        }
        if (!_lbnick_name) {
            _lbnick_name = [[UILabel alloc] initWithFrame:CGRectMake(75, 7.5, 150, 21)];
            _lbnick_name.textColor = GetUIColor(0x333333);
            _lbnick_name.font = [UIFont systemFontOfSize:15];
            _lbnick_name.translatesAutoresizingMaskIntoConstraints = NO;
            [self.contentView addSubview:_lbnick_name];
            [_lbnick_name mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(21);
                make.top.mas_equalTo(self.mas_top).offset(7);
                make.left.mas_equalTo(self.mas_left).offset(77);
                make.right.mas_equalTo(self.mas_right).offset(-85);
            }];
            //_lbnick_name.text = @"康哥哥";
        }

        if (!_lbsubtitle) {
            _lbsubtitle = [[UILabel alloc] initWithFrame:CGRectMake(75, 46.5, ScreenWidth - 75 - 15, 21)];
            _lbsubtitle.textColor = GetUIColor(0x999999);
            _lbsubtitle.font = [UIFont systemFontOfSize:14];
            _lbsubtitle.translatesAutoresizingMaskIntoConstraints = NO;
            [self.contentView addSubview:_lbsubtitle];
            [_lbsubtitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(21);
                make.bottom.mas_equalTo(self.mas_bottom).offset(-7);
                make.left.mas_equalTo(self.mas_left).offset(77);
                make.right.mas_equalTo(self.mas_right).offset(-15);
            }];
            //            _lbsubtitle.text = @"配对成功，开始打电话畅聊";
        }
    }
    return self;
}

//@property(nonatomic, strong) UIImageView *ivphoto;
//@property(nonatomic, strong) UILabel *lbnick_name;
//@property(nonatomic, strong) UILabel *lbtime;
//@property(nonatomic, strong) UILabel *lbsubtitle;

- (void)bindData:(MsgModel *)msg{
    _model = msg;
    if (msg.type == MessageTypeNewer) {
        [_ivphoto setImage:[UIImage imageNamed:@"Notification"]];
        [_lbsubtitle setText:msg.chat.message];
    } else if (msg.type == MessageTypeHelper) {
        [_ivphoto setImage:[UIImage imageNamed:@"help"]];
    } else {
        [_ivphoto sd_setImageWithURL:msg.photo placeholderImage:[UIImage imageNamed:@"tou_normal"]];
        
        if (msg.chat.type==ChatTypeEnumText) {
            [_lbsubtitle setText:msg.chat.message];
        }else{
            if (msg.chat.status==ChatCallStatusEnumFail) {
                [_lbsubtitle setText:@"未接通"];
            }else{
                [_lbsubtitle setText:[NSString stringWithFormat:@"通话时间 %@",[NSString timeFormatted:msg.chat.duration]]];
            }
        }
    }
    [_lbnick_name setText:msg.nick_name];
    [_lbtime setText:[[NSDate dateWithTimeIntervalSince1970:msg.update_time] compareCurrentTime]];
    
    if (msg.new_message_count && msg.new_message_count > 0) {
        [_lbbadge setHidden:NO];
        [_lbbadge setTitle:[NSString stringWithFormat:@"%d",msg.new_message_count] forState:UIControlStateNormal];
    } else {
        [_lbbadge setHidden:YES];
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
