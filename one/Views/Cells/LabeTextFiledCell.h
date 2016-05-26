//
//  LabeTextFiledCell.h
//  one
//
//  Created by JasKang on 15/5/25.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabeTextFiledCell : UITableViewCell

- (void)configWithTitle:(NSString *)title placeholder:(NSString *)placeholder keyboardType:(UIKeyboardType)type
        isEntry:(BOOL)isEntry valueChangeBlock:(void (^)(NSString *value))block;

@end
