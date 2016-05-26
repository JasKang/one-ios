//
//  RootTabViewController.m
//  one
//
//  Created by JasKang on 15/5/24.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#import "RDVTabBarItem.h"
#import "FeedController.h"
#import "MsgController.h"
#import "OwnController.h"

@interface RootTabViewController ()

@end

@implementation RootTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupViewControllers];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doRefreshBadge) name:kNewPush object:nil];
}

- (void)setupViewControllers {
    FeedController *feedVC = [[FeedController alloc] init];
    BaseNavigationController *nav_feed = [[BaseNavigationController alloc] initWithRootViewController:feedVC];

    MsgController *msgVC = [[MsgController alloc] init];
    BaseNavigationController *nav_msg = [[BaseNavigationController alloc] initWithRootViewController:msgVC];

    OwnController *meVC = [[OwnController alloc] init];
    BaseNavigationController *nav_me = [[BaseNavigationController alloc] initWithRootViewController:meVC];

    [self setViewControllers:@[nav_feed, nav_msg, nav_me]];
    [self customizeTabBarForController];
    self.delegate = self;
}

- (void)customizeTabBarForController {
    UIImage *backgroundImage = [UIImage imageNamed:@"tabbar_bg"];
    NSArray *tabBarItemImages = @[@"tab_home", @"tab_message", @"tab_me"];
    NSArray *tabBarItemTitles = @[@"发现", @"消息", @"我的"];

    NSInteger index = 0;
    [[self tabBar] setHeight:cTabHeight];
    [[self tabBar] setTranslucent:YES];
    [[self tabBar] setBackgroundColor:UIColorBackGray];
    for (RDVTabBarItem *item in [[self tabBar] items]) {
        [item setBackgroundSelectedImage:backgroundImage withUnselectedImage:backgroundImage];

        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_down",
                                                                                tabBarItemImages[index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                                                  tabBarItemImages[index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        [item setTitle:tabBarItemTitles[index]];
        [item setSelectedTitleAttributes:@{NSForegroundColorAttributeName : GetUIColor(0x3891eb)}];
        [item setUnselectedTitleAttributes:@{NSForegroundColorAttributeName : GetUIColor(0x666666)}];
        index++;
    }
    RDVTabBarItem *msgitem = [self tabBar].items[1];
    [OApiManager friendListSuccess:^(NSArray *chats) {
        NSInteger newcount = 0;
        for (MsgModel *object in chats) {
            newcount = newcount + object.new_message_count;
        }
        if (newcount > 0) {
            msgitem.badgeValue = [NSString stringWithFormat:@"%@", @(newcount)];
        }
    } failure:nil];
}

- (void)doRefreshBadge {
    RDVTabBarItem *msgitem = [self tabBar].items[1];
    [OApiManager friendListSuccess:^(NSArray *chats) {
        NSInteger newcount = 0;
        for (MsgModel *object in chats) {
            newcount = newcount + object.new_message_count;
        }
        if (newcount > 0) {
            msgitem.badgeValue = [NSString stringWithFormat:@"%@", @(newcount)];
        }else{
            msgitem.badgeValue = @"";
        }
    } failure:^(NSNumber *code, NSString *error) {
        
    }];
}

- (BOOL)  tabBarController:(RDVTabBarController *)tabBarController
shouldSelectViewController:(UIViewController *)viewController {
    return YES;
}

- (void)dealloc {
    //第四步,消息发送完,要移除掉
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNewPush object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
