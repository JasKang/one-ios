//
// Created by JasKang on 15/6/23.
// Copyright (c) 2015 JasKang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
#import "OPlistManager.h"

@interface PutPerfectModel : BaseModel

@property(nonatomic, copy) NSString *photo_url;
@property(nonatomic, copy) NSString *nick_name;
@property(nonatomic, assign) SexEnum sex;
@property(nonatomic, assign) NSInteger birthday;
@property(nonatomic, copy) NSString *liveplace;
@property(nonatomic, copy) NSString *hope;
@property(nonatomic, copy) NSString *profession;
@property(nonatomic, copy) NSString *school;
@property(nonatomic, strong) NSMutableArray *traits;

- (NSString *)sexText;

- (NSString *)birthdayText;

- (NSString *)traitsText;

@end