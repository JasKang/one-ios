//
// Created by JasKang on 15/6/23.
// Copyright (c) 2015 JasKang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"


@interface VoipModel : BaseModel

@property(nonatomic, copy) NSString *sub_account_sid;
@property(nonatomic, copy) NSString *sub_token;
@property(nonatomic, copy) NSString *voip_account;
@property(nonatomic, copy) NSString *voip_pwd;

@end