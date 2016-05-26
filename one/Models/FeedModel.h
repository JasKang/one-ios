//
// Created by JasKang on 15/6/23.
// Copyright (c) 2015 JasKang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface FeedModel : BaseModel

@property(nonatomic, strong) NSNumber *usersign;
@property(nonatomic, copy) NSString *nick_name;
@property(nonatomic, copy) NSString *phone_number;
@property(nonatomic, copy) NSString *profession;
@property(nonatomic, copy) NSString *hope;
@property(nonatomic, strong) NSURL *photo;
@property(nonatomic, assign) SexEnum sex;
@property(nonatomic, assign) NSInteger age;
@property(nonatomic, assign) NSInteger index;
@property(nonatomic, strong) VoipModel *voip;

@end