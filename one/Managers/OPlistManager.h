//
// Created by JasKang on 15/6/13.
// Copyright (c) 2015 JasKang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OPlistManager : NSObject

+ (OPlistManager *)instance;


/*!
 *  @brief  更新配置
 *  @param data 配置数据园
 */
- (void)updateConfigWithNSDictionary:(NSDictionary *)data;


/*!
 *  @brief  用户想干啥
 *  @return NSArray<Hope>
 */
- (NSArray *)hopes;

/**
*  职业
*  @return NSArray<Profession>
*/
- (NSArray *)professions;

/*!
 *  @brief  个性标签
 *  @return NSArray<Ability>
 */
- (NSArray *)abilitys;


- (NSArray *)abilitysWithArray:(NSArray *)array;



@end