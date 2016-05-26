//
//  UIColor+Extension.h
//  wengweng
//
//  Created by JasKang on 15/5/9.
//  Copyright (c) 2015年 xnye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)

+ (UIColor *)colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha;
+ (UIColor *)colorWithHex:(UInt32)hex;
+ (UIColor *)colorWithHexString:(id)hexString;

- (UInt32)hexValue;

@end
