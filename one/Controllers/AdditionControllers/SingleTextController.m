//
//  SingleTextController.m
//  one
//
//  Created by JasKang on 15/5/25.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#import "SingleTextController.h"

@interface SingleTextController ()

@property(nonatomic, strong) UITextField *tfvalue;
@property(nonatomic, strong) NSString *value;
@property(nonatomic, strong) NSString *placeholder;
@property(nonatomic, copy) void(^doneBlock)(NSString *value);

@end

@implementation SingleTextController

+ (instancetype)showWithTitle:(NSString *)title defaultValue:(NSString *)defaultvalue
                  placeholder:(NSString *)placeholder doneBlock:(void (^)(NSString *value))block {
    SingleTextController *vc = [[SingleTextController alloc] init];
    vc.title = title;
    vc.value = defaultvalue;
    vc.placeholder = placeholder;
    vc.doneBlock = block;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(tapDone:)];

    CGRect frame = [UIView frameWithOutNav];
    self.view = [[UIView alloc] initWithFrame:frame];
    self.view.backgroundColor = UIColorBackGray;

    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 54)];
    _tfvalue = [[UITextField alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth, 54)];
    _tfvalue.backgroundColor = [UIColor whiteColor];
    _tfvalue.leftView = paddingView;
    _tfvalue.leftViewMode = UITextFieldViewModeAlways;

    _tfvalue.layer.borderWidth = 0.5;
    _tfvalue.layer.borderColor = UIColorLine.CGColor;
    _tfvalue.text = _value;
    _tfvalue.placeholder = _placeholder;

    [self.view addSubview:_tfvalue];
}

- (void)tapDone:(id)sender {
    if (_tfvalue.text.length <= 0) {
        [Hud showText:@"怎么能什么都不写呢!"];
        return;
    }
    if (self.doneBlock) {
        self.doneBlock(_tfvalue.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
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
