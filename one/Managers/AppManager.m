//
// Created by JasKang on 15/6/30.
// Copyright (c) 2015 JasKang. All rights reserved.
//


#import "AppManager.h"

@interface AppManager ()

@property(strong, nonatomic) QNUploadManager *QNManager;
@property(strong, nonatomic) UserModel *localUser;
@property(strong, nonatomic) RootTabViewController *tabController;

@end

@implementation AppManager


- (id)init {
    self = [super init];
    if (self) {
        _delegate = (AppDelegate *) [UIApplication sharedApplication].delegate;

    }
    return self;
}

+ (AppManager *)sharedInstance {
    static dispatch_once_t onceQueue;
    static AppManager *appInstance;

    dispatch_once(&onceQueue, ^{
        appInstance = [[AppManager alloc] init];
    });
    return appInstance;
}

/**
*  ============= UI 部分 ===============
*/


- (UIWindow *)window {

    return self.delegate.window;
}


- (RootTabViewController *)tabController {
    if (!_tabController) {
        RootTabViewController *tab = [[RootTabViewController alloc] init];
        _tabController = tab;
    }
    return _tabController;
}


/**
*  成员函数
*  =============================================================================
*/

/**
*  全局主题
*/
- (void)setupStyle {
    UINavigationBar *navbar = [UINavigationBar appearance];
    [navbar setTintColor:GetUIColor(0x3891eb)];
    [navbar setBarTintColor:[UIColor whiteColor]];
    NSDictionary *textAttributes = @{
            NSFontAttributeName : [UIFont boldSystemFontOfSize:20],
            NSForegroundColorAttributeName : GetUIColor(0x333333),
    };
    [navbar setTitleTextAttributes:textAttributes];


    [navbar setBackgroundImage:[[UIImage alloc] imageWithTintColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];

    [navbar setShadowImage:[[UIImage alloc] init]];

    //自定义返回按钮
    //    UIImage *imgback = [UIImage imageNamed:@"return"];
    //    [navbar setBackIndicatorImage:imgback];
    //    [navbar setBackIndicatorTransitionMaskImage:imgback];
    //关闭透明
    [navbar setTranslucent:NO];
    //将返回按钮的文字position设置不在屏幕上显示
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
}

/**
*  跳转-登录页
*/
- (void)toWelcome {
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:[[StartController alloc] init]];
    self.window.rootViewController = nav;

}

/**
*  跳转主界面
*/
- (void)toMain {
    //推送 别名-usersign
    [APService setAlias:[NSString stringWithFormat:@"%@",self.localUser.usersign] callbackSelector:nil object:self];
    //voip 初始化
    [[OVoipManager instance] login];
    self.window.rootViewController = self.tabController;
    //    self.window.rootViewController=self.SlidingViewController;
}

/**
*  退出登录
*/
- (void)logout {
    [APService setAlias:@"" callbackSelector:nil object:nil];

    [UserDefaults setBool:NO forKey:kIsLogin];
    [UserDefaults setObject:nil forKey:kLocalUser];
    self.tabController=nil;
    [[OVoipManager instance] logout];
    [self toWelcome];
}

/**
*  token失效 退回登录页
*/
- (void)tokenFailure {
    [self logout];
    [Hud showText:@"token失效,请重新登录"];
}

/**
*  异地登录 退回登录页
*/
- (void)kickedOff {
    [self logout];
    [Hud showText:@"您的帐号在异地登录"];
}

/**
*  ============= 函数 部分 ===============
*/

/**
*  取本地用户
*  @return 本地用户
*/
- (UserModel *)localUser {
    if (!_localUser) {
        NSDictionary *data = GetUserDefaults(kLocalUser);
        _localUser = [UserModel objectWithKeyValues:data];
    }
    return _localUser;
}

/**
*  更新本地用户
*  @return 本地用户
*/
- (void)updateLocalUserWithDictionary:(NSDictionary *)data {
    SetUserDefaults(kLocalUser, data);
    _localUser = [UserModel objectWithKeyValues:data];
}


/**
*  七牛
*  @return 七牛
*/
- (QNUploadManager *)QNManager {
    if (!_QNManager) {
        _QNManager = [[QNUploadManager alloc] init];
    }
    return _QNManager;
}


/**
*  生成七牛云 token
*  @return  token
*/
- (NSString *)makeQiNiuToken {

    const char *secretKeyStr = [@"Z2wa0RBWLKm09MJ7Sv4UjUXKmX7e_rePYN6bPgIF" UTF8String];

    NSString *policy = [NSString jsonStringWithObjectOriginal:@{@"deadline" : @((int) ([[NSDate date] timeIntervalSince1970] + 3600)), @"scope" : @"wengweng"}];

    NSData *policyData = [policy dataUsingEncoding:NSUTF8StringEncoding];

    NSString *encodedPolicy = [QNUrlSafeBase64 encodeData:policyData];

    const char *encodedPolicyStr = [encodedPolicy cStringUsingEncoding:NSUTF8StringEncoding];

    char digestStr[CC_SHA1_DIGEST_LENGTH];
    bzero(digestStr, 0);

    CCHmac(kCCHmacAlgSHA1, secretKeyStr, strlen(secretKeyStr), encodedPolicyStr, strlen(encodedPolicyStr), digestStr);

    NSData *digestData = [NSData dataWithBytes:digestStr length:CC_SHA1_DIGEST_LENGTH];
    NSString *encodedDigest = [QNUrlSafeBase64 encodeData:digestData];

    NSString *token = [NSString stringWithFormat:@"%@:%@:%@", @"QWpuki0GZ7FFKchc-zRemCtuFqhefI0gayCyfpcY", encodedDigest, encodedPolicy];

    return token;
}


- (NSString * )imageSaveKey {
    return [[NSString stringWithFormat:@"%@%.0f",AppDel.localUser.usersign,[[NSDate date] timeIntervalSince1970]] md5];
}


-(void)receivePush:(NSDictionary *)data{
    if ([UserDefaults boolForKey:kIsLogin]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNewPush object:data];
    }else{

    }
}

@end