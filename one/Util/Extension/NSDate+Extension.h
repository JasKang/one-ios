//
//  NSData+Extension.h
//  wengweng
//
//  Created by JasKang on 15/3/21.
//  Copyright (c) 2015年 xnnye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

- (NSDate *)offsetYear:(int)numYears;

- (NSDate *)offsetMonth:(int)numMonths;

- (NSDate *)offsetDay:(int)numDays;

- (NSDate *)offsetHours:(int)hours;

- (NSString *)compareCurrentTime;

- (NSInteger)timeDifferenceWith:(NSDate *)todate;

- (NSString *)chatTime;
@end
