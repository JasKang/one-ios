//
// Created by JasKang on 15/6/23.
// Copyright (c) 2015 JasKang. All rights reserved.
//

#import "MsgModel.h"

@interface MsgModel ()

@end

@implementation MsgModel

- (id)newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{
    if ([property.name isEqualToString:@"photo"]) {
        return [NSURL URLWithString:oldValue];
    }
    return oldValue;
}

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"chat" : @"last_message",
            @"voip" : @"ytx"
    };
}

@end