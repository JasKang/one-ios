//
//  DownButton.h
//  wengweng
//
//  Created by JasKang on 15/4/13.
//  Copyright (c) 2015年 xnye. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DownButton;

typedef NSString *(^DidChangeBlock)(DownButton *countDownButton, int second);

typedef NSString *(^DidFinishedBlock)(DownButton *countDownButton, int second);

typedef void (^TouchedDownBlock)(DownButton *countDownButton, NSInteger tag);

@interface DownButton : UIButton {
    int _second;
    int _totalSecond;

    NSTimer *_timer;
    DidChangeBlock _didChangeBlock;
    DidFinishedBlock _didFinishedBlock;
    TouchedDownBlock _touchedDownBlock;
}
- (void)addToucheHandler:(TouchedDownBlock)touchHandler;

- (void)didChange:(DidChangeBlock)didChangeBlock;

- (void)didFinished:(DidFinishedBlock)didFinishedBlock;

- (void)startWithSecond:(int)second;

- (void)stop;
@end