//
//  NewNoticeModel.h
//  one
//
//  Created by JasKang on 15/6/22.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface NewNoticeModel : BaseModel

@property (nonatomic, copy) NSString *nick_name;
@property (nonatomic,assign) NewNoticeTypeEnum type;
@property (nonatomic,assign) SexEnum sex;
@property (nonatomic,assign) NSInteger create_time;
@property (nonatomic,strong) NSNumber *usersign;
@property (nonatomic,strong) NSURL *photo;
@property (nonatomic,strong) VoipModel *voip;

@end
