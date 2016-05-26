//
//  OwnEditController.m
//  one
//
//  Created by JasKang on 15/5/27.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#define kEditCell @"kEditCell"

#import "OwnEditController.h"
#import "LabeTextPushCell.h"
#import "UIActionSheet+BlocksKit.h"
#import "UIImagePickerController+BlocksKit.h"
#import "PhotoCollectionView.h"
#import "PutUserModel.h"
#import "OPlistManager.h"
#import "SingleTextController.h"
#import "JasPicker.h"
#import "IWantController.h"
#import "JobController.h"
#import "PersonalityController.h"

@interface OwnEditController ()

@property(strong, nonatomic) UITableView *myTableView;

@property(nonatomic, strong) UIDatePicker *datepicker;

@property(nonatomic, strong) PutUserModel *data;

@property(nonatomic, strong) PhotoCollectionView *cvPhotos;
@property(nonatomic,strong) UIView *boxPersonal_signature;
@property(nonatomic,strong) UIView *headerView;
@end

@implementation OwnEditController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect frame = [UIView frameWithOutNav];
    self.view = [[UIView alloc] initWithFrame:frame];
    self.title = @"编辑资料";
    self.data = [[PutUserModel alloc] init];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(tapSave:)];

    //    添加myTableView
    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.backgroundColor = UIColorBackGray;
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableView registerClass:[LabeTextPushCell class] forCellReuseIdentifier:kEditCell];
        [self.view addSubview:tableView];
        tableView;
    });
    _myTableView.tableHeaderView = [self setupHeaderView];
    //    _myTableView.tableFooterView = [self footerView];

    self.datepicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, ScreenWidth, 216)];
    self.datepicker.datePickerMode = UIDatePickerModeDate;
    self.datepicker.maximumDate = [NSDate date];
    self.datepicker.minimumDate = [[NSDate alloc] initWithTimeIntervalSince1970:-2209013939];

    self.datepicker.timeZone = [NSTimeZone defaultTimeZone];
    self.datepicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"];
}


- (UIView *)setupHeaderView {
    /** 照片 */
    _headerView=[[UIView alloc] init];
    _headerView.backgroundColor= UIColorBackGray;

    CGFloat cvheight=0,titleheight=44,textheight=0;
    
    _cvPhotos = [[PhotoCollectionView alloc] initWithImages:_data.photos delegate:self];
    cvheight=[_cvPhotos fullHeight];
    [_cvPhotos setFrame:CGRectMake(0, 0, self.view.width, cvheight)];
    [_headerView addSubview:_cvPhotos];
    
    UILabel *lbtitle=[[UILabel alloc] initWithFrame:CGRectZero];
    lbtitle.textColor= GetUIColor(0x666666);
    lbtitle.font=[UIFont systemFontOfSize:14];
    lbtitle.text=@"写一段你的心情故事";
    lbtitle.backgroundColor = UIColorBackGray;
    [_headerView addSubview:lbtitle];
    [lbtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.view.width-30, 30.0));
        make.top.mas_equalTo(_cvPhotos.mas_bottom).offset(14);
        make.left.mas_equalTo(15);
    }];
    
    textheight=[_data.personal_signature heightWithFont:[UIFont systemFontOfSize:16] Width:self.view.width-30];
    _boxPersonal_signature=[[UIView alloc] initWithFrame:CGRectMake(0, cvheight+titleheight, self.view.width,textheight+30)];
    _boxPersonal_signature.backgroundColor = [UIColor whiteColor];

    [_headerView addSubview:_boxPersonal_signature];
    [_boxPersonal_signature mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.view.width, textheight+30));
        make.top.mas_equalTo(lbtitle.mas_bottom);
        make.left.mas_equalTo(0);
    }];
    UILabel *lbtext=[[UILabel alloc] initWithFrame:CGRectMake(15,15, self.view.width-30,textheight)];
    lbtext.textColor= GetUIColor(0x333333);
    lbtext.font=[UIFont systemFontOfSize:16];
    lbtext.text=_data.personal_signature;
    lbtext.backgroundColor = [UIColor whiteColor];
    lbtext.lineBreakMode = NSLineBreakByWordWrapping;
    lbtext.numberOfLines = 0;
    [_boxPersonal_signature addSubview:lbtext];
    [lbtext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_boxPersonal_signature.mas_top).offset(15);
        make.bottom.mas_equalTo(_boxPersonal_signature.mas_bottom).offset(-15);
        make.left.mas_equalTo(_boxPersonal_signature.mas_left).offset(15);
        make.right.mas_equalTo(_boxPersonal_signature.mas_right).offset(-15);
    }];
    
    
    [_headerView setFrame:CGRectMake(0, 0, self.view.width,cvheight+titleheight+textheight+30)];
    return _headerView;
}

-(void)updateHeaderView{
    CGFloat titleheight=44;
    CGFloat cvheight=[_cvPhotos fullHeight];
    CGFloat textheight=[_data.personal_signature heightWithFont:[UIFont systemFontOfSize:16] Width:self.view.width-30];
    [_cvPhotos setFrame:CGRectMake(0, 0, self.view.width, cvheight)];
    [_headerView setFrame:CGRectMake(0, 0, self.view.width,cvheight+titleheight+textheight+30)];
    [_myTableView beginUpdates];
    [_myTableView setTableHeaderView:_headerView];
    [_myTableView endUpdates];
}

- (void)tapSave:(id)sender {
    NSDictionary *params = @{@"photo_urls" : [_data.photo_urls JSONString],
            @"personal_signature" : _data.personal_signature,
            @"nick_name" :_data.nick_name,
            @"birthday" : @(_data.birthday),
            @"liveplace" : _data.liveplace,
            @"hope" : _data.hope,
            @"profession" : _data.profession,
            @"school" : _data.school,
            @"abilitys" : [_data.traits JSONString],
            @"work_position":@""
    };
    [Hud show];
    [OApiManager updateOwnWithParams:params success:^(UserModel *model) {
        [Hud hide];
        [Hud showText:@"保存成功"];
        [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(back) userInfo:nil repeats:NO];
    } failure:^(NSNumber *code, NSString *error) {
        [Hud showText:error];
    }];
}
-(void)back{
    [self popoverPresentationController];
}

#pragma mark photoCollectionView

- (void)photoCollectionViewTapAdd {
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

- (void)photoCollectionViewTapByIndex:(NSInteger)index {
    UIActionSheet *avatarSheet = [UIActionSheet bk_actionSheetWithTitle:@"选择照片"];

    __weak OwnEditController* safeSelf = self;
    [avatarSheet bk_addButtonWithTitle:@"设为默认" handler:^{
        [safeSelf.cvPhotos makeDefault];
    }];
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
    [avatarSheet bk_addButtonWithTitle:@"删除" handler:^{
        [safeSelf.cvPhotos deletePhoto];
    }];
    [avatarSheet bk_setCancelButtonWithTitle:@"取消" handler:^{

    }];
    avatarSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [avatarSheet showInView:self.view];
}

- (void)photoCollectionViewUpdate:(NSArray *)array {
    [self.data.photo_urls removeAllObjects];
    for (NSURL *o in array) {
        [self.data.photo_urls addObject:[o absoluteString]];
    }
    [self updateHeaderView];
}


#pragma mark UIImagePickerController

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    editedImage = [UIImage imageWithImage:editedImage scaledToSize:CGSizeMake(640, 640)];
    NSData *data = UIImageJPEGRepresentation(editedImage, 1.0);
    QNUploadManager *QnUpload = [AppDel QNManager];
    __weak OwnEditController *safeSelf = self;
    [QnUpload putData:data key:[AppDel imageSaveKey] token:[AppDel makeQiNiuToken] complete:^(QNResponseInfo *responseInfo, NSString *key, NSDictionary *resp) {
        if (responseInfo.statusCode == 200) {
            [safeSelf.cvPhotos insetPhoto:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", qn_host, key]]];
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 6;
    } else {
        return 1;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 44.f;
    } else {
        return 30.f;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44.0)];
        UILabel *lbtext=[[UILabel alloc] initWithFrame:CGRectMake(15, 14, self.view.width-30, 30)];
        lbtext.textColor= GetUIColor(0x666666);
        lbtext.font=[UIFont systemFontOfSize:14];
        lbtext.text=@"我的信息";
        header.backgroundColor = UIColorBackGray;
        [header addSubview:lbtext];
        return header;
    } else {
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44.0)];
        header.backgroundColor = UIColorBackGray;
        return header;
    }

}

//去掉UItableview headerview黏性(sticky)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 44.0;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LabeTextPushCell *cell = [tableView dequeueReusableCellWithIdentifier:kEditCell forIndexPath:indexPath];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                [cell configWithTitle:@"名字" value:_data.nick_name placeholder:@"最多可填写16个字符"];
                break;
            case 1:
                [cell configWithTitle:@"出生日期" value:[_data birthdayText] placeholder:@"选择后自动匹配年龄和星座"];
                break;
            case 2:
                [cell configWithTitle:@"常住地" value:_data.liveplace placeholder:@"选择常住地"];
                break;
            case 3:
                [cell configWithTitle:@"我想" value:_data.hope placeholder:@"我想"];
                break;
            case 4:
                [cell configWithTitle:@"行业" value:_data.profession placeholder:@"选择行业"];
                break;
            case 5:
                [cell configWithTitle:@"学校" value:_data.school placeholder:@"选择学校"];
                break;
            default:
                break;

        }
    } else {
        [cell configWithTitle:@"个性标签" value:[_data traitsText] placeholder:@"选择个性标签"];
    }
    [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:15];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak OwnEditController *safeSelf = self;
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:{
                SingleTextController *singleVC = [SingleTextController showWithTitle:@"名字" defaultValue:_data.nick_name placeholder:@"最多可填写16个字符" doneBlock:^(NSString *value) {
                    safeSelf.data.nick_name = value;
                    [safeSelf.myTableView reloadDataAtSection:0 AtRow:0];
                }];
                [self.navigationController pushViewController:singleVC animated:YES];
            }
                break;
            case 1:{
                NSDateFormatter *formater = [[NSDateFormatter alloc] init];
                [formater setDateFormat:@"yyyy-MM-dd"];
                NSDate *oldDate = [NSDate dateWithTimeIntervalSince1970:_data.birthday];
                if (_data.birthday==0) {
                    oldDate = [formater dateFromString:@"1990-01-01"];
                }
                JasPicker *pick = [[JasPicker alloc] initWithDate:oldDate UIDatePicker:_datepicker Complete:^(NSDate *value) {
                    safeSelf.data.birthday = (NSInteger) [value timeIntervalSince1970];
                    [safeSelf.myTableView reloadDataAtSection:0 AtRow:1];
                }];
                [pick show];
            }

                break;
            case 2:{
                NSBundle *bundle = [NSBundle mainBundle];
                NSString *path = [bundle pathForResource:@"city" ofType:@"plist"];
                NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:path];
                JasPicker *pick = [[JasPicker alloc] initWithDictionary:dictionary Complete:^(NSString *key, NSString *value) {
                    safeSelf.data.liveplace = [NSString stringWithFormat:@"%@-%@", key, value];
                    [safeSelf.myTableView reloadDataAtSection:0 AtRow:2];
                }];
                [pick show];
            }

                break;
            case 3:{
                IWantController *iwantVC = [IWantController showWithTitle:@"我想" defaultValue:_data.hope doneBlock:^(NSString *value) {
                    safeSelf.data.hope = value;
                    [safeSelf.myTableView reloadDataAtSection:0 AtRow:3];
                }];
                [self.navigationController pushViewController:iwantVC animated:YES];
            }
                break;
            case 4:
            {
                JobController *jobVC = [JobController showWithTitle:@"选择职业" defaultValue:_data.profession doneBlock:^(NSString *value) {
                    safeSelf.data.profession = value;
                    [safeSelf.myTableView reloadDataAtSection:0 AtRow:4];
                }];
                [self.navigationController pushViewController:jobVC animated:YES];
            }
                break;
            case 5:
            {
                SingleTextController *singleVC = [SingleTextController showWithTitle:@"学校" defaultValue:_data.school placeholder:@"最多可填写16个字符" doneBlock:^(NSString *value) {
                    safeSelf.data.school = value;
                    [safeSelf.myTableView reloadDataAtSection:0 AtRow:5];
                }];
                [self.navigationController pushViewController:singleVC animated:YES];
            }
                break;
            default:
                break;

        }
    } else {
        PersonalityController *personalityVC = [PersonalityController showWithTitle:@"选择个性标签" defaultValue:_data.traits doneBlock:^(NSMutableArray *value) {
            safeSelf.data.traits = value;
            [safeSelf.myTableView reloadDataAtSection:1 AtRow:0];
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
