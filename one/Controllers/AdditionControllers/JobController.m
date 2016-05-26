//
//  JobController.m
//  one
//
//  Created by JasKang on 15/5/25.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#define kHalfCell @"HalfCell"

#import "JobController.h"
#import "HalfCell.h"
#import "OPlistManager.h"

@interface JobController ()

@property(strong, nonatomic) UITableView *industryTable;
@property(strong, nonatomic) UITableView *jobTable;
@property(nonatomic, strong) NSString *value;
@property(nonatomic, copy) void(^doneBlock)(NSString *value);

@property(nonatomic, strong) NSArray *listdata;
@property(nonatomic, assign) NSUInteger index1;
@property(nonatomic, assign) NSUInteger index2;
@end

@implementation JobController


+ (instancetype)showWithTitle:(NSString *)title defaultValue:(NSString *)defaultvalue
                    doneBlock:(void (^)(NSString *value))block {
    JobController *vc = [[JobController alloc] init];
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
    self.index1 = 0;
    self.index2 = 0;

    _listdata = [[OPlistManager instance] professions];

    _industryTable = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width / 2, self.view.height) style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.tag = 111;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor whiteColor];
        [tableView registerClass:[HalfCell class] forCellReuseIdentifier:kHalfCell];
        [self.view addSubview:tableView];
        tableView;
    });
    _jobTable = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.width / 2, 0, self.view.width / 2, self.view.height) style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = UIColorBackGray;
        tableView.layer.borderWidth = 0.5;
        tableView.layer.borderColor = UIColorLine.CGColor;
        [tableView registerClass:[HalfCell class] forCellReuseIdentifier:kHalfCell];
        [self.view addSubview:tableView];
        tableView;
    });
}


#pragma mark Table M

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 111) {
        return _listdata.count;
    } else {
        return [((JobModel *) _listdata[self.index1]).sub count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HalfCell *cell = [tableView dequeueReusableCellWithIdentifier:kHalfCell forIndexPath:indexPath];

    if (tableView.tag == 111) {
        JobModel *obj = _listdata[indexPath.row];
        [cell configTitle:obj.profession_class_name];
        [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:15];
    } else {
        cell.backgroundColor = UIColorBackGray;
        JobModel *obj = _listdata[self.index1];
        JobModel *subObj = obj.sub[indexPath.row];
        [cell configTitle:subObj.profession_name];
        [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:0];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 111) {
        self.index1 = indexPath.row;
        [_jobTable reloadData];
    } else {
        if (_doneBlock) {
            JobModel *obj = _listdata[self.index1];
            JobModel *subObj = obj.sub[indexPath.row];
            if ([subObj.profession_name isEqualToString:@"在校学生"]) {
                _doneBlock(subObj.profession_name);
            }else{
                _doneBlock([NSString stringWithFormat:@"%@ %@",obj.profession_class_name,subObj.profession_name]);
            }
            
        }
        [self.navigationController popViewControllerAnimated:YES];

    }
    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
