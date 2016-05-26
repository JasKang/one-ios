//
// Created by JasKang on 15/6/23.
// Copyright (c) 2015 JasKang. All rights reserved.
//

#import "TraitModel.h"

@interface TraitModel ()

@end

@implementation TraitModel

- (id)newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{
    if ([property.name isEqualToString:@"ability_icon_url"]) {
        return [NSURL URLWithString:oldValue];
    }
    return oldValue;
}

@end