//
//  NewNoticeModel.m
//  one
//
//  Created by JasKang on 15/6/22.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#import "NewNoticeModel.h"

@implementation NewNoticeModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
            @"type" : @"user_info.type",
            @"nick_name" : @"user_info.nick_name",
            @"usersign" : @"user_info.usersign",
            @"sex" : @"user_info.sex",
            @"photo" : @"user_info.photo",
            @"voip" : @"user_info.ytx"
    };
}

- (id)newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{
    if ([property.name isEqualToString:@"photo"]) {
        return [NSURL URLWithString:oldValue];
    }
    return oldValue;
}

@end
