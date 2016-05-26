//
//  IWantController.m
//  one
//
//  Created by JasKang on 15/5/25.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#define kIWantCell @"IWantCell"


#import "IWantController.h"
#import "IWantCell.h"
#import "OPlistManager.h"

@interface IWantController ()

@property(strong, nonatomic) UITableView *myTableView;
@property(nonatomic, strong) NSString *value;
@property(nonatomic, copy) void(^doneBlock)(NSString *value);

@property(nonatomic, strong) NSArray *listdata;

@end


@implementation IWantController

+ (instancetype)showWithTitle:(NSString *)title defaultValue:(NSString *)defaultvalue
                    doneBlock:(void (^)(NSString *value))block {
    IWantController *vc = [[IWantController alloc] init];
    vc.title = title;
    vc.value = defaultvalue;
    vc.doneBlock = block;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect frame = [UIView frameWithOutNav];
    self.view = [[UIView alloc] initWithFrame:frame];

    _listdata = [[OPlistManager instance] hopes];

    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = UIColorBackGray;
        [tableView registerClass:[IWantCell class] forCellReuseIdentifier:kIWantCell];
        [self.view addSubview:tableView];
        tableView;
    });

}


#pragma mark Table M

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listdata.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IWantCell *cell = [tableView dequeueReusableCellWithIdentifier:kIWantCell forIndexPath:indexPath];
    HopeModel *obj = _listdata[indexPath.row];
    [cell configWithTitle:obj.hope_name];
    if ([obj.hope_name isEqualToString:_value]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:15];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HopeModel *obj = _listdata[indexPath.row];
    if (_doneBlock) {
        _doneBlock(obj.hope_name);
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
