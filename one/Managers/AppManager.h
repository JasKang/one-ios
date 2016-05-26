//
// Created by JasKang on 15/6/30.
// Copyright (c) 2015 JasKang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonHMAC.h>
#import <QiniuSDK.h>
#import "AppDelegate.h"
#import "RootTabViewController.h"
#import "BaseNavigationController.h"
#import "StartController.h"
#import "APService.h"
#import "OVoipManager.h"

@interface AppManager : NSObject


@property(nonatomic, readonly) AppDelegate *delegate;
@property(strong, readonly) UIWindow *window;
@property(nonatomic, strong) NSNumber *navIndex;
@property(nonatomic,assign) BOOL isLogin;

+ (AppManager *)sharedInstance;

- (RootTabViewController *)tabController;

- (void)setupStyle;

- (void)toWelcome;

- (void)toMain;

- (void)logout;

- (void)tokenFailure;

/**
*  异地登录 退回登录页
*/
- (void)kickedOff;

/**
*  取本地用户
*  @return 本地用户
*/
- (UserModel *)localUser;

/**
*  更新本地用户
*  @return 本地用户
*/
- (void)updateLocalUserWithDictionary:(NSDictionary *)data;

/**
*  七牛
*  @return 七牛
*/
- (QNUploadManager *)QNManager;
- (NSString *)makeQiNiuToken;
- (NSString * )imageSaveKey ;

-(void)receivePush:(NSDictionary *)data;

@end