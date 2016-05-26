//
// Created by JasKang on 15/6/23.
// Copyright (c) 2015 JasKang. All rights reserved.
//

#import "PutUserModel.h"
#import "OPlistManager.h"

@interface PutUserModel ()

@end

@implementation PutUserModel

MJCodingImplementation

//@property(nonatomic, strong) NSArray *photo_urls;
//@property(nonatomic, strong) NSNumber *personal_signature;
//@property(nonatomic, copy) NSString *nick_name;
//@property(nonatomic, assign) NSInteger birthday;
//@property(nonatomic, copy) NSString *liveplace;
//@property(nonatomic, copy) NSString *hope;
//@property(nonatomic, copy) NSString *profession;
//@property(nonatomic, copy) NSString *work_position;
//@property(nonatomic, copy) NSString *school;
//@property(nonatomic, strong) NSArray *abilitys;

- (instancetype)init {
    self = [super init];
    if (self) {
        self.birthday=[AppDel localUser].birthday;
        self.nick_name=[AppDel localUser].nick_name;
        self.personal_signature=[AppDel localUser].personal_signature;
        self.liveplace=[AppDel localUser].liveplace;
        self.hope=[AppDel localUser].hope;
        self.profession=[AppDel localUser].profession;
        self.work_position=[AppDel localUser].work_position;
        self.school=[AppDel localUser].school;
        self.traits=[[NSMutableArray alloc] initWithArray:[AppDel localUser].traits];

        self.photo_urls= [[NSMutableArray alloc] init];
        for (NSURL *o in [AppDel localUser].photos) {
            [self.photo_urls addObject:o.absoluteString];
        }
    }
    return self;
}

-(NSMutableArray *)photos {
    NSMutableArray *photos= [[NSMutableArray alloc] init];
    for (NSString *o in self.photo_urls) {
        [photos addObject:[NSURL URLWithString:o]];
    }
    return photos;
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