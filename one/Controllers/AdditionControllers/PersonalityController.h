//
//  PersonalityController.h
//  one
//
//  Created by JasKang on 15/5/26.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#import "BaseViewController.h"

@interface PersonalityController : BaseViewController <UITableViewDataSource, UITableViewDelegate>

+ (instancetype)showWithTitle:(NSString *)title defaultValue:(NSArray *)defaultvalue
                    doneBlock:(void (^)(NSMutableArray *value))block;

@end
