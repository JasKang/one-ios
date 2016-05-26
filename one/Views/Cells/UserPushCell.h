//
//  UserPushCell.h
//  one
//
//  Created by JasKang on 15/5/28.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserPushCell : UITableViewCell


- (void)configWithImageName:(NSString *)imagename Title:(NSString *)title subTitle:(NSString *)subtitle;

- (void)configWithImageUrl:(NSURL *)imageurl Title:(NSString *)title subTitle:(NSString *)subtitle;
@end
