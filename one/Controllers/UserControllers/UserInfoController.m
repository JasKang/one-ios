//
//  UserInfoController.m
//  one
//
//  Created by JasKang on 15/5/28.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#import "UserInfoController.h"
#import "ImageCollectionView.h"
#import "TagCollectionView.h"
#import "OPlistManager.h"
#import "ODBManager.h"
#import "CallOutController.h"

#import <BlocksKit+UIKit.h>

@interface UserInfoController ()

@property(nonatomic, strong) UIScrollView *scrollView;

@property(nonatomic, strong) ImageCollectionView *cvPhotos;
@property(nonatomic, strong) TagCollectionView *cvTags;

@property(nonatomic, strong) UIButton *ivLike;
@property(nonatomic, strong) UIButton *ivNoLike;
@property(nonatomic, strong) UILabel *lbName;
@property(nonatomic, strong) UILabel *lbSubField;
@property(nonatomic, strong) UILabel *lbActiveTime;
@property(nonatomic, strong) UITextView *tvSignature;

@property(nonatomic, strong) UserModel *user;
@property(nonatomic, strong) NSNumber *usersign;
@end

@implementation UserInfoController

+ (instancetype)initWithUserSign:(NSNumber *)usersign {
    UserInfoController *vc = [[UserInfoController alloc] init];
    vc.usersign=usersign;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Do any additional setup after loading the view.
    CGRect frame = [UIView frameWithOutNav];
    self.view = [[UIView alloc] initWithFrame:frame];
    self.view.opaque=YES;
    self.view.backgroundColor = UIColorBackGray;


    //    UIBarButtonItem *more=[[UIBarButtonItem alloc] initWithCustomView:ivmore];
    UIBarButtonItem *btnMore = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"more_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(tapMore)];
    [btnMore setImageInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    self.navigationItem.rightBarButtonItem = btnMore;

    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [_scrollView setBackgroundColor:UIColorBackGray];
    _scrollView.showsHorizontalScrollIndicator = NO;      // 是否显示水平方向的滚动条
    _scrollView.showsVerticalScrollIndicator = YES;     // 是否显示垂直方向的滚动条
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
    _cvPhotos = [[ImageCollectionView alloc] initWithImages:@[]];
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
        make.size.mas_equalTo(CGSizeMake(ScreenWidth,
                (1.0f / [UIScreen mainScreen].scale)));
        make.centerX.equalTo(self.view);
    }];   


    /** 用户信息条 */
    UIView *infoV = [[UIView alloc] init];
    _ivLike = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_ivLike setTitleColor:GetUIColor(0x666666) forState:UIControlStateNormal];
    [_ivLike setBackgroundColor:GetUIColor(0xf0f0f0)];
    [_ivLike.titleLabel setFont:[UIFont systemFontOfSize:16]];
    _ivLike.layer.masksToBounds = YES;
    _ivLike.layer.cornerRadius = 3;
    _ivLike.layer.borderWidth = 0.5;
    _ivLike.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_ivLike setContentEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [_ivLike setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [_ivLike addTarget:self action:@selector(tapLike) forControlEvents:UIControlEventTouchUpInside];

    [infoV addSubview:_ivLike];
    [_ivLike mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(infoV).with.offset(-15);
        make.size.mas_equalTo(CGSizeMake(90, 39));
        make.centerY.equalTo(infoV);
    }];

    //    _ivNoLike = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [_ivNoLike setImage:[UIImage imageNamed:@"s_nolike_normal"] forState:
    //     UIControlStateNormal];
    //    [_ivNoLike setImage:[UIImage imageNamed:@"s_nolike_hover"] forState:
    //     UIControlStateHighlighted];
    //    [infoV addSubview:_ivNoLike];
    //    [_ivNoLike mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.right.mas_equalTo(_ivLike.mas_left).offset(-20);
    //        make.size.mas_equalTo(CGSizeMake(47, 47));
    //        make.centerY.equalTo(infoV);
    //    }];

    _lbName = [[UILabel alloc] init];
    _lbName.textColor = GetUIColor(0x333333);
    _lbName.font = [UIFont systemFontOfSize:19];
    
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
    
    [infoV addSubview:_lbSubField];
    [_lbSubField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(infoV.mas_left).offset(15);
        make.right.mas_equalTo(_ivLike.mas_left).offset(-20);
        make.top.mas_equalTo(_lbName.mas_bottom);
        make.height.mas_equalTo(24);
    }];

    _lbActiveTime = [[UILabel alloc] init];
    _lbActiveTime.textColor = GetUIColor(0x999999);
    _lbActiveTime.font = [UIFont systemFontOfSize:12];

    [infoV addSubview:_lbActiveTime];
    [_lbActiveTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(infoV.mas_left).offset(15);
        make.right.mas_equalTo(_ivLike.mas_left).offset(-20);
        make.top.mas_equalTo(_lbSubField.mas_bottom);
        make.height.mas_equalTo(13);
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

    [container addSubview:_tvSignature];
    [_tvSignature mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(container.mas_left).offset(12);
        make.right.mas_equalTo(container.mas_right).offset(-12);
        make.top.mas_equalTo(infoV.mas_bottom).offset(25);
        make.height.mas_equalTo(80);
    }];

    /** 分割线 */
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = UIColorLine;
    [container addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_tvSignature.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth,
                (1.0f / [UIScreen mainScreen].scale)));
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
        make.size.mas_equalTo(CGSizeMake(ScreenWidth,
                (1.0f / [UIScreen mainScreen].scale)));
        make.centerX.equalTo(self.view);
    }];

    /** 我的信息 */
    UIView *firstbox = [[UIView alloc] init];
    UIColor *lbColor = GetUIColor(0x999999);
    UIFont *lbFont = [UIFont systemFontOfSize:16];

    UILabel *lbIwant = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 60, 44)];
    [lbIwant setTextColor:lbColor];
    [lbIwant setFont:lbFont];
    [lbIwant setText:@"他想"];
    [firstbox addSubview:lbIwant];

    UILabel *lbJob = [[UILabel alloc] initWithFrame:CGRectMake(12, 44, 60, 44)];
    [lbJob setTextColor:lbColor];
    [lbJob setFont:lbFont];
    [lbJob setText:@"职业"];
    [firstbox addSubview:lbJob];

    UILabel *lbSubJob =
            [[UILabel alloc] initWithFrame:CGRectMake(12, 88, 60, 44)];
    [lbSubJob setTextColor:lbColor];
    [lbSubJob setFont:lbFont];
    [lbSubJob setText:@"学校"];
    [firstbox addSubview:lbSubJob];

    UILabel *lvIwant =
            [[UILabel alloc] initWithFrame:CGRectMake(12 + 60, 0,
                    ScreenWidth - 12 - 12 - 60, 44)];
    [lvIwant setTextColor:GetUIColor(0x333333)];
    [lvIwant setFont:lbFont];
    [lvIwant setTextAlignment:NSTextAlignmentRight];
    [firstbox addSubview:lvIwant];

    UILabel *lvJob =
            [[UILabel alloc] initWithFrame:CGRectMake(12 + 60, 44,
                    ScreenWidth - 12 - 12 - 60, 44)];
    [lvJob setTextColor:GetUIColor(0x333333)];
    [lvJob setFont:lbFont];
    [lvJob setTextAlignment:NSTextAlignmentRight];
    [firstbox addSubview:lvJob];

    UILabel *lvSubJob =
            [[UILabel alloc] initWithFrame:CGRectMake(12 + 60, 88,
                    ScreenWidth - 12 - 12 - 60, 44)];
    [lvSubJob setTextColor:GetUIColor(0x333333)];
    [lvSubJob setFont:lbFont];
    [lvSubJob setTextAlignment:NSTextAlignmentRight];
    [firstbox addSubview:lvSubJob];

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
    _cvTags = [[TagCollectionView alloc] initWithTags:@[]];

    [container addSubview:_cvTags];
    [_cvTags mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line5.mas_bottom);
        make.left.mas_equalTo(container.mas_left);
        make.right.mas_equalTo(container.mas_right);
        make.height.mas_equalTo([_cvTags fullHeight]);
    }];

    /** container 自适应 */
    [container mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_cvTags.mas_bottom);
    }];
    __weak UserInfoController* safeSelf = self;
    [OApiManager userWithUserSign:self.usersign success:^(UserModel *user) {
        _user=user;
        
        safeSelf.title= user.nick_name;
        _lbName.text = user.nick_name;
        
        [_cvPhotos bindData:user.photos];
        [_cvPhotos mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(ScreenWidth, [_cvPhotos fullHeight]));
        }];
        
        _lbSubField.text =
                [NSString stringWithFormat:@"%@ %@", user.constellation, user.liveplace];
        _lbActiveTime.text = [[NSDate dateWithTimeIntervalSince1970:user.activity_time] compareCurrentTime];

        if (user.click_type == LikeEnumYes) {
            [_ivLike setImage:[UIImage imageNamed:@"xin"] forState:
             UIControlStateNormal];
            [_ivLike setTitle:@"已赞" forState:UIControlStateNormal];
            [_ivLike.layer setBorderColor:[GetUIColor(0xf0f0f0) CGColor]];
            [_ivLike setTitleColor:GetUIColor(0x666666) forState:UIControlStateNormal];
        } else if(user.click_type == LikeEnumBoth){
            [_ivLike setImage:[UIImage imageNamed:@"icon_phone"] forState:
             UIControlStateNormal];
            [_ivLike setTitle:@"打电话" forState:UIControlStateNormal];
            [_ivLike.layer setBorderColor:[GetUIColor(0x3891eb) CGColor]];
            [_ivLike setTitleColor:GetUIColor(0x3891eb) forState:UIControlStateNormal];
        } else{
            [_ivLike setImage:[UIImage imageNamed:@"xinhas"] forState:
             UIControlStateNormal];
            if (user.sex == SexEnumMen) {
                [_ivLike setTitle:@"赞他" forState:UIControlStateNormal];
            } else {
                [_ivLike setTitle:@"赞她" forState:UIControlStateNormal];
            }
            [_ivLike.layer setBorderColor:[GetUIColor(0xf0f0f0) CGColor]];
            [_ivLike setTitleColor:GetUIColor(0x666666) forState:UIControlStateNormal];
        }
        [lvIwant setText:user.hope];
        [lvJob setText:user.profession];
        [lvSubJob setText:user.school];

        _tvSignature.text = user.personal_signature;
        [_tvSignature mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo([user.personal_signature heightWithFont:[UIFont systemFontOfSize:15] Width:self.view.frame.size.width - 24] + 20);
        }];

        [_cvTags bindData:[[OPlistManager instance] abilitysWithArray:user.traits]
        ];
        [_cvTags mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo([_cvTags fullHeight]);
        }];
    } failure:^(NSNumber *code, NSString *error) {
        NSLog(@"%@", error);
    }];
}

- (void)tapLike {
    
    switch (_user.click_type) {
        case LikeEnumNone:
        {
            [_ivLike setImage:[UIImage imageNamed:@"xin"] forState:
             UIControlStateNormal];
            [_ivLike setTitle:@"已赞" forState:UIControlStateNormal];
            [OApiManager likeUser:_user.usersign success:nil failure:nil];
        } 
            break;
        case LikeEnumYes:
        
            break;
        case LikeEnumBoth:
        {
            CallOutController *vc = [CallOutController initWithVoipaccount:_user.voip.voip_account userSign:_user.usersign];
            [self presentViewController:vc animated:YES completion:^{
                
            }];
        }
            break;
        default:
            break;
    }
    
    
}

- (void)tapMore {
    UIActionSheet *sheet = [UIActionSheet bk_actionSheetWithTitle:@"操作"];
    [sheet bk_setCancelButtonWithTitle:@"取消" handler:^{

    }];
    [sheet bk_addButtonWithTitle:@"举报" handler:^{

    }];
    if(_user.click_type==LikeEnumBoth){
        [sheet bk_addButtonWithTitle:@"解除通话权限" handler:^{
            [_ivLike setImage:[UIImage imageNamed:@"xinhas"] forState:
             UIControlStateNormal];
            if (_user.sex == SexEnumMen) {
                [_ivLike setTitle:@"赞他" forState:UIControlStateNormal];
            } else {
                [_ivLike setTitle:@"赞她" forState:UIControlStateNormal];
            }
            [_ivLike.layer setBorderColor:[GetUIColor(0xf0f0f0) CGColor]];
            [_ivLike setTitleColor:GetUIColor(0x666666) forState:UIControlStateNormal];
            [OApiManager removeAuthorityWithUsersign:_usersign success:^(NSString *messages) {
                [Hud showText:messages];
            } failure:^(NSNumber *code, NSString *error) {
                [_ivLike setImage:[UIImage imageNamed:@"icon_phone"] forState:
                 UIControlStateNormal];
                [_ivLike setTitle:@"打电话" forState:UIControlStateNormal];
                [_ivLike.layer setBorderColor:[GetUIColor(0x3891eb) CGColor]];
                [_ivLike setTitleColor:GetUIColor(0x3891eb) forState:UIControlStateNormal];
                [Hud showText:error];
            }];
        }];
    }
    [sheet showInView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 * #pragma mark - Navigation
 *
 * // In a storyboard-based application, you will often want to do a little preparation before navigation
 * - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 *  // Get the new view controller using [segue destinationViewController].
 *  // Pass the selected object to the new view controller.
 * }
 */

@end
