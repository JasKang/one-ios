//
//  MsgController.m
//  one
//
//  Created by JasKang on 15/5/24.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#define kChatCell @"ChatCell"

#import "MsgController.h"
#import "ODBManager.h"
#import "MessageCell.h"
#import "ChatController.h"
#import "NewNoticeController.h"


@interface MsgController ()

@property(strong, nonatomic) UITableView *myTableView;

@property(nonatomic, strong) NSMutableArray *models;

@end

@implementation MsgController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect frame = [UIView frameWithOutNav];
    self.view = [[UIView alloc] initWithFrame:frame];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"消息";
    _models = [[NSMutableArray alloc] init];

    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.backgroundColor = UIColorBackGray;
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView registerClass:[MessageCell class] forCellReuseIdentifier:kChatCell];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.rowHeight = 74;
        [self.view addSubview:tableView];
        tableView;
    });

    if (self.rdv_tabBarController.tabBar.translucent) {
        CGFloat tabBarHeight = CGRectGetHeight(self.rdv_tabBarController.tabBar.frame);
        UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, tabBarHeight, 0);

        _myTableView.contentInset = insets;
        _myTableView.scrollIndicatorInsets = insets;
    }
    [self localData];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doRefresh) name:kNewPush object:nil];
    
}


- (void)localData {
    NSArray *cachechats = [[ODBManager instance] messageArray];
    [_models removeAllObjects];
    [_models addObjectsFromArray:cachechats];
    [_myTableView reloadData];
    NSInteger newcount = 0;
    for (MsgModel *object in cachechats) {
        newcount = newcount + object.new_message_count;
    }
    if (newcount > 0) {
        self.rdv_tabBarItem.badgeValue = [NSString stringWithFormat:@"%@", @(newcount)];
    }
}

- (void)doRefresh {
    [OApiManager friendListSuccess:^(NSArray *chats) {
        [_models removeAllObjects];
        [_models addObjectsFromArray:chats];
        [_myTableView reloadData];
        NSInteger newcount = 0;
        for (MsgModel *object in chats) {
            newcount = newcount + object.new_message_count;
        } 
        if (newcount > 0) {
            self.rdv_tabBarItem.badgeValue = [NSString stringWithFormat:@"%@", @(newcount)];
        }else{
            self.rdv_tabBarItem.badgeValue = @"";
        }
    } failure:^(NSNumber *code, NSString *error) {

    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self doRefresh];
}

#pragma mark Table M

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:kChatCell forIndexPath:indexPath];
    [cell bindData:_models[indexPath.row]];
    [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:74];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MsgModel *obj = _models[indexPath.row];
    if (obj.type == MessageTypeNewer) {
        NewNoticeController *noticeVC = [[NewNoticeController alloc] init];
        [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
        [self.navigationController pushViewController:noticeVC animated:YES];
    } else {
        ChatController *messageVC = [ChatController initWithVoipAccount:obj.voip.voip_account UserSign:obj.usersign photo:obj.photo];
        [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
        [self.navigationController pushViewController:messageVC animated:YES];
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    //第四步,消息发送完,要移除掉
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNewPush object:nil];
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
