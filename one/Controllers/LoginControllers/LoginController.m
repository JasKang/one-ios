//
//  LoginController.m
//  one
//
//  Created by JasKang on 15/5/25.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//
#define kLoginCell @"LabeTextFiledCell"

#import "LoginController.h"
#import "LabeTextFiledCell.h"
#import "PerfectInfoController.h"

@interface LoginController ()

@property(strong, nonatomic) UITableView *myTableView;
@property(strong, nonatomic) NSString *phone_number;
@property(strong, nonatomic) NSString *password;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect frame = [UIView frameWithOutNav];
    self.view = [[UIView alloc] initWithFrame:frame];
    self.title = @"登录";

    self.phone_number = @"18655351675";
    self.password = @"k123456";
    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = UIColorBackGray;
        tableView.rowHeight = 55.0f;
        [tableView registerClass:[LabeTextFiledCell class] forCellReuseIdentifier:kLoginCell];

        [self.view addSubview:tableView];
        tableView;
    });


    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    [headerView setBackgroundColor:UIColorBackGray];
    _myTableView.tableHeaderView = headerView;

    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 75)];
    [footerView setBackgroundColor:UIColorBackGray];
    UIButton *btnNext = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnNext setFrame:CGRectMake(10, 20, ScreenWidth - 20, 54)];
    [btnNext setTitle:@"登录" forState:UIControlStateNormal];
    [btnNext setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnNext.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [btnNext setBackgroundColor:UIColorBule];
    btnNext.layer.cornerRadius = 5;
    btnNext.layer.masksToBounds = YES;
    [btnNext addTarget:self action:@selector(tapLogin:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:btnNext];
    _myTableView.tableFooterView = footerView;
}


- (void)tapLogin:(id)sender {
    [OApiManager loginWithPhoneNumber:self.phone_number password:self.password success:^(UserModel *user) {
        if (user.status == UserStatusEnumNone) {
            PerfectInfoController *perfectVC = [[PerfectInfoController alloc] init];
            [self.navigationController pushViewController:perfectVC animated:YES];
        } else {
            [AppDel toMain];
        }
    } failure:^(NSNumber *code, NSString *error) {
        [Hud showText:error];
    }];

}


#pragma mark Table M

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LabeTextFiledCell *cell = [tableView dequeueReusableCellWithIdentifier:kLoginCell forIndexPath:indexPath];
    if (indexPath.row == 0) {
        [cell configWithTitle:@"手机" placeholder:@"请输入手机号码" keyboardType:UIKeyboardTypeNumberPad isEntry:NO valueChangeBlock:^(NSString *value) {
            self.phone_number = value;
        }];
    } else {
        [cell configWithTitle:@"密码" placeholder:@"请输入密码" keyboardType:UIKeyboardTypeDefault isEntry:YES valueChangeBlock:^(NSString *value) {
            self.password = value;
        }];
    }
    [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:15];
    return cell;
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
