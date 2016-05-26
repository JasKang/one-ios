//
// Created by JasKang on 15/6/23.
// Copyright (c) 2015 JasKang. All rights reserved.
//

#import "PutPerfectModel.h"

@interface PutPerfectModel ()

@end

@implementation PutPerfectModel

MJCodingImplementation

- (instancetype)init {
    self = [super init];
    if (self) {
        self.photo_url=@"";
        self.nick_name=@"";
        self.sex=SexEnumNone;
        self.birthday=0;
        self.liveplace=@"";
        self.hope=@"";
        self.profession=@"";
        self.school=@"";
        self.traits=[[NSMutableArray alloc] init];
    }
    return self;
}


- (NSString *)sexText {
    if (self.sex) {
        if (self.sex == SexEnumNone) {
            return @"保密";
        } else if (self.sex == SexEnumWomen) {
            return @"女";
        } else {
            return @"男";
        }
    } else {
        self.sex = SexEnumNone;
        return @"";
    }
}

- (NSString *)birthdayText {
    if (self.birthday) {
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"yyyy-MM-dd"];
        NSDate *birthday=[NSDate dateWithTimeIntervalSince1970:self.birthday];
        return [NSString stringWithFormat:@"%@ %@", [formater stringFromDate:birthday], [Util getConstellation:birthday]];
    } else {
        return @"";
    }
}
- (NSString *)traitsText {
    NSArray *tmp=[[OPlistManager instance] abilitysWithArray:self.traits];
    if (tmp.count > 0) {
        TraitModel *obj=[tmp firstObject];
        return [NSString stringWithFormat:@"%@ 等%d个标签",obj.ability_name,tmp.count];
    }
    return @"";
}

@end