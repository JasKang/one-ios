//
// Created by JasKang on 15/6/23.
// Copyright (c) 2015 JasKang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
#import "TraitModel.h"
#import "VoipModel.h"
@class VoipModel;


@interface UserModel : BaseModel

@property(nonatomic, copy) NSString *token;
@property(nonatomic, strong) NSNumber *usersign;

@property(nonatomic, assign) UserStatusEnum status; //状态 0 已注册待完善资料 1 正常
@property(nonatomic, assign) SexEnum sex;//性别 1女 2男
@property(nonatomic, assign) LikeEnum click_type;// 状态   0未点击  1点喜欢   2不喜欢

@property(nonatomic, strong) NSNumber *age;//年龄
@property(nonatomic, strong) NSNumber *praise_num; //被赞次数

@property(nonatomic, assign) NSInteger birthday;//生日
@property(nonatomic, assign) NSInteger activity_time;//活跃时间

@property(nonatomic, copy) NSString *phone_number;//电话号码
@property(nonatomic, copy) NSString *nick_name;//昵称
@property(nonatomic, copy) NSString *liveplace;//所在地
@property(nonatomic, copy) NSString *constellation;//星座
@property(nonatomic, copy) NSString *hope;//想
@property(nonatomic, copy) NSString *profession;//行业
@property(nonatomic, copy) NSString *school;//学校
@property(nonatomic, copy) NSString *work_position;//职位
@property(nonatomic, copy) NSString *personal_signature;//个性签名

@property(nonatomic, strong) NSArray *photos;//照片
@property(nonatomic, strong) NSArray *traits;//标签

@property(nonatomic, strong) VoipModel *voip;//云通讯

@property (nonatomic,strong) NSURL *photo;

@end