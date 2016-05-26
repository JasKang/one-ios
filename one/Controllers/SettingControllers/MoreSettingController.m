//
//  MoreSettingController.m
//  one
//
//  Created by JasKang on 15/5/28.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//
#define kPushCell @"PushCell"

#import "MoreSettingController.h"
#import "PushCell.h"


@interface MoreSettingController ()

@property(strong, nonatomic) UITableView *myTableView;

@end

@implementation MoreSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect frame = [UIView frameWithOutNav];
    self.view = [[UIView alloc] initWithFrame:frame];
    self.view.backgroundColor = UIColorBackGray;
    self.title = @"消息设置";
    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = UIColorBackGray;
        [tableView registerClass:[PushCell class] forCellReuseIdentifier:kPushCell];
        [self.view addSubview:tableView];
        tableView;
    });
    _myTableView.tableFooterView = [self footerView];
}

- (UIView *)footerView {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 75)];
    [footerView setBackgroundColor:UIColorBackGray];
    UIButton *btnNext = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnNext setFrame:CGRectMake(10, 20, ScreenWidth - 20, 54)];
    [btnNext setTitle:@"退出登录" forState:UIControlStateNormal];
    [btnNext setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnNext.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [btnNext setBackgroundColor:[UIColor redColor]];
    btnNext.layer.cornerRadius = 5;
    btnNext.layer.masksToBounds = YES;
    [btnNext addTarget:self action:@selector(tapLogout) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:btnNext];
    return footerView;
}

- (void)tapLogout {
    [AppDel logout];
}

#pragma mark Table M

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return 1;
    } else {
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10.0)];
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PushCell *cell = [tableView dequeueReusableCellWithIdentifier:kPushCell forIndexPath:indexPath];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [cell configWithTitle:@"手机号" subTitle:@"18655351675"];
        } else {
            [cell configWithTitle:@"修改登录密码" subTitle:@""];
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [cell configWithTitle:@"意见反馈" subTitle:@""];
        } else {
            [cell configWithTitle:@"关于我们" subTitle:@""];
        }
    } else {
        [cell configWithTitle:@"清理缓存" subTitle:@""];
    }

    [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:15];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 52.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
