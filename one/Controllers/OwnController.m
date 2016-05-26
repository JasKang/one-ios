//
//  OwnController.m
//  one
//
//  Created by JasKang on 15/5/24.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#define kIconTextPushCell @"IconTextPushCell"
#define kUserPushCell @"UserPushCell"

#import "OwnController.h"
#import "OwnInfoController.h"
#import "MessageSettingController.h"
#import "MoreSettingController.h"

#import "IconTextPushCell.h"
#import "UserPushCell.h"

@interface OwnController ()

@property(strong, nonatomic) UITableView *myTableView;

@property(nonatomic, strong) NSMutableArray *models;

@property(nonatomic, strong) NSArray *configs;

@end

@implementation OwnController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect frame = [UIView frameWithOutNavTab];
    self.view = [[UIView alloc] initWithFrame:frame];
    self.view.backgroundColor = UIColorBackGray;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"我的";

    _configs = @[
            @[
                    @{@"image" : @"photo", @"text" : @"个人"}
            ],
            @[
                    @{@"image" : @"icon_edit", @"text" : @"编辑资料"},
                    @{@"image" : @"icon_messageSetting", @"text" : @"消息设置"}
            ],
            @[
                    @{@"image" : @"icon_share", @"text" : @"分享"},
                    @{@"image" : @"icon_Setting", @"text" : @"更多设置"}
            ]
    ];
    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.backgroundColor = UIColorBackGray;
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView registerClass:[IconTextPushCell class] forCellReuseIdentifier:kIconTextPushCell];
        [tableView registerClass:[UserPushCell class] forCellReuseIdentifier:kUserPushCell];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        tableView;
    });
    if (self.rdv_tabBarController.tabBar.translucent) {
        CGFloat tabBarHeight = CGRectGetHeight(self.rdv_tabBarController.tabBar.frame);
        UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, tabBarHeight, 0);
        
        _myTableView.contentInset = insets;
        _myTableView.scrollIndicatorInsets = insets;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadUser) name:kReloadUser object:nil];
}
-(void)reloadUser{
    [_myTableView reloadDataAtSection:0 AtRow:0];
}


#pragma mark Table M

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_configs count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_configs[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 12.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 12)];
    header.backgroundColor = UIColorBackGray;
    return header;
}

//去掉UItableview headerview黏性(sticky)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 12.f;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UserPushCell *cell = [tableView dequeueReusableCellWithIdentifier:kUserPushCell forIndexPath:indexPath];
        [cell configWithImageUrl:[AppDel localUser].photo Title:[NSString stringWithFormat:@"%@,%@", [AppDel localUser].nick_name, [AppDel localUser].age] subTitle:[NSString stringWithFormat:@"%@ %@", [AppDel localUser].constellation, [AppDel localUser].liveplace]];
        [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:17];
        return cell;
    } else {
        IconTextPushCell *cell = [tableView dequeueReusableCellWithIdentifier:kIconTextPushCell forIndexPath:indexPath];

        [cell configWithTitle:_configs[indexPath.section][indexPath.row][@"text"] imageName:_configs[indexPath.section][indexPath.row][@"image"]];

        [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:17];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 91;
    } else {
        return 52;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        OwnInfoController *ownVC = [[OwnInfoController alloc] init];
        [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
        [self.navigationController pushViewController:ownVC animated:YES];
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {

        } else {
            MessageSettingController *msgSt = [[MessageSettingController alloc] init];
            [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
            [self.navigationController pushViewController:msgSt animated:YES];
        }
    } else {
        if (indexPath.row == 0) {

        } else {
            MoreSettingController *moreSt = [[MoreSettingController alloc] init];
            [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
            [self.navigationController pushViewController:moreSt animated:YES];
        }
    }

}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
    [OApiManager ownSuccess:nil failure:nil];
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
