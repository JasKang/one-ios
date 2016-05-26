//
//  ChatController.h
//  one
//
//  Created by JasKang on 15/5/26.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#import "BaseViewController.h"

@interface ChatController : BaseViewController <UITableViewDataSource, UITableViewDelegate>

+ (instancetype)initWithVoipAccount:(NSString *)voip_account UserSign:(NSNumber *)usersign photo:(NSURL *)photo;

@end
