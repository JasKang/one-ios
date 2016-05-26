//
// Created by JasKang on 15/6/23.
// Copyright (c) 2015 JasKang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface PutUserModel : BaseModel

//photo_urls 多个头像地址 json格式的一个数组 example: [url,url,url]
//personal_signature个性签名文本
//nick_name昵称字符串
//birthday生日时间戳
//work_position工作职位当职业为学生时可为空
//liveplace居住地字符串
//hope我想字符串
//profession职业字符串
//school学校字符串
//abilitys


@property(nonatomic, copy) NSString *personal_signature;
@property(nonatomic, copy) NSString *nick_name;
@property(nonatomic, assign) NSInteger birthday;
@property(nonatomic, copy) NSString *liveplace;
@property(nonatomic, copy) NSString *hope;
@property(nonatomic, copy) NSString *profession;
@property(nonatomic, copy) NSString *work_position;
@property(nonatomic, copy) NSString *school;
@property(nonatomic, strong) NSMutableArray *photo_urls;
@property(nonatomic, strong) NSMutableArray *traits;

- (NSMutableArray *)photos;

- (NSString *)birthdayText;

- (NSString *)traitsText;
@end