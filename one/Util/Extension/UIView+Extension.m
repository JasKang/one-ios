//
//  UIView+Extension.m
//  wengweng
//
//  Created by JasKang on 15/3/20.
//  Copyright (c) 2015年 xnnye. All rights reserved.
//


@implementation UIView (Extension)


- (CGFloat)width {
    return self.bounds.size.width;
}

- (CGFloat)height {
    return self.bounds.size.height;
}

- (CGFloat)x {
    return self.bounds.origin.x;
}

- (CGFloat)y {
    return self.bounds.origin.y;
}

/**
*  顶部线条
*
*  @param x x轴开始坐标
*/
- (void)setLineTopX:(CGFloat)x {
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(x, 0, ScreenWidth - x, 0.5f)];
    line.backgroundColor = GetUIColor(0xd6d6d6);
    [self addSubview:line];
}

/**
*  顶部线条
*
*  @param x          x轴开始坐标
*  @param colorvalue 线条颜色
*/
- (void)setLineTopX:(CGFloat)x color:(int)colorvalue {
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(x, 0, ScreenWidth - x, 0.5f)];
    line.backgroundColor = GetUIColor(colorvalue);
    [self addSubview:line];
}

/**
*  底部线条
*  @param x x轴开始坐标
*/
- (void)setLineDownX:(CGFloat)x {
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(x, self.frame.size.height - 0.5f, ScreenWidth - x, 0.5f)];
    line.backgroundColor = GetUIColor(0xd6d6d6);
    [self addSubview:line];
}

/**
*  底部线条
*
*  @param x      x轴开始坐标
*  @param height view高度
*/

- (void)setLineDownX:(CGFloat)x viewheight:(CGFloat)height {
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(x, height - 0.5, ScreenWidth - x, 0.5f)];
    line.backgroundColor = GetUIColor(0xd6d6d6);
    [self addSubview:line];
}

- (void)addTopLineWithLeftSpace:(CGFloat)leftSpace {
    CALayer *lineLayer = [[CALayer alloc] init];
    CGFloat lineHeight = (1.0f / [UIScreen mainScreen].scale);
    lineLayer.frame = CGRectMake(leftSpace, 0, self.bounds.size.width - leftSpace, lineHeight);
    lineLayer.backgroundColor = GetUIColor(0xd6d6d6).CGColor;
    [self.layer addSublayer:lineLayer];
}

- (void)addDownLineWithLeftSpace:(CGFloat)leftSpace {
    CALayer *lineLayer = [[CALayer alloc] init];
    CGFloat lineHeight = (1.0f / [UIScreen mainScreen].scale);
    lineLayer.frame = CGRectMake(leftSpace, self.bounds.size.height - lineHeight, self.bounds.size.width - leftSpace, lineHeight);
    lineLayer.backgroundColor = GetUIColor(0xd6d6d6).CGColor;
    [self.layer addSublayer:lineLayer];
}

/**
*  底部线条
*
*  @param x      x轴开始坐标
*  @param height view高度
*/
- (void)setLineDownX:(CGFloat)x viewheight:(CGFloat)height color:(int)colorvalue {
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(x, height - 0.5, ScreenWidth - x, 0.5f)];
    line.backgroundColor = GetUIColor(colorvalue);
    [self addSubview:line];
}


+ (CGRect)frameWithOutNavTab {
    CGRect frame = ScreenBounds;
    frame.size.height -= (20 + 44 + cTabHeight);//减去状态栏、导航栏、Tab栏的高度
    return frame;
}

+ (CGRect)frameWithOutNav {
    CGRect frame = ScreenBounds;
    frame.size.height -= (20 + 44);//减去状态栏、导航栏的高度
    return frame;
}

@end

