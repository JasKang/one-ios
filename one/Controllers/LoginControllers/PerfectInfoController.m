//
//  PerfectInfoController.m
//  one
//
//  Created by JasKang on 15/5/25.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#define kPerfectCell @"LabeTextPushCell"

#import "PerfectInfoController.h"
#import "SingleTextController.h"
#import "IWantController.h"
#import "JobController.h"
#import "PersonalityController.h"
#import "LabeTextPushCell.h"
#import "JasPicker.h"

#import "UIActionSheet+BlocksKit.h"
#import "UIImagePickerController+BlocksKit.h"


@interface PerfectInfoController ()

@property(strong, nonatomic) UITableView *myTableView;

@property(nonatomic, strong) UIButton *btnPhoto;

@property(nonatomic, strong) UIDatePicker *datepicker;

@property(nonatomic, strong) PutPerfectModel *data;

@end


@implementation PerfectInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect frame = [UIView frameWithOutNav];
    self.view = [[UIView alloc] initWithFrame:frame];
    self.title = @"完善资料";
    self.data = [[PutPerfectModel alloc] init];
    //添加myTableView
    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.backgroundColor = UIColorBackGray;
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableView registerClass:[LabeTextPushCell class] forCellReuseIdentifier:kPerfectCell];
        [self.view addSubview:tableView];
        tableView;
    });
    _myTableView.tableHeaderView = [self headerView];
    _myTableView.tableFooterView = [self footerView];

    self.datepicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, ScreenWidth, 216)];
    self.datepicker.datePickerMode = UIDatePickerModeDate;
    self.datepicker.maximumDate = [NSDate date];
    self.datepicker.minimumDate = [[NSDate alloc] initWithTimeIntervalSince1970:-2209013939];

    self.datepicker.timeZone = [NSTimeZone defaultTimeZone];
    self.datepicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"];
}


- (UIView *)headerView {
    UIView *headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 125)];
    [headV setBackgroundColor:UIColorBackGray];
    self.btnPhoto = [[UIButton alloc] initWithFrame:CGRectMake((ScreenWidth - 100) / 2, 25, 100, 100)];
    [self.btnPhoto setBackgroundImage:[UIImage imageNamed:@"select_photo"] forState:UIControlStateNormal];
    self.btnPhoto.layer.cornerRadius = 3;
    self.btnPhoto.layer.masksToBounds = YES;
    [self.btnPhoto setImageEdgeInsets:UIEdgeInsetsZero];
    [self.btnPhoto addTarget:self action:@selector(tapPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [headV addSubview:self.btnPhoto];
    return headV;
}

- (UIView *)footerView {
    UIView *footerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 108)];
    [footerV setBackgroundColor:UIColorBackGray];
    UIButton *btnLogin = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnLogin setFrame:CGRectMake(10, 30, ScreenWidth - 20, 54)];
    [btnLogin setTitle:@"保存资料" forState:UIControlStateNormal];
    [btnLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnLogin.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [btnLogin setBackgroundColor:UIColorBule];
    btnLogin.layer.cornerRadius = 3;
    btnLogin.layer.masksToBounds = YES;
    [btnLogin addTarget:self action:@selector(tapSave:) forControlEvents:UIControlEventTouchUpInside];
    [footerV addSubview:btnLogin];
    return footerV;
}

- (void)tapSave:(id)sender {
    //    photo_url 头像url 字符串url
    //    nick_name 昵称 字符串
    //    sex 性别 0 未设置 1女 2男
    //    birthday 生日 时间戳
    //    liveplace 居住地 字符串
    //    hope 我想 字符串
    //    profession 行业 字符串
    //    school 学校 字符串
    //    abilities 个性标签 例如: 3,6,16

    NSDictionary *params = @{@"photo_url" : _data.photo_url,
            @"nick_name" : _data.nick_name,
            @"sex" : @(_data.sex),
            @"birthday" : @(_data.birthday),
            @"liveplace" : _data.liveplace,
            @"hope" : _data.hope,
            @"profession" : _data.profession,
            @"school" : _data.school,
            @"abilitys" : [_data.traits JSONString]
    };
    [OApiManager perfectOwnWithParams:params success:^(UserModel *user) {
        [AppDel toMain];
    } failure:^(NSNumber *code, NSString *error) {
        [Hud showText:error];
    }];
}

- (void)tapPhoto:(id)sender {
    UIActionSheet *avatarSheet = [UIActionSheet bk_actionSheetWithTitle:@"选择照片"];

    __weak id safeSelf = self;
    [avatarSheet bk_addButtonWithTitle:@"拍照" handler:^{
        if (![Util checkCameraAuthorizationStatus]) {
            return;
        }
        UIImagePickerController *cameraPicker = [[UIImagePickerController alloc] init];
        cameraPicker.allowsEditing = YES;//设置可编辑
        cameraPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        cameraPicker.delegate=safeSelf;
        [self presentViewController:cameraPicker animated:YES completion:nil];//进入照相界面
    }];
    [avatarSheet bk_addButtonWithTitle:@"从相册中选取" handler:^{
        if (![Util checkPhotoLibraryAuthorizationStatus]) {
            return;
        }
        UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
        photoPicker.allowsEditing = YES;//设置可编辑
        photoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        photoPicker.delegate=safeSelf;
        [self presentViewController:photoPicker animated:YES completion:nil];//进入照相界面
    }];
    [avatarSheet bk_setCancelButtonWithTitle:@"取消" handler:^{

    }];
    avatarSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [avatarSheet showInView:self.view];
}


#pragma mark UIImagePickerController

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    editedImage = [UIImage imageWithImage:editedImage scaledToSize:CGSizeMake(640, 640)];
    NSData *data = UIImageJPEGRepresentation(editedImage, 1.0);
    [self.btnPhoto setImage:editedImage forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];

    QNUploadManager *QnUpload = [AppDel QNManager];
    __weak PerfectInfoController *safeSelf = self;
    [QnUpload putData:data key:[AppDel imageSaveKey] token:[AppDel makeQiNiuToken] complete:^(QNResponseInfo *responseInfo, NSString *key, NSDictionary *resp) {
        if (responseInfo.statusCode == 200) {
            [safeSelf.btnPhoto setImage:editedImage forState:UIControlStateNormal];
            safeSelf.data.photo_url = [NSString stringWithFormat:@"%@/%@", qn_host, key];
        } else {
            [Hud showText:responseInfo.error.description];
        }
    } option:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Table M

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    } else if (section == 1) {
        return 2;
    } else if (section == 2) {
        return 1;
    } else {
        return 0;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30.0)];
    header.backgroundColor = UIColorBackGray;
    return header;
}

//去掉UItableview headerview黏性(sticky)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 30.0;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LabeTextPushCell *cell = [tableView dequeueReusableCellWithIdentifier:kPerfectCell forIndexPath:indexPath];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                [cell configWithTitle:@"名字" value:_data.nick_name placeholder:@"最多可填写16个字符"];
                break;
            case 1:
                [cell configWithTitle:@"性别" value:[_data sexText] placeholder:@"选择后不可修改"];
                break;
            case 2:
                [cell configWithTitle:@"出生日期" value:[_data birthdayText] placeholder:@"选择后自动匹配年龄和星座"];
                break;
            case 3:
                [cell configWithTitle:@"常住地" value:_data.liveplace placeholder:@"选择常住地"];
                break;
            case 4:
                [cell configWithTitle:@"我想" value:_data.hope placeholder:@"我想"];
                break;
            default:
                break;

        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [cell configWithTitle:@"行业" value:_data.profession placeholder:@"选择行业"];
        } else {
            [cell configWithTitle:@"学校" value:_data.school placeholder:@"在读或毕业院校"];
        }
    } else {
        [cell configWithTitle:@"个性标签" value:[_data traitsText] placeholder:@"选择个性标签"];
    }

    [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:15];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak PerfectInfoController *safeSelf = self;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            SingleTextController *singleVC = [SingleTextController showWithTitle:@"名字" defaultValue:_data.nick_name placeholder:@"最多可填写16个字符" doneBlock:^(NSString *value) {
                safeSelf.data.nick_name = value;
                [safeSelf.myTableView reloadDataAtSection:0 AtRow:0];
            }];
            [self.navigationController pushViewController:singleVC animated:YES];
        } else if (indexPath.row == 1) {
            NSArray *array = @[@"男", @"女"];
            JasPicker *pick = [[JasPicker alloc] initWithArray:array Complete:^(NSString *value) {
                if ([value isEqualToString:@"男"]) {
                    safeSelf.data.sex = SexEnumMen;
                } else {
                    safeSelf.data.sex = SexEnumWomen;
                }
                [safeSelf.myTableView reloadDataAtSection:0 AtRow:1];
            }];
            [pick show];
        } else if (indexPath.row == 2) {
            NSDateFormatter *formater = [[NSDateFormatter alloc] init];
            [formater setDateFormat:@"yyyy-MM-dd"];
            NSDate *oldDate = [NSDate dateWithTimeIntervalSince1970:_data.birthday];
            if (_data.birthday==0) {
                oldDate = [formater dateFromString:@"1990-01-01"];
            }
            JasPicker *pick = [[JasPicker alloc] initWithDate:oldDate UIDatePicker:_datepicker Complete:^(NSDate *value) {
                safeSelf.data.birthday = (NSInteger) [value timeIntervalSince1970];
                [safeSelf.myTableView reloadDataAtSection:0 AtRow:2];
            }];
            [pick show];
        } else if (indexPath.row == 3) {
            NSBundle *bundle = [NSBundle mainBundle];
            NSString *path = [bundle pathForResource:@"city" ofType:@"plist"];
            NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:path];
            JasPicker *pick = [[JasPicker alloc] initWithDictionary:dictionary Complete:^(NSString *key, NSString *value) {
                safeSelf.data.liveplace = [NSString stringWithFormat:@"%@-%@", key, value];
                [safeSelf.myTableView reloadDataAtSection:0 AtRow:3];
            }];
            [pick show];
        } else {
            IWantController *iwantVC = [IWantController showWithTitle:@"我想" defaultValue:_data.hope doneBlock:^(NSString *value) {
                safeSelf.data.hope = value;
                [safeSelf.myTableView reloadDataAtSection:0 AtRow:4];
            }];
            [self.navigationController pushViewController:iwantVC animated:YES];
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            JobController *jobVC = [JobController showWithTitle:@"选择职业" defaultValue:_data.profession doneBlock:^(NSString *value) {
                safeSelf.data.profession = value;
                [safeSelf.myTableView reloadDataAtSection:1 AtRow:0];
            }];
            [self.navigationController pushViewController:jobVC animated:YES];
        } else {
            SingleTextController *singleVC = [SingleTextController showWithTitle:@"学校" defaultValue:_data.school placeholder:@"最多可填写16个字符" doneBlock:^(NSString *value) {
                safeSelf.data.school = value;
                [safeSelf.myTableView reloadDataAtSection:1 AtRow:1];
            }];
            [self.navigationController pushViewController:singleVC animated:YES];
        }
    } else {
        PersonalityController *personalityVC = [PersonalityController showWithTitle:@"选择个性标签" defaultValue:_data.traits doneBlock:^(NSMutableArray *value) {
            safeSelf.data.traits = value;
            [safeSelf.myTableView reloadDataAtSection:2 AtRow:0];
        }];
        [self.navigationController pushViewController:personalityVC animated:YES];
    }
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
