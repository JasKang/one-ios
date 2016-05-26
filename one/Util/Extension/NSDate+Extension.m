//
//  NSData+Extension.m
//  wengweng
//
//  Created by JasKang on 15/3/21.
//  Copyright (c) 2015年 xnnye. All rights reserved.
//

@implementation NSDate (Extension)


- (NSDate *)offsetYear:(int)numYears {
    NSCalendar *gregorian = [[NSCalendar alloc]
            initWithCalendarIdentifier:NSGregorianCalendar];

    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:numYears];
    //[offsetComponents setHour:1];
    //[offsetComponents setMinute:30];
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:self options:0];
}

- (NSDate *)offsetMonth:(int)numMonths {
    NSCalendar *gregorian = [[NSCalendar alloc]
            initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setFirstWeekday:2]; //monday is first day

    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:numMonths];
    //[offsetComponents setHour:1];
    //[offsetComponents setMinute:30];
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:self options:0];
}

- (NSDate *)offsetHours:(int)hours {
    NSCalendar *gregorian = [[NSCalendar alloc]
            initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setFirstWeekday:2]; //monday is first day

    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    //[offsetComponents setMonth:numMonths];
    [offsetComponents setHour:hours];
    //[offsetComponents setMinute:30];
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:self options:0];
}

- (NSDate *)offsetDay:(int)numDays {
    NSCalendar *gregorian = [[NSCalendar alloc]
            initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setFirstWeekday:2]; //monday is first day

    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:numDays];
    //[offsetComponents setHour:1];
    //[offsetComponents setMinute:30];

    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:self options:0];
}


/**
*  计算指定时间与当前的时间差
*  @return 多少(秒or分or天or月or年)+前 (比如，3天前、10分钟前)
*/
- (NSString *)compareCurrentTime {
    NSTimeInterval timeInterval = [self timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if ((temp = timeInterval / 60) < 60) {
        result = [NSString stringWithFormat:@"%ld分钟前", temp];
    }

    else if ((temp = temp / 60) < 24) {
        result = [NSString stringWithFormat:@"%ld小时前", temp];
    }

    else if ((temp = temp / 24) < 30) {
        result = [NSString stringWithFormat:@"%ld天前", temp];
    }

    else if ((temp = temp / 30) < 12) {
        result = [NSString stringWithFormat:@"%ld个月前", temp];
    }
    else {
        temp = temp / 12;
        result = [NSString stringWithFormat:@"%ld年前", temp];
    }

    return result;
}

/**
*  计算指定时间与当前的时间差
*  @return 多少(秒or分or天or月or年)+前 (比如，3天前、10分钟前)
*/
- (NSString *)chatTime {
    //    NSTimeInterval  timeInterval = [self timeIntervalSinceNow];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];//设置成中国阳历

    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;//这句我也不明白具体时用来做什么。。。

    NSDateComponents *this_comps = [calendar components:unitFlags fromDate:self];
    NSDateComponents *now_comps = [calendar components:unitFlags fromDate:[NSDate date]];
    long year = [this_comps year];//获取年对应的长整形字符串
    long month = [this_comps month];//获取月对应的长整形字符串
    long day = [this_comps day];//获取日期对应的长整形字符串
    long hour = [this_comps hour];//获取小时对应的长整形字符串
    long minute = [this_comps minute];//获取月对应的长整形字符串
    if (year != [now_comps year]) {
        return [NSString stringWithFormat:@"%04ld年%02ld月%02ld日 %02ld:%02ld", year, month, day, hour, minute];
    }
    if (day != [now_comps day]) {
        return [NSString stringWithFormat:@"%02ld月%02ld日 %02ld:%02ld", month, day, hour, minute];
    } else {
        return [NSString stringWithFormat:@"%02ld:%02ld", hour, minute];
    }

}

/**
*  计算指定时间与当前的时间差
*  @return 多少(秒or分or天or月or年)+前 (比如，3天前、10分钟前)
*/
- (NSInteger)timeDifferenceWith:(NSDate *)todate {
    NSTimeInterval timeInterval = [self timeIntervalSinceDate:todate];

    return (NSInteger) timeInterval;
}

@end
