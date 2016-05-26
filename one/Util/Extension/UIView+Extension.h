//
//  UIView+Extension.h
//  wengweng
//
//  Created by JasKang on 15/3/20.
//  Copyright (c) 2015年 xnnye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIView (Extension)

- (CGFloat)width;

- (CGFloat)height;

- (CGFloat)x;

- (CGFloat)y;

- (void)setLineTopX:(CGFloat)x;

- (void)setLineTopX:(CGFloat)x color:(int)colorvalue;

- (void)setLineDownX:(CGFloat)x;

- (void)setLineDownX:(CGFloat)x viewheight:(CGFloat)height;

- (void)setLineDownX:(CGFloat)x viewheight:(CGFloat)height color:(int)colorvalue;

- (void)addTopLineWithLeftSpace:(CGFloat)leftSpace;

- (void)addDownLineWithLeftSpace:(CGFloat)leftSpace;

+ (CGRect)frameWithOutNavTab;

+ (CGRect)frameWithOutNav;
@end
