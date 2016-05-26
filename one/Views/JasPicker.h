//
//  JasPicker.h
//  one
//
//  Created by JasKang on 15/5/25.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JasPicker : UIView <UIPickerViewDelegate, UIPickerViewDataSource>

- (instancetype)initWithArray:(NSArray *)values Complete:(void (^)(NSString *value))block;

- (instancetype)initWithDictionary:(NSDictionary *)values Complete:(void (^)(NSString *key, NSString *value))block;

- (instancetype)initWithDate:(NSDate *)value UIDatePicker:(UIDatePicker *)datepicker
                Complete:(void (^)(NSDate *value))block;

- (void)show;

@end
