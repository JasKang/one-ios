//
//  SingleTextController.h
//  one
//
//  Created by JasKang on 15/5/25.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#import "BaseViewController.h"

@interface SingleTextController : BaseViewController

+ (instancetype)showWithTitle:(NSString *)title defaultValue:(NSString *)defaultvalue
                  placeholder:(NSString *)placeholder doneBlock:(void (^)(NSString *value))block;

@end
