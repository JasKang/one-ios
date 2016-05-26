//
// Created by JasKang on 15/6/23.
// Copyright (c) 2015 JasKang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"


@interface TraitModel : BaseModel

@property(nonatomic, copy) NSString *ability_name;
@property(nonatomic, assign) BOOL check;
@property(nonatomic, strong) NSNumber *ability_id;
@property(nonatomic, strong) NSURL *ability_icon_url;

@end