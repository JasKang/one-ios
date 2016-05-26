//
//  JobController.h
//  one
//
//  Created by JasKang on 15/5/25.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#import "BaseViewController.h"

@interface JobController : BaseViewController <UITableViewDataSource, UITableViewDelegate>

+ (instancetype)showWithTitle:(NSString *)title defaultValue:(NSString *)defaultvalue
                    doneBlock:(void (^)(NSString *value))block;

@end
