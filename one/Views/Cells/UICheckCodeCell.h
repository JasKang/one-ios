//
//  UICheckCodeCell.h
//  one
//
//  Created by JasKang on 15/5/25.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICheckCodeCell : UITableViewCell

- (void)configPhoneumber:(NSString *)phonenumber valueChangeBlock:(void (^)(NSString *value))block;

@end
