//
//  OwnController.m
//  one
//
//  Created by JasKang on 15/5/27.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#import "OwnInfoController.h"
#import "ImageCollectionView.h"
#import "TagCollectionView.h"
#import "OwnEditController.h"
#import "OPlistManager.h"

@interface OwnInfoController ()

@property(nonatomic, strong) UIScrollView *scrollView;

@property(nonatomic, strong) ImageCollectionView *cvPhotos;
@property(nonatomic, strong) TagCollectionView *cvTags;

@property(nonatomic, strong) UIButton *ivLike;
@property(nonatomic, strong) UILabel *lbName;
@property(nonatomic, strong) UILabel *lbSubField;
@property(nonatomic, strong) UILabel *lbActiveTime;
@property(nonatomic, strong) UITextView *tvSignature;

@property(nonatomic, strong) UILabel *lvIwant;
@property(nonatomic, strong) UILabel *lvJob;
@property(nonatomic, strong) UILabel *lvSubJob;

@end

@implementation OwnInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect frame = [UIView frameWithOutNav];
    self.view = [[UIView alloc] initWithFrame:frame];
    self.view.backgroundColor = UIColorBackGray;
    self.title = @"个人主页";

    UIBarButtonItem *btnEdit = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(tapEdit)];

    self.navigationItem.rightBarButtonItem = btnEdit;

    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [_scrollView setBackgroundColor:UIColorBackGray];
    _scrollView.showsHorizontalScrollIndicator = NO;    //是否显示水平方向的滚动条
    _scrollView.showsVerticalScrollIndicator = YES;   //是否显示垂直方向的滚动条
    [self.view addSubview:_scrollView];

    /** 内容主体 */
    UIView *container = [[UIView alloc] init];
    [container setBackgroundColor:[UIColor whiteColor]];
    [_scrollView addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollView);
        make.width.equalTo(_scrollView);
    }];

    /** 照片 */
    _cvPhotos = [[ImageCollectionView alloc] initWithImages:[[AppDel localUser] photos]];
    [container addSubview:_cvPhotos];
    [_cvPhotos mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.centerX.mas_equalTo(container.center.x);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth, [_cvPhotos fullHeight]));
    }];

    /** 分割线 */
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = UIColorLine;
    [container addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_cvPhotos.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth, (1.0f / [UIScreen mainScreen].scale)));
        make.centerX.equalTo(self.view);
    }];


    /** 用户信息条 */
    UIView *infoV = [[UIView alloc] init];
    _ivLike = [UIButton buttonWithType:UIButtonTypeCustom];
    [_ivLike setImage:[UIImage imageNamed:@"xin"] forState:UIControlStateNormal];
    [_ivLike setTitleColor:GetUIColor(0x333333) forState:UIControlStateNormal];
    NSUInteger praise_num = [NSString stringWithFormat:@"%@", [AppDel localUser].praise_num].length;
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ 人赞了你", [AppDel localUser].praise_num]];
    [attriString addAttribute:NSForegroundColorAttributeName
            value:[UIColor redColor]
            range:NSMakeRange(0, praise_num)];
    [_ivLike setAttributedTitle:attriString forState:UIControlStateNormal];
    [_ivLike.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_ivLike setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    [infoV addSubview:_ivLike];
    [_ivLike mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(infoV).with.offset(-15);
        make.size.mas_equalTo(CGSizeMake(120, 20));
        make.centerY.equalTo(infoV);
    }];

    _lbName = [[UILabel alloc] init];
    _lbName.textColor = GetUIColor(0x333333);
    _lbName.font = [UIFont systemFontOfSize:19];
    _lbName.text = [NSString stringWithFormat:@"%@,%@", [AppDel localUser].nick_name, [AppDel localUser].age];
    [infoV addSubview:_lbName];
    [_lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(infoV.mas_left).offset(15);
        make.right.mas_equalTo(_ivLike.mas_left).offset(-20);
        make.top.equalTo(infoV);
        make.height.mas_equalTo(20);
    }];

    _lbSubField = [[UILabel alloc] init];
    _lbSubField.textColor = GetUIColor(0x333333);
    _lbSubField.font = [UIFont systemFontOfSize:15];
    _lbSubField.text = [NSString stringWithFormat:@"%@ %@", [AppDel localUser].constellation, [AppDel localUser].liveplace];
    [infoV addSubview:_lbSubField];
    [_lbSubField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(infoV.mas_left).offset(15);
        make.right.mas_equalTo(_ivLike.mas_left).offset(-20);
        make.top.mas_equalTo(_lbName.mas_bottom);
        make.height.mas_equalTo(24);
    }];

    [container addSubview:infoV];
    [infoV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line1.mas_bottom).offset(17);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth, 58));
        make.centerX.equalTo(container);

    }];

    /** 个性签名 */
    _tvSignature = [[UITextView alloc] init];
    _tvSignature.textColor = GetUIColor(0x333333);
    _tvSignature.font = [UIFont systemFontOfSize:15];
    _tvSignature.editable = NO;
    _tvSignature.userInteractionEnabled = NO;
    _tvSignature.text = [AppDel localUser].personal_signature;
    
    [container addSubview:_tvSignature];
    CGFloat signatureHeight=[[AppDel localUser].personal_signature heightWithFont:_tvSignature.font Width:self.view.width-24];
    [_tvSignature mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(container.mas_left).offset(12);
        make.right.mas_equalTo(container.mas_right).offset(-12);
        make.top.mas_equalTo(infoV.mas_bottom).offset(25);
        make.height.mas_equalTo(signatureHeight+30);
    }];

    /** 分割线 */
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = UIColorLine;
    [container addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_tvSignature.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth, (1.0f / [UIScreen mainScreen].scale)));
        make.centerX.equalTo(self.view);
    }];

    /** 标题 我的信息 */
    UIView *firsttitlebox = [[UIView alloc] init];
    [firsttitlebox setBackgroundColor:UIColorBackGray];

    UILabel *firsttitle = [[UILabel alloc] init];
    [firsttitle setTextColor:GetUIColor(0x666666)];
    [firsttitle setFont:[UIFont systemFontOfSize:14]];
    [firsttitle setText:@"我的信息"];
    [firsttitlebox addSubview:firsttitle];
    [firsttitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(firsttitlebox.mas_left).offset(12);
        make.right.mas_equalTo(firsttitlebox.mas_right).offset(-12);
        make.top.mas_equalTo(firsttitlebox.mas_top).offset(14);
        make.bottom.mas_equalTo(firsttitlebox.mas_bottom);
    }];

    [container addSubview:firsttitlebox];
    [firsttitlebox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line2.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth, 44));
        make.centerX.equalTo(container);
    }];


    /** 分割线 */
    UIView *line3 = [[UIView alloc] init];
    line3.backgroundColor = UIColorLine;
    [container addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(firsttitlebox.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth, (1.0f / [UIScreen mainScreen].scale)));
        make.centerX.equalTo(self.view);
    }];

    /** 我的信息 */
    UIView *firstbox = [[UIView alloc] init];
    UIColor *lbColor = GetUIColor(0x999999);
    UIFont *lbFont = [UIFont systemFontOfSize:16];

    UILabel *lbIwant = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 60, 44)];
    [lbIwant setTextColor:lbColor];
    [lbIwant setFont:lbFont];
    [lbIwant setText:@"我想"];
    [firstbox addSubview:lbIwant];

    UILabel *lbJob = [[UILabel alloc] initWithFrame:CGRectMake(12, 44, 60, 44)];
    [lbJob setTextColor:lbColor];
    [lbJob setFont:lbFont];
    [lbJob setText:@"职业"];
    [firstbox addSubview:lbJob];

    UILabel *lbSubJob = [[UILabel alloc] initWithFrame:CGRectMake(12, 88, 60, 44)];
    [lbSubJob setTextColor:lbColor];
    [lbSubJob setFont:lbFont];
    [lbSubJob setText:@"学校"];
    [firstbox addSubview:lbSubJob];

    _lvIwant = [[UILabel alloc] initWithFrame:CGRectMake(12 + 60, 0, ScreenWidth - 12 - 12 - 60, 44)];
    [_lvIwant setTextColor:GetUIColor(0x333333)];
    [_lvIwant setFont:lbFont];
    [_lvIwant setTextAlignment:NSTextAlignmentRight];
    [_lvIwant setText:[AppDel localUser].hope];
    [firstbox addSubview:_lvIwant];

    _lvJob = [[UILabel alloc] initWithFrame:CGRectMake(12 + 60, 44, ScreenWidth - 12 - 12 - 60, 44)];
    [_lvJob setTextColor:GetUIColor(0x333333)];
    [_lvJob setFont:lbFont];
    [_lvJob setTextAlignment:NSTextAlignmentRight];
    [_lvJob setText:[AppDel localUser].profession];
    [firstbox addSubview:_lvJob];

    _lvSubJob = [[UILabel alloc] initWithFrame:CGRectMake(12 + 60, 88, ScreenWidth - 12 - 12 - 60, 44)];
    [_lvSubJob setTextColor:GetUIColor(0x333333)];
    [_lvSubJob setFont:lbFont];
    [_lvSubJob setTextAlignment:NSTextAlignmentRight];
    [_lvSubJob setText:[AppDel localUser].school];
    [firstbox addSubview:_lvSubJob];

    [container addSubview:firstbox];
    [firstbox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line3.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth, 44 * 3));
        make.centerX.equalTo(container);
    }];

    /** 分割线 */
    UIView *line4 = [[UIView alloc] init];
    line4.backgroundColor = UIColorLine;
    [container addSubview:line4];
    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(firstbox.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth, (1.0f / [UIScreen mainScreen].scale)));
        make.centerX.equalTo(self.view);
    }];

    /** 标题 个性标签 */
    UIView *tagtitlebox = [[UIView alloc] init];
    [tagtitlebox setBackgroundColor:UIColorBackGray];

    UILabel *tagtitle = [[UILabel alloc] init];
    [tagtitle setTextColor:GetUIColor(0x666666)];
    [tagtitle setFont:[UIFont systemFontOfSize:14]];
    [tagtitle setText:@"个性标签"];
    [tagtitlebox addSubview:tagtitle];
    [tagtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tagtitlebox.mas_left).offset(12);
        make.right.mas_equalTo(tagtitlebox.mas_right).offset(-12);
        make.top.mas_equalTo(tagtitlebox.mas_top).offset(14);
        make.bottom.mas_equalTo(tagtitlebox.mas_bottom);
    }];

    [container addSubview:tagtitlebox];
    [tagtitlebox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line4.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth, 44));
        make.centerX.equalTo(container);
    }];

    /** 分割线 */
    UIView *line5 = [[UIView alloc] init];
    line5.backgroundColor = UIColorLine;
    [container addSubview:line5];
    [line5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tagtitlebox.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth, (1.0f / [UIScreen mainScreen].scale)));
        make.centerX.equalTo(self.view);
    }];

    /** 照片 */
    _cvTags = [[TagCollectionView alloc] initWithTags:[[OPlistManager instance] abilitysWithArray:[AppDel localUser].traits]];
    [container addSubview:_cvTags];
    [_cvTags mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line5.mas_bottom);
        make.left.mas_equalTo(container.mas_left);
        make.right.mas_equalTo(container.mas_right);
        make.height.mas_equalTo([_cvTags fullHeight]);
    }];
    /** container 自适应 */
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_cvTags.mas_bottom);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadUser) name:kReloadUser object:nil];
}

-(void)reloadUser{
    [_cvPhotos bindData:[AppDel localUser].photos];
    [_cvPhotos mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScreenWidth, [_cvPhotos fullHeight]));
    }];
    
    _lbName.text = [NSString stringWithFormat:@"%@,%@", [AppDel localUser].nick_name, [AppDel localUser].age];
    _lbSubField.text = [NSString stringWithFormat:@"%@ %@", [AppDel localUser].constellation, [AppDel localUser].liveplace];
    
    _tvSignature.text = [AppDel localUser].personal_signature;
    CGFloat signatureHeight=[[AppDel localUser].personal_signature heightWithFont:_tvSignature.font Width:self.view.width-24];
    [_tvSignature mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(signatureHeight+30);
    }];
    [_lvIwant setText:[AppDel localUser].hope];
    [_lvJob setText:[AppDel localUser].profession];
    [_lvSubJob setText:[AppDel localUser].school];
    
    [_cvTags bindData:[[OPlistManager instance] abilitysWithArray:[AppDel localUser].traits]];
    [_cvTags mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo([_cvTags fullHeight]);
    }];
    
}


- (void)tapEdit {
    OwnEditController *editVC = [[OwnEditController alloc] init];
    [self.navigationController pushViewController:editVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
