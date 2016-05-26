//
// Created by JasKang on 15/6/13.
// Copyright (c) 2015 JasKang. All rights reserved.
//

#import "OPlistManager.h"

@interface OPlistManager ()

@property(nonatomic, strong) NSString *configPath;
@property(nonatomic, strong) NSString *friendsPath;

@end

@implementation OPlistManager

+ (OPlistManager *)instance {
    static OPlistManager *_instance = nil;
    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }
    return _instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        //获取路径对象
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        //获取完整路径
        NSString *documentsDirectory = paths[0];
        _configPath = [documentsDirectory stringByAppendingPathComponent:@"configs.plist"];
        _friendsPath = [documentsDirectory stringByAppendingPathComponent:@"friends.plist"];
    }
    return self;
}


- (void)updateConfigWithNSDictionary:(NSDictionary *)data {
    NSMutableDictionary *configsplist = [[NSMutableDictionary alloc] init];
    //设置属性值
    configsplist[@"hopes"] = data[@"hopes"];
    configsplist[@"professions"] = data[@"professions"];
    configsplist[@"abilitys"] = data[@"abilitys"];
    //写入文件
    [configsplist writeToFile:_configPath atomically:YES];
}

/*!
 *  @brief  用户想干啥
 *  @return NSArray<Hope>
 */
- (NSArray *)hopes {
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:_configPath];
    return [HopeModel objectArrayWithKeyValuesArray:data[@"hopes"]];
}

/**
*  职业
*  @return NSArray<Profession>
*/
- (NSArray *)professions {
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:_configPath];
    return [JobModel objectArrayWithKeyValuesArray:data[@"professions"]];
}

/*!
 *  @brief  个性标签
 *  @return NSArray<Ability>
 */
- (NSArray *)abilitys {
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:_configPath];
    return [TraitModel objectArrayWithKeyValuesArray:data[@"abilitys"]];
}

- (NSArray *)abilitysWithArray:(NSArray *)array {
    NSArray *fullArray = [self abilitys];
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    for (NSNumber *object in array) {
        for (TraitModel *traitobj in fullArray) {
            
            if([object isKindOfClass:[TraitModel class]]){
                NSLog(@"%@",object);
            }
            if ([object isEqualToNumber:traitobj.ability_id]) {
                [ret addObject:traitobj];
            }
        }
    }
    return ret;
}

@end