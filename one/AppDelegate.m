//
//  AppDelegate.m
//  one
//
//  Created by JasKang on 15/5/24.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#import "APService.h"
#import "ECDevice.h"
#import "OVoipManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];

    // OVoipManager 是代理类，其中实现对应的回调函数
    [ECDevice sharedInstance].delegate = [OVoipManager instance];

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                        UIUserNotificationTypeSound |
                        UIUserNotificationTypeAlert)
                categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                        UIRemoteNotificationTypeSound |
                        UIRemoteNotificationTypeAlert)
                categories:nil];
    }
#else
    //categories 必须为nil
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)
                                       categories:nil];
#endif
    // Required
    [APService setupWithOption:launchOptions];


    [OApiManager configWithVersion:@"" success:^(NSDictionary *data) {
        //        NSLog(@"%@",data);
    } failure:^(NSNumber *code, NSString *error) {
        //        NSLog(@"%@ %@",code,error);
    }];
    [AppDel setupStyle];
    
    if ([UserDefaults boolForKey:kIsLogin]) {
        [AppDel toMain];
    }else{
        [AppDel toWelcome];
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

// App进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {

}

// App将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    //    [[PgyManager sharedPgyManager] checkUpdate];
}

// 申请处理时间
- (void)applicationWillTerminate:(UIApplication *)application {

}


// 将得到的deviceToken传给SDK
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [APService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // Required
    [APService handleRemoteNotification:userInfo];
    NSLog(@"收到通知:%@", [NSString JSONStringWithObject:userInfo]);
//    [rootViewController addNotificationCount];
    [AppDel receivePush:userInfo];
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // IOS 7 Support Required
    [APService handleRemoteNotification:userInfo];
    NSLog(@"收到通知:%@", [NSString JSONStringWithObject:userInfo]);
    [AppDel receivePush:userInfo];
//    [rootViewController addNotificationCount];
    completionHandler(UIBackgroundFetchResultNewData);
}
- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    [APService showLocalNotificationAtFront:notification identifierKey:nil];
}
// 注册deviceToken失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {

    NSLog(@"error -- %@", error);
}

@end
