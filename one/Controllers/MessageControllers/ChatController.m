//
//  ChatController.m
//  one
//
//  Created by JasKang on 15/5/26.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#define kMessageCell @"MessageCell"

#import "ChatController.h"
#import "ChatBubbleCell.h"
#import "CallOutController.h"
#import "ODBManager.h"
#import "UserInfoController.h"

@interface ChatController ()

@property(strong, nonatomic) UIImageView *bgView;
@property(strong, nonatomic) UITableView *myTableView;
@property(strong, nonatomic) UIView *bottomBar;

@property(nonatomic, strong) NSMutableArray *histroys;
@property(nonatomic, strong) NSNumber *usersign;
@property(nonatomic, strong) NSURL *photo;
@property(nonatomic, strong) NSString *voip_account;
@end

@implementation ChatController

+ (instancetype)initWithVoipAccount:(NSString *)voip_account UserSign:(NSNumber *)usersign photo:(NSURL *)photo {
    ChatController *vc = [[ChatController alloc] init];
    vc.voip_account = voip_account;
    vc.usersign = usersign;
    vc.photo = photo;
    vc.histroys = [[NSMutableArray alloc] init];

    UserModel *user = [[ODBManager instance] userWithUserSign:usersign];
    vc.title = [NSString stringWithFormat:@"您与%@", user.nick_name];


    NSArray *cacheObj = [[ODBManager instance] chatArrayWithUsersign:usersign];
    if (cacheObj && cacheObj.count > 0) {
        [vc.histroys addObjectsFromArray:cacheObj];
    }

    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect frame = [UIView frameWithOutNav];
    self.view = [[UIView alloc] initWithFrame:frame];
    self.view.backgroundColor = GetUIColor(0x333333);

    UIBarButtonItem *userinfo = [[UIBarButtonItem alloc] initWithTitle:@"TA的主页" style:UIBarButtonItemStylePlain target:self action:@selector(tapInfo)];
    self.navigationItem.rightBarButtonItem = userinfo;

    _bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 50, ScreenWidth, 50)];
    [_bottomBar setBackgroundColor:GetUIColor(0xfefefe)];
    UIButton *btncall = [UIButton buttonWithType:UIButtonTypeSystem];
    [btncall setFrame:CGRectMake(0, 0, ScreenWidth / 2, 50)];
    [btncall setTitle:@"打电话" forState:UIControlStateNormal];
    [btncall setTitleColor:GetUIColor(0x3291f2) forState:UIControlStateNormal];
    [btncall.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [btncall setImage:LoadImage(@"Already_call") forState:UIControlStateNormal];
    [btncall addTarget:self action:@selector(tapCall) forControlEvents:UIControlEventTouchUpInside];


    UIButton *btnmore = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnmore setFrame:CGRectMake(ScreenWidth / 2, 0, ScreenWidth / 2, 50)];
    [btnmore setTitle:@"更多" forState:UIControlStateNormal];
    [btnmore setTitleColor:GetUIColor(0x3291f2) forState:UIControlStateNormal];
    [btnmore.titleLabel setFont:[UIFont systemFontOfSize:16]];

    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth / 2, 10, 0.5, 30)];
    [line setBackgroundColor:GetUIColor(0x3291f2)];
    [_bottomBar addSubview:btncall];
    [_bottomBar addSubview:btnmore];
    [_bottomBar addSubview:line];
    [self.view addSubview:_bottomBar];

    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, frame.size.height - 50) style:UITableViewStylePlain];
        tableView.backgroundColor = UIColorBackGray;
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView registerClass:[ChatBubbleCell class] forCellReuseIdentifier:kMessageCell];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.rowHeight = 74;
        [self.view addSubview:tableView];
        tableView;
    });

    _bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, frame.size.height - 50)];
    [_bgView setContentMode:UIViewContentModeScaleAspectFill];
    [_bgView sd_setImageWithURL:[_photo URLWithBlur]];
    UIView *maskbg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, frame.size.height - 50)];
    [maskbg setBackgroundColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:0.6]];
    [_bgView addSubview:maskbg];

    _myTableView.backgroundView = _bgView;

    //    [self scrollTableToFoot:NO];

    [OApiManager chatsWithUsersign:_usersign success:^(NSArray *messages) {
        if (messages.count > 0) {
            [_histroys removeAllObjects];
            [_histroys addObjectsFromArray:messages];
            [_myTableView reloadData];
        }
    } failure:^(NSNumber *code, NSString *error) {
        NSLog(@"%@", error);
    }];
}

- (void)tapCall {
    CallOutController *vc = [CallOutController initWithVoipaccount:_voip_account userSign:_usersign];
    [self presentViewController:vc animated:YES completion:^{

    }];
}

- (void)tapInfo {
    UserInfoController *infoVC = [UserInfoController initWithUserSign:_usersign];
    [self.navigationController pushViewController:infoVC animated:YES];
}


- (void)scrollTableToFoot:(BOOL)animated {
    NSInteger s = [_myTableView numberOfSections];
    if (s < 1)
        return;
    NSInteger r = [_myTableView numberOfRowsInSection:s - 1];
    if (r < 1)
        return;

    NSIndexPath *ip = [NSIndexPath indexPathForRow:r - 1 inSection:s - 1];

    [_myTableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //    [self scrollTableToFoot:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

#pragma mark Table M

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _histroys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatBubbleCell *cell = [tableView dequeueReusableCellWithIdentifier:kMessageCell forIndexPath:indexPath];
    [cell bindData:_histroys[indexPath.row] obj_photo:_photo];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatModel *note = _histroys[indexPath.row];
    return note.cellheight;
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
