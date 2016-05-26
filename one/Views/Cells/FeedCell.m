//
//  FeedCell.m
//  one
//
//  Created by JasKang on 15/5/25.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#import "FeedCell.h"

@interface FeedCell ()

@property(nonatomic, strong) UIView *boxView;
@property(nonatomic, strong) UIImageView *ivphoto;
@property(nonatomic, strong) UIImageView *ivjob;
@property(nonatomic, strong) UIImageView *ivsex;

//54
@property(nonatomic, strong) UILabel *lbnick_name;
@property(nonatomic, strong) UILabel *lbsubtitle;
@property(nonatomic, strong) UILabel *lbwant;
@end

@implementation FeedCell

- (void)awakeFromNib {
    // Initialization code 

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setBackgroundColor:UIColorBackGray];
        if (!_boxView) {
            _boxView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 106)];
            [_boxView setBackgroundColor:[UIColor whiteColor]];
        }
        if (!_ivphoto) {
            _ivphoto = [[UIImageView alloc] initWithFrame:CGRectMake(10, 13, 80, 80)];
            _ivphoto.layer.masksToBounds = YES;
            _ivphoto.layer.cornerRadius = 4.0;
            _ivphoto.image = [UIImage imageNamed:@"tou_normal"];
            [_boxView addSubview:_ivphoto];
        }
        if (!_lbnick_name) {
            _lbnick_name = [[UILabel alloc] initWithFrame:CGRectMake(100, 13, 150, 30)];
            _lbnick_name.textColor = GetUIColor(0x333333);
            _lbnick_name.font = [UIFont systemFontOfSize:18];


            [_boxView addSubview:_lbnick_name];
        }
        if (!_lbsubtitle) {

            _ivjob = [[UIImageView alloc] initWithFrame:CGRectMake(95, 42, 30, 30)];
            _ivjob.image = [UIImage imageNamed:@"icon_Student"];

            _lbsubtitle = [[UILabel alloc] initWithFrame:CGRectMake(100 + 25, 48, 150, 18)];
            _lbsubtitle.textColor = GetUIColor(0x999999);
            _lbsubtitle.font = [UIFont systemFontOfSize:14];

            [_boxView addSubview:_ivjob];
            [_boxView addSubview:_lbsubtitle];
        }
        if (!_lbwant) {
            _ivsex = [[UIImageView alloc] initWithFrame:CGRectMake(95, 69, 30, 30)];
            _ivsex.image = [UIImage imageNamed:@"icon_Gril"];
            _lbwant = [[UILabel alloc] initWithFrame:CGRectMake(100 + 25, 76, 150, 18)];
            _lbwant.textColor = GetUIColor(0x999999);
            _lbwant.font = [UIFont systemFontOfSize:14];

            [_boxView addSubview:_ivsex];
            [_boxView addSubview:_lbwant];
        }
        [self.contentView addSubview:_boxView];

        CGFloat lineHeight = (1.0f / [UIScreen mainScreen].scale);
        CALayer *downlineLayer = [[CALayer alloc] init];
        downlineLayer.frame = CGRectMake(0, 106, ScreenWidth, lineHeight);
        downlineLayer.backgroundColor = GetUIColor(0xe9e9e9).CGColor;
        CALayer *toplineLayer = [[CALayer alloc] init];
        toplineLayer.frame = CGRectMake(0, 0, ScreenWidth, lineHeight);
        toplineLayer.backgroundColor = GetUIColor(0xe9e9e9).CGColor;

        [self.layer addSublayer:toplineLayer];
        [self.layer addSublayer:downlineLayer];
    }
    return self;
}

- (void)configWithModel:(FeedModel *)model {
    [_ivphoto sd_setImageWithURL:model.photo placeholderImage:[UIImage imageNamed:@"tou_normal"]];

    NSString *_show = [NSString stringWithFormat:@"%@,%d", model.nick_name, model.age];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:_show];
    [str addAttribute:NSForegroundColorAttributeName value:GetUIColor(0x333333) range:NSMakeRange(0, model.nick_name.length)];
    _lbnick_name.attributedText = str;

    if ([model.profession isEqualToString:@"在校学生"]) {
        [_ivjob setImage:[UIImage imageNamed:@"icon_Student"]];
    } else {
        [_ivjob setImage:[UIImage imageNamed:@"icon_Job"]];
    }
    _lbsubtitle.text = model.profession;

    _lbwant.text = model.hope;
    if (model.sex == SexEnumWomen) {
        [_ivsex setImage:[UIImage imageNamed:@"icon_Gril"]];
    } else {
        [_ivsex setImage:[UIImage imageNamed:@"icon_Boy"]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
