//
//  MessageSettingController.m
//  one
//
//  Created by JasKang on 15/5/28.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//
#define kLabelSwitchCell @"LabelSwitchCell"

#import "MessageSettingController.h"
#import "LabelSwitchCell.h"

@interface MessageSettingController ()

@property(strong, nonatomic) UITableView *myTableView;

@end

@implementation MessageSettingController

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
        [tableView registerClass:[LabelSwitchCell class] forCellReuseIdentifier:kLabelSwitchCell];
        [self.view addSubview:tableView];
        tableView;
    });
}


#pragma mark Table M

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 2;
    } else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10.0)];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 42.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 42.0)];
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, ScreenWidth - 30, 42)];
        lb.font = [UIFont systemFontOfSize:12];
        lb.textColor = GetUIColor(0x999999);
        lb.lineBreakMode = NSLineBreakByWordWrapping;
        lb.numberOfLines = 0;//上面两行设置多行显示
        lb.text = @"如果你要关闭或开启 One 的新消息通知,请在设备的\"设置\",\"通知中心\"功能中找到 One 更改";
        [footer addSubview:lb];
        return footer;
    } else if (section == 1) {
        UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 42.0)];
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, ScreenWidth - 30, 42)];
        lb.font = [UIFont systemFontOfSize:12];
        lb.textColor = GetUIColor(0x999999);
        lb.lineBreakMode = NSLineBreakByWordWrapping;
        lb.numberOfLines = 0;//上面两行设置多行显示
        lb.text = @"如果你要关闭或开启 One 的新消息通知,请在设备的\"设置\",\"通知中心\"功能中找到 One 更改";
        [footer addSubview:lb];
        return footer;
    } else {
        UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 42.0)];
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, ScreenWidth - 30, 42)];
        lb.font = [UIFont systemFontOfSize:12];
        lb.textColor = GetUIColor(0x999999);
        lb.lineBreakMode = NSLineBreakByWordWrapping;
        lb.numberOfLines = 0;//上面两行设置多行显示
        lb.text = @"如果你要关闭或开启 One 的新消息通知,请在设备的\"设置\",\"通知中心\"功能中找到 One 更改";
        [footer addSubview:lb];
        return footer;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LabelSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:kLabelSwitchCell forIndexPath:indexPath];
    if (indexPath.section == 0) {
        [cell configWithTitle:@"接受新消息通知" selected:YES];
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [cell configWithTitle:@"声音" selected:YES];
        } else {
            [cell configWithTitle:@"震动" selected:YES];
        }
    } else {
        [cell configWithTitle:@"勿扰时段(23:00 至 次日8:00)" selected:YES];
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
