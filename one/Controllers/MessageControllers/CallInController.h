//
// Created by JasKang on 15/6/17.
// Copyright (c) 2015 JasKang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewController.h"
#import "OVoipManager.h"


@interface CallInController : BaseViewController <OVoipUIDelegate>

+ (instancetype)initWithCallId:(NSString *)callid userSign:(NSNumber *)usersign;

@end