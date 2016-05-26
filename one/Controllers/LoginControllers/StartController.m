//
//  StartController.m
//  one
//
//  Created by JasKang on 15/5/25.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#import "StartController.h"
#import "LoginController.h"
#import "RegisterController.h"


@interface StartController ()

@end

@implementation StartController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTranslucent:NO];

    UIImageView *bg = [[UIImageView alloc] initWithFrame:ScreenBounds];
    bg.contentMode = UIViewContentModeScaleAspectFill;
    bg.image = [UIImage imageNamed:@"startbg"];
    [self.view addSubview:bg];

    UIButton *btnLogin = [UIButton buttonWithType:UIButtonTypeSystem];
    btnLogin.frame = CGRectMake(10, ScreenHeight - 174, ScreenWidth - 20, 54);
    [btnLogin setTitle:@"登录" forState:UIControlStateNormal];
    btnLogin.backgroundColor = UIColorBule;
    btnLogin.titleLabel.font = [UIFont systemFontOfSize:21.f];
    btnLogin.tintColor = [UIColor whiteColor];
    btnLogin.layer.cornerRadius = 5;
    btnLogin.layer.masksToBounds = YES;
    [btnLogin addTarget:self action:@selector(tapLogin:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:btnLogin];

    UIButton *btnReg = [UIButton buttonWithType:UIButtonTypeSystem];
    btnReg.frame = CGRectMake(10, ScreenHeight - 108, ScreenWidth - 20, 54);
    [btnReg setTitle:@"注册" forState:UIControlStateNormal];
    btnReg.backgroundColor = [UIColor whiteColor];
    btnReg.titleLabel.font = [UIFont systemFontOfSize:21.f];
    btnReg.tintColor = UIColorBule;
    btnReg.layer.cornerRadius = 5;
    btnReg.layer.masksToBounds = YES;
    [btnReg addTarget:self action:@selector(tapReg:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnReg];
}

- (void)tapLogin:(id)sender {
    LoginController *loginVC = [[LoginController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
    //    [AppDel toMain];
}

- (void)tapReg:(id)sender {
    RegisterController *regVC = [[RegisterController alloc] init];
    [self.navigationController pushViewController:regVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
