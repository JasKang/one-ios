//
//  FeedController.m
//  one
//
//  Created by JasKang on 15/5/24.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#define kFeedCell @"FeedCell"

#import "FeedController.h"
#import "UserInfoController.h"

#import "FeedCell.h"
#import "UIActionSheet+BlocksKit.h"


@interface FeedController ()

@property(strong, nonatomic) UITableView *myTableView;
@property(strong, nonatomic) UIBarButtonItem *leftItem;
@property(strong, nonatomic) UIButton *btnSwitch;
@property(nonatomic, strong) NSMutableArray *feeddata;

@property(nonatomic, assign) NSInteger index;

@property(nonatomic, assign) SexEnum sexfilter;

@end

@implementation FeedController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect frame = [UIView frameWithOutNav];
    self.view = [[UIView alloc] initWithFrame:frame];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.sexfilter = SexEnumNone;

    _feeddata = [[NSMutableArray alloc] init];
    _index = 0;
    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.backgroundColor = UIColorBackGray;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 111;
        [tableView registerClass:[FeedCell class] forCellReuseIdentifier:kFeedCell];
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

    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
            initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
            target:nil action:nil];
    negativeSpacer.width = -15;

    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"homepage_logo"]];
    [logoView setFrame:CGRectMake(0, 44, 55, 44)];
    UIBarButtonItem *logoItem = [[UIBarButtonItem alloc] initWithCustomView:logoView];
    //    [logoItem seted]


    _btnSwitch = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnSwitch setFrame:CGRectMake(0, 0, 100, 20)];
    [_btnSwitch setTitle:@"在线(全部)" forState:UIControlStateNormal];
    [_btnSwitch setTitleColor:GetUIColor(0x333333) forState:UIControlStateNormal];
    [_btnSwitch setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_btnSwitch setImage:[UIImage imageNamed:@"drop_Down"] forState:UIControlStateNormal];
    //top left bottom right
    [_btnSwitch setContentEdgeInsets:UIEdgeInsetsZero];
    [_btnSwitch setImageEdgeInsets:UIEdgeInsetsMake(0, 80, 0, 0)];
    [_btnSwitch setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    [_btnSwitch addTarget:self action:@selector(tapSwitch) forControlEvents:UIControlEventTouchUpInside];

    _leftItem = [[UIBarButtonItem alloc] initWithCustomView:_btnSwitch];

    [self.navigationItem setLeftBarButtonItems:@[negativeSpacer, logoItem, _leftItem]];

    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    [_myTableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(doRefresh)];
    [_myTableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    [self doRefresh];
}

- (void)tapSwitch {
    UIActionSheet *avatarSheet = [UIActionSheet bk_actionSheetWithTitle:@"筛选"];
    [avatarSheet bk_addButtonWithTitle:@"全部" handler:^{
        [_btnSwitch setTitle:@"在线(全部)" forState:UIControlStateNormal];
        [_btnSwitch setImageEdgeInsets:UIEdgeInsetsMake(0, 80, 0, 0)];
        [_btnSwitch setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
        if (self.sexfilter != SexEnumNone) {
            self.sexfilter = SexEnumNone;
            [self doRefresh];
        }

    }];
    [avatarSheet bk_addButtonWithTitle:@"只看男" handler:^{
        [_btnSwitch setTitle:@"在线(男)" forState:UIControlStateNormal];
        [_btnSwitch setImageEdgeInsets:UIEdgeInsetsMake(0, 60, 0, 0)];
        [_btnSwitch setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
        if (self.sexfilter != SexEnumMen) {
            self.sexfilter = SexEnumMen;
            [self doRefresh];
        }
    }];
    [avatarSheet bk_addButtonWithTitle:@"只看女" handler:^{
        [_btnSwitch setTitle:@"在线(女)" forState:UIControlStateNormal];
        [_btnSwitch setImageEdgeInsets:UIEdgeInsetsMake(0, 60, 0, 0)];
        [_btnSwitch setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
        if (self.sexfilter != SexEnumWomen) {
            self.sexfilter = SexEnumWomen;
            [self doRefresh];
        }
    }];
    [avatarSheet bk_setCancelButtonWithTitle:@"取消" handler:^{

    }];
    [avatarSheet showInView:self.view];
}

- (void)doRefresh {
    [OApiManager feedsWithSex:self.sexfilter atIndex:0 success:^(NSArray *users) {
        _index = 0;
        [_feeddata removeAllObjects];
        if (users.count > 0) {
            [_feeddata addObjectsFromArray:users];
        }
        [_myTableView reloadData];
        // 拿到当前的下拉刷新控件，结束刷新状态
        [_myTableView.header endRefreshing];
    } failure:^(NSNumber *code, NSString *error) {
        // 拿到当前的下拉刷新控件，结束刷新状态
        [_myTableView.header endRefreshing];
    }];
}

- (void)loadMore {
    NSInteger toindex = _index + 1;
    [OApiManager feedsWithSex:SexEnumNone atIndex:toindex success:^(NSArray *users) {
        if (users.count > 0) {
            _index = toindex;
            [_feeddata addObjectsFromArray:users];
            [_myTableView reloadData];
            // 拿到当前的下拉刷新控件，结束刷新状态
        }
        [_myTableView.footer endRefreshing];
    } failure:^(NSNumber *code, NSString *error) {
        // 拿到当前的下拉刷新控件，结束刷新状态
        [_myTableView.footer endRefreshing];
    }];
}

#pragma mark Table M

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _feeddata.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FeedCell *cell = [tableView dequeueReusableCellWithIdentifier:kFeedCell forIndexPath:indexPath];
    [cell configWithModel:_feeddata[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UserModel *obj = _feeddata[indexPath.row];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    UserInfoController *userVC = [UserInfoController initWithUserSign:obj.usersign];
    [self.navigationController pushViewController:userVC animated:YES];
    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
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
