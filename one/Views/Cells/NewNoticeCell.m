//
//  NewNoticeCell.m
//  one
//
//  Created by JasKang on 15/6/22.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#import "NewNoticeCell.h"

@interface NewNoticeCell()

@property(nonatomic, strong) UIImageView *ivicon;
@property(nonatomic, strong) UILabel *lbtitle;
@property(nonatomic, strong) UILabel *lbsubtitle;
@property(nonatomic, strong) UILabel *lbpushtext;

@end

@implementation NewNoticeCell

- (void)awakeFromNib {
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (!_ivicon) {
            _ivicon = [[UIImageView alloc] init];
            _ivicon.layer.cornerRadius=5;
            _ivicon.layer.masksToBounds=YES;
            [self.contentView addSubview:_ivicon];
            [_ivicon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(50, 50));
                make.left.mas_equalTo(self.mas_left).offset(18);
                make.centerY.equalTo(self.contentView);
            }];
        }
        if (!_lbpushtext) {
            _lbpushtext = [[UILabel alloc] init];
            _lbpushtext.textColor = GetUIColor(0x999999);
            _lbpushtext.font = [UIFont systemFontOfSize:14];
            [self.contentView addSubview:_lbpushtext];
            [_lbpushtext mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(80, 21));
                make.right.mas_equalTo(self.contentView.mas_right);
                make.centerY.equalTo(self.contentView);
            }];
        }
        
        if (!_lbtitle) {
            _lbtitle = [[UILabel alloc] init];
            _lbtitle.textColor = GetUIColor(0x666666);
            _lbtitle.font = [UIFont systemFontOfSize:14];
            [self.contentView addSubview:_lbtitle];
            [_lbtitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(21);
                make.left.mas_equalTo(_ivicon.mas_right).offset(10);
                make.right.mas_equalTo(_lbpushtext.mas_left).offset(-10);
                make.top.equalTo(_ivicon);
            }];
        }
        if (!_lbsubtitle) {
            _lbsubtitle = [[UILabel alloc] init];
            _lbsubtitle.textColor = GetUIColor(0x666666);
            _lbsubtitle.font = [UIFont systemFontOfSize:10];
            [self.contentView addSubview:_lbsubtitle];
            [_lbsubtitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(21);
                make.left.mas_equalTo(_ivicon.mas_right).offset(10);
                make.right.mas_equalTo(_lbpushtext.mas_left).offset(-10);
                make.bottom.equalTo(_ivicon);
            }];
        }
        
    }
    return self;
}

- (void)bindModel:(NewNoticeModel *)model{
    [_ivicon sd_setImageWithURL:model.photo placeholderImage:[UIImage imageNamed:@"tou_normal"]];
    
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ 赞了你",model.nick_name]];
    [attriString addAttribute:NSForegroundColorAttributeName
                        value:GetUIColor(0x333333)
                        range:NSMakeRange(0,model.nick_name.length)];
    [_lbtitle setAttributedText:attriString];
    
    [_lbsubtitle setText:[[NSDate dateWithTimeIntervalSince1970:model.create_time] compareCurrentTime]];
    if (model.sex==SexEnumMen) {
        _lbpushtext.text=@"去他的主页";
        [_lbpushtext setText:@"去他的主页"];
    }else{
        [_lbpushtext setText:@"去她的主页"];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
