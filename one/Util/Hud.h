//
//  Hud.h
//  wengweng
//
//  Created by JasKang on 15/3/21.
//  Copyright (c) 2015年 xnnye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface Hud : NSObject

+ (void)showText:(NSString *)text InView:(UIView *)view;

+ (void)showInView:(UIView *)view;

+ (void)hideInView:(UIView *)view;

+ (void)show;

+ (void)showText:(NSString *)text;

+ (void)hide;

@end
