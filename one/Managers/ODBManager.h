//
// Created by JasKang on 15/6/13.
// Copyright (c) 2015 JasKang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YTKKeyValueStore.h>

@interface ODBManager : NSObject
+ (ODBManager *)instance;


- (void)putUserWithValue:(NSDictionary *)data;

- (UserModel *)userWithUserSign:(NSNumber *)usersign;

- (void)putMessage:(NSDictionary *)data;

- (void)putMessageArray:(NSArray *)data;

- (NSArray *)messageArray;

- (void)putChatArrayWithUsersign:(NSNumber *)usersign value:(NSArray *)data;

- (NSArray *)chatArrayWithUsersign:(NSNumber *)usersign;

@end