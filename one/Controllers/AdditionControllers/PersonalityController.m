//
//  PersonalityController.m
//  one
//
//  Created by JasKang on 15/5/26.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#define kPersonalityCell @"PersonalityCell"


#import "PersonalityController.h"
#import "PersonalityCell.h"
#import "OPlistManager.h"

#import <RTSpinKitView.h>

@interface PersonalityController ()

@property(strong, nonatomic) UITableView *myTableView;
@property(nonatomic, strong) NSArray *value;
@property(nonatomic, copy) void(^doneBlock)(NSMutableArray *value);

@property(nonatomic, strong) RTSpinKitView *loading;

@property(nonatomic, strong) NSMutableArray *listdata;

@end

@implementation PersonalityController

+ (instancetype)showWithTitle:(NSString *)title defaultValue:(NSArray *)defaultvalue
                    doneBlock:(void (^)(NSMutableArray *value))block {
    PersonalityController *vc = [[PersonalityController alloc] init];
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
    self.view.backgroundColor = UIColorBackGray;

    _listdata = [[NSMutableArray alloc] initWithArray:[[OPlistManager instance] abilitys]];
    for (TraitModel *obj in _listdata) {
        obj.check = NO;
        for (NSNumber *temp_id in _value) {
            if ([temp_id isEqualToNumber:obj.ability_id]) {
                obj.check = YES;
            }
        }
    }


    _loading = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleThreeBounce color:UIColorBule];

    _loading.center = self.view.center;
    [_loading startAnimating];
    [self.view addSubview:_loading];

    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = UIColorBackGray;
        [tableView registerClass:[PersonalityCell class] forCellReuseIdentifier:kPersonalityCell];
        tableView;
    });
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_loading stopAnimating];
    [self.view addSubview:_myTableView];

}

- (void)viewDidDisappear:(BOOL)animated {
    NSMutableArray *selectValue = [[NSMutableArray alloc] init];
    for (TraitModel *obj in _listdata) {
        if (obj.check) {
            [selectValue addObject:obj.ability_id];
        }
    }
    _doneBlock(selectValue);
    [super viewDidDisappear:animated];
}

#pragma mark Table M

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listdata.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonalityCell *cell = [tableView dequeueReusableCellWithIdentifier:kPersonalityCell forIndexPath:indexPath];
    TraitModel *obj = _listdata[indexPath.row];
    [cell configWithUrl:obj.ability_icon_url Title:obj.ability_name isCheck:obj.check];
    [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:15];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TraitModel *obj = _listdata[indexPath.row];
    obj.check = !obj.check;
    [_myTableView reloadDataAtSection:indexPath.section AtRow:indexPath.row];
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
