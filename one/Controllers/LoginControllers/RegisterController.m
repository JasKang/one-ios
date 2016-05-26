//
//  RegisterController.m
//  one
//
//  Created by JasKang on 15/5/25.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#define kRegisterCell @"LabeTextFiledCell"
#define kCheckCodeCell @"UICheckCodeCell"

#import "RegisterController.h"
#import "LabeTextFiledCell.h"
#import "UICheckCodeCell.h"
#import "PerfectInfoController.h"

@interface RegisterController ()

@property(strong, nonatomic) UITableView *myTableView;
@property(strong, nonatomic) UICheckCodeCell *codeCell;
@property(strong, nonatomic) NSString *phone_number;
@property(strong, nonatomic) NSString *password;
@property(strong, nonatomic) NSString *code;

@end

@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect frame = [UIView frameWithOutNav];
    self.view = [[UIView alloc] initWithFrame:frame];
    self.title = @"注册";
    self.phone_number = @"";
    self.password = @"";
    self.code = @"";
    self.codeCell = [[UICheckCodeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RegCheckCodeCell"];
    //    添加myTableView
    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = UIColorBackGray;
        [tableView registerClass:[LabeTextFiledCell class] forCellReuseIdentifier:kRegisterCell];
        [tableView registerClass:[UICheckCodeCell class] forCellReuseIdentifier:kCheckCodeCell];

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
    [btnNext setTitle:@"下一步" forState:UIControlStateNormal];
    [btnNext setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnNext.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [btnNext setBackgroundColor:UIColorBule];
    btnNext.layer.cornerRadius = 5;
    btnNext.layer.masksToBounds = YES;
    [btnNext addTarget:self action:@selector(tapReg:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:btnNext];
    _myTableView.tableFooterView = footerView;
}


- (void)tapReg:(id)sender {
    [OApiManager regWithPhoneNumber:self.phone_number password:self.password smscode:self.code success:^(UserModel *user) {
        if (user.status == UserStatusEnumNone) {
            PerfectInfoController *perfectVC = [[PerfectInfoController alloc] init];
            [self.navigationController pushViewController:perfectVC animated:YES];
        } else {

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
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    switch (indexPath.row) {
        case 0: {
            cell = [tableView dequeueReusableCellWithIdentifier:kRegisterCell forIndexPath:indexPath];
            [(LabeTextFiledCell *) cell configWithTitle:@"手机" placeholder:@"请输入手机号码" keyboardType:UIKeyboardTypeNumberPad isEntry:NO valueChangeBlock:^(NSString *value) {
                self.phone_number = value;
                if (self.codeCell) {
                    [self.codeCell configPhoneumber:value valueChangeBlock:^(NSString *value) {
                        self.code = value;
                    }];
                }
            }];
        }
            break;
        case 1: {
            cell = [tableView dequeueReusableCellWithIdentifier:kRegisterCell forIndexPath:indexPath];
            [(LabeTextFiledCell *) cell configWithTitle:@"密码" placeholder:@"请输入密码" keyboardType:UIKeyboardTypeDefault isEntry:YES valueChangeBlock:^(NSString *value) {
                self.password = value;
            }];
        }
            break;
        default: {
            cell = self.codeCell;
            [(UICheckCodeCell *) cell configPhoneumber:self.phone_number valueChangeBlock:^(NSString *value) {
                self.code = value;
            }];
        }
            break;
    }
    [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:15];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55.0;
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
