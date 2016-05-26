//
//  NewNoticeController.m
//  one
//
//  Created by JasKang on 15/6/22.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//
#define kNewNoticeCell @"kNewNoticeCell"

#import "NewNoticeController.h"
#import "NewNoticeCell.h"
#import "UserInfoController.h"

@interface NewNoticeController ()

@property(strong, nonatomic) UITableView *myTableView;

@property(nonatomic, strong) NSMutableArray *models;

@end

@implementation NewNoticeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect frame = [UIView frameWithOutNav];
    self.view = [[UIView alloc] initWithFrame:frame];
    self.view.backgroundColor = UIColorBackGray;
    self.title = @"新的通知";

    _models = [[NSMutableArray alloc] init];

    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        tableView.backgroundColor = UIColorBackGray;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 87;
        [tableView registerClass:[NewNoticeCell class] forCellReuseIdentifier:kNewNoticeCell];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        tableView;
    });
    [_myTableView setTableHeaderView:[self headerView]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self doRefresh];
}

- (void)doRefresh {
    [OApiManager noticeListSuccess:^(NSArray *messages) {
        [_models removeAllObjects];
        [_models addObjectsFromArray:messages];
        [_myTableView reloadData];
    } failure:^(NSNumber *code, NSString *error) {

    }];
}

- (UIView *)headerView {
    UIView *headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth - 20, 44)];
    [text setTextColor:GetUIColor(0x666666)];
    [text setFont:[UIFont systemFontOfSize:14]];
    [text setText:@"互赞后，你们将自动匹配为好友并开启通话权限"];
    [headV addSubview:text];
    return headV;
}

#pragma mark Table M

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:kNewNoticeCell forIndexPath:indexPath];
    [cell bindModel:_models[indexPath.row]];

    [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:18];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NewNoticeModel *obj = _models[indexPath.row];
    UserInfoController *infoVC = [UserInfoController initWithUserSign:obj.usersign];
    [self.navigationController pushViewController:infoVC animated:YES];
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
