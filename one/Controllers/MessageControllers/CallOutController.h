//
// Created by JasKang on 15/6/16.
// Copyright (c) 2015 JasKang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewController.h"
#import "OVoipManager.h"


@interface CallOutController : BaseViewController <OVoipUIDelegate>

+ (instancetype)initWithVoipaccount:(NSString *)voip_account userSign:(NSNumber *)usersign;

@end