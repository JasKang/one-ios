//
// Created by JasKang on 15/6/23.
// Copyright (c) 2015 JasKang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface JobModel : BaseModel


@property(nonatomic, strong) NSNumber *profession_id;
@property(nonatomic, copy) NSString *profession_class_name;
@property(nonatomic, copy) NSString *profession_name;
@property(nonatomic, strong) NSNumber *parent_id;
@property(nonatomic, strong) NSArray *sub;

@end