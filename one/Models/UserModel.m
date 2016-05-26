//
// Created by JasKang on 15/6/23.
// Copyright (c) 2015 JasKang. All rights reserved.
//

#import "UserModel.h"
#import "OPlistManager.h"

@interface UserModel ()

@end

@implementation UserModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"traits" : @"abilitys",
             @"voip" : @"ytx"
             };
}

+ (NSArray *)ignoredPropertyNames {
    return @[@"photo"];
}

- (id)newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{
    if ([property.name isEqualToString:@"photos"]) {
        if ([oldValue count]>0) {
            NSMutableArray *tmp=[[NSMutableArray alloc] init];
            for (NSString *object in oldValue) {
                [tmp addObject:[NSURL URLWithString:object]];
            }
            return tmp;
        }
        return [NSURL URLWithString:oldValue];
    }
    return oldValue;
}

- (void)keyValuesDidFinishConvertingToObject {
    self.photo=[NSURL URLWithString:@""];
    if (self.photos && self.photos.count > 0) {
        id firstobj=[self.photos firstObject];
        if ([firstobj isKindOfClass:[NSURL class]]) {
            self.photo=firstobj;
        }else{
            self.photo=[NSURL URLWithString:firstobj];
        }
    }
}

@end