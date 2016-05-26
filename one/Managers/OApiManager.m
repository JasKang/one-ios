//
// Created by JasKang on 15/6/30.
// Copyright (c) 2015 JasKang. All rights reserved.
//

#import "OApiManager.h"
#import "ODBManager.h"

@interface OApiManager ()

@end

@implementation OApiManager


/**
*  生成签名【IOS】
*  @param dict 请求参数集合
*  @return 返回sign串
*/
+ (NSString *)createSign:(NSMutableDictionary *)dict {
    NSString *sign = @"";
    //排序
    NSArray *sortArray = [dict.allKeys sortedArrayUsingSelector:@selector(compare:)];
    for (NSString *key in sortArray) {
        NSString *value = dict[key];
        sign = [sign stringByAppendingString:[NSString stringWithFormat:@"%@", value]];
    }
    sign = [[NSString stringWithFormat:@"%@%@%@", @"one", sign, @"sign"] sha1];
    return sign;
}

+ (NSString *)UpSaveKey {
    return [[NSString stringWithFormat:@"%@%.0f", AppDel.localUser.usersign, [[NSDate date] timeIntervalSince1970]] md5];
}


/**
*  Api接口带用户签名 Get
*  @param url api地址
*  @param params 参数
*  @param success 成功block
*  @param failure 失败block
*/
+ (void)ApiGet:(NSString *)url
    parameters:(NSDictionary *)params
       success:(void (^)(id data, NSString *message))success
       failure:(void (^)(id status, NSString *message))failure {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:params];
    NSString *usersign = [NSString stringWithFormat:@"%@", AppDel.localUser.usersign];
    NSString *token = AppDel.localUser.token;
    NSString *timestamp = TimeInterval;
    [parameters setValue:usersign forKey:@"usersign"];
    [parameters setValue:timestamp forKey:@"timestamp"];
    NSString *sign = [OApiManager createSign:parameters];
    [parameters removeObjectsForKeys:@[@"usersign", @"timestamp"]];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 10;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:usersign forHTTPHeaderField:@"usersign"];
    [manager.requestSerializer setValue:timestamp forHTTPHeaderField:@"timestamp"];
    [manager.requestSerializer setValue:sign forHTTPHeaderField:@"sign"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"status"] isEqualToNumber:@0]) {
            if (success) {
                success(responseObject[@"data"], responseObject[@"message"]);
            }
        } else if ([responseObject[@"status"] isEqualToNumber:@904]) {
            [AppDel tokenFailure];
        } else {
            if (failure) {
                failure(responseObject[@"status"], responseObject[@"message"]);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(@-1, error.description);
        }
    }];
}

/**
*  Api接口带用户签名 Post
*  @param url api地址
*  @param params 参数
*  @param success 成功block
*  @param failure 失败block
*/
+ (void)ApiPost:(NSString *)url
     parameters:(NSDictionary *)params
        success:(void (^)(id data, NSString *message))success
        failure:(void (^)(id status, NSString *message))failure {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:params];

    NSString *usersign = [NSString stringWithFormat:@"%@", AppDel.localUser.usersign];
    NSString *token = AppDel.localUser.token;
    NSString *timestamp = TimeInterval;
    [parameters setValue:usersign forKey:@"usersign"];
    [parameters setValue:timestamp forKey:@"timestamp"];
    NSString *sign = [OApiManager createSign:parameters];
    [parameters removeObjectsForKeys:@[@"usersign", @"timestamp"]];

    //NSLog(@"%@",sign);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 10;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:usersign forHTTPHeaderField:@"usersign"];
    [manager.requestSerializer setValue:timestamp forHTTPHeaderField:@"timestamp"];
    [manager.requestSerializer setValue:sign forHTTPHeaderField:@"sign"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"status"] isEqualToNumber:@0]) {
            if (success) {
                success(responseObject[@"data"], responseObject[@"message"]);
            }
        } else if ([responseObject[@"status"] isEqualToNumber:@904]) {
            [AppDel tokenFailure];
        } else {
            if (failure) {
                failure(responseObject[@"status"], responseObject[@"message"]);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(@-1, error.description);
        }
    }];
}

/**
*  Api 不带用户签名 Get
*  @param url api地址
*  @param params 参数
*  @param success 成功block
*  @param failure 失败block
*/
+ (void)ApiNoTokenGet:(NSString *)url
           parameters:(NSDictionary *)params
              success:(void (^)(id data, NSString *message))success
              failure:(void (^)(id status, NSString *message))failure {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:params];
    NSString *timestamp = TimeInterval;

    [parameters setValue:timestamp forKey:@"timestamp"];
    NSString *sign = [OApiManager createSign:parameters];
    [parameters removeObjectsForKeys:@[@"timestamp"]];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 10;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"usersign"];
    [manager.requestSerializer setValue:timestamp forHTTPHeaderField:@"timestamp"];
    [manager.requestSerializer setValue:sign forHTTPHeaderField:@"sign"];
    [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"token"];
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"status"] isEqualToNumber:@0]) {
            success(responseObject[@"data"], responseObject[@"message"]);
        } else {
            failure(responseObject[@"status"], responseObject[@"message"]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(@-1, error.description);
    }];
}

/**
*  Api 不带用户签名 Post
*  @param url api地址
*  @param params 参数
*  @param success 成功block
*  @param failure 失败block
*/
+ (void)ApiNoTokenPost:(NSString *)url
            parameters:(NSDictionary *)params
               success:(void (^)(id data, NSString *message))success
               failure:(void (^)(id status, NSString *message))failure {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:params];

    NSString *timestamp = TimeInterval;
    [parameters setValue:timestamp forKey:@"timestamp"];
    NSString *sign = [OApiManager createSign:parameters];
    [parameters removeObjectsForKeys:@[@"timestamp"]];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 10;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"usersign"];
    [manager.requestSerializer setValue:timestamp forHTTPHeaderField:@"timestamp"];
    [manager.requestSerializer setValue:sign forHTTPHeaderField:@"sign"];
    [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"token"];
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"status"] isEqualToNumber:@0]) {
            success(responseObject[@"data"], responseObject[@"message"]);
        } else {
            failure(responseObject[@"status"], responseObject[@"message"]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(@-1, error.description);
    }];
}

/**
*  获取配置信息
*  @param version 时间戳 一个数据更新机制
*  @param success 成功回调
*  @param failure 失败回调
*/
+ (void)configWithVersion:(NSString *)version
                  success:(void (^)(NSDictionary *data))success
                  failure:(void (^)(NSNumber *code, NSString *error))failure {
    [OApiManager ApiNoTokenGet:apiurl_configs parameters:@{@"version_time" : TimeInterval}
            success:^(id data, NSString *message) {
                [[OPlistManager instance] updateConfigWithNSDictionary:data];
                success(data);
            } failure:failure];
}

/**
*  发送验证码
*  @param phonenumber 电话号码
*  @param type        SMSType 短信类型
*  @param success     成功回调
*  @param failure     失败回调
*/
+ (void)sendCodeWithPhoneNumber:(NSString *)phonenumber
                        smsType:(SmsEnum)type
                        success:(void (^)(NSString *info))success
                        failure:(void (^)(NSNumber *code, NSString *error))failure {
    [OApiManager ApiNoTokenPost:apiurl_sendCode parameters:@{@"phone_number" : phonenumber, @"code_type" : @(type)} success:^(id data, NSString *message) {
        success(data[@"code"]);
    } failure:failure];
}

/**
*  接口-登录
*  @param params  参数
*  @param success 成功
*  @param failure 失败
*/
+ (void)loginWithPhoneNumber:(NSString *)phonenumber
                    password:(NSString *)password
                     success:(void (^)(UserModel *user))success
                     failure:(void (^)(NSNumber *code, NSString *error))failure {
    [OApiManager ApiNoTokenPost:apiurl_login parameters:@{@"phone_number" : phonenumber, @"password" : password} success:^(id data, NSString *message) {
        UserModel *obj = [UserModel objectWithKeyValues:data];
        if (!obj) {
            if(failure)failure(@-1, @"APP错误");
            NSLog(@"实体错误");
        } else {
            if (obj.status==UserStatusEnumNone) {
                [AppDel updateLocalUserWithDictionary:data];
            } else {
                [UserDefaults setBool:YES forKey:kIsLogin];
                [AppDel updateLocalUserWithDictionary:data];
                NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
                [nc postNotificationName:kReloadUser object:self];
            }
            if(success){success(obj);}
        }

    } failure:failure];
}

/**
*  接口-注册
*  @param params  参数
*  @param success 成功
*  @param failure 失败
*/
+ (void)regWithPhoneNumber:(NSString *)phonenumber
                  password:(NSString *)password
                   smscode:(NSString *)checkcode
                   success:(void (^)(UserModel *user))success
                   failure:(void (^)(NSNumber *code, NSString *error))failure {
    [OApiManager ApiNoTokenPost:apiurl_register parameters:@{@"phone_number" : phonenumber, @"password" : password, @"code" : checkcode} success:^(id data, NSString *message) {
        UserModel *obj = [UserModel objectWithKeyValues:data];
        if (!obj) {
            if(failure)failure(@-1, @"APP错误");
            NSLog(@"实体错误");
        } else {
            [AppDel updateLocalUserWithDictionary:data];
            if(success)success(obj);
        }

    } failure:failure];
}

/**
*  完善资料
*  @param params  参数
*  @param success 成功回调
*  @param failure 失败回调
*/
+ (void)perfectOwnWithParams:(NSDictionary *)params
                     success:(void (^)(UserModel *user))success
                     failure:(void (^)(NSNumber *code, NSString *error))failure {
    [OApiManager ApiPost:apiurl_perfctOwnInfo parameters:params success:^(id data, NSString *message) {
        UserModel *obj = [UserModel objectWithKeyValues:data];
        if (!obj) {
            if(failure)failure(@-1, @"APP错误");
            NSLog(@"实体错误");
        } else {
            if (obj.status==UserStatusEnumDone) {
                [UserDefaults setBool:YES forKey:kIsLogin];
            }
            [AppDel updateLocalUserWithDictionary:data];
            if(success)success(obj);
        }
    } failure:failure];
}

/**
*  更新个人资料
*  @param params  参数
*  @param success 成功回调
*  @param failure 失败回调
*/
+ (void)updateOwnWithParams:(NSDictionary *)params
                    success:(void (^)(UserModel *user))success
                    failure:(void (^)(NSNumber *code, NSString *error))failure {
    [OApiManager ApiPost:apiurl_updateOwnInfo parameters:params success:^(id data, NSString *message) {
        UserModel *obj = [UserModel objectWithKeyValues:data];
        if (!obj) {
            if(failure)failure(@-1, @"APP错误");
            NSLog(@"实体错误");
        } else {
            [AppDel updateLocalUserWithDictionary:data];
            NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
            [nc postNotificationName:kReloadUser object:self];
            if(success)success(obj);
        }
    } failure:failure];
}

/**
*  取个人资料
*  @param success 成功回调
*  @param failure 失败回调
*/
+ (void)ownSuccess:(void (^)(UserModel *user))success
           failure:(void (^)(NSNumber *code, NSString *error))failure {
    [OApiManager ApiPost:apiurl_getOwnInfo parameters:@{} success:^(id data, NSString *message) {
        UserModel *obj = [UserModel objectWithKeyValues:data];
        if (!obj) {
            if (failure) failure(@-1, @"APP错误");
            NSLog(@"实体错误");
        } else {
            [AppDel updateLocalUserWithDictionary:data];
            if (success) success(obj);
        }

    } failure:failure];
}

/**
*  取 Feeds
*  @param success 成功回调
*  @param failure 失败回调
*/
+ (void)feedsWithSex:(SexEnum)sex
             atIndex:(NSInteger)index
             success:(void (^)(NSArray *feeds))success
             failure:(void (^)(NSNumber *code, NSString *error))failure {
    NSDictionary *params = @{
            @"sex" : @(sex),
            @"index" : @(index)
    };
    [OApiManager ApiGet:apiurl_getFeeds parameters:params success:^(id data, NSString *message) {

        NSArray *obj_list = [FeedModel objectArrayWithKeyValuesArray:data];
        if (!obj_list) {
            if(failure)failure(@-1, @"APP错误");
            NSLog(@"实体错误");
        } else {
            if(success){success(obj_list);}
            for (FeedModel *obj in obj_list) {
                [OApiManager userWithUserSign:obj.usersign success:nil failure:nil];
            }
        }
    } failure:^(id status, NSString *message) {
        failure(@-1, message);
    }];
}

/**
*  取用户信息
*  @param obj_usersign 用户标识
*  @param success 成功回调
*  @param failure 失败回调
*/
+ (void)userWithUserSign:(NSNumber *)obj_usersign
                 success:(void (^)(UserModel *user))success
                 failure:(void (^)(NSNumber *code, NSString *error))failure {
    UserModel *cache = [[ODBManager instance] userWithUserSign:obj_usersign];
    if (cache) {
        if(success){success(cache);}
    }
    [OApiManager ApiGet:apiurl_getUserInfo parameters:@{@"obj_usersign" : obj_usersign} success:^(id data, NSString *message) {
        UserModel *obj = [UserModel objectWithKeyValues:data];
        if (!obj) {
            if(failure)failure(@-1, @"APP错误");
            NSLog(@"实体错误");
        } else {
            if(success){success(obj);}
            [[ODBManager instance] putUserWithValue:data];
        }
    } failure:failure];
}

/**
*  点赞
*  @param obj_usersign 用户标识
*  @param success 成功回调
*  @param failure 失败回调
*/
+ (void)likeUser:(NSNumber *)obj_usersign
         success:(void (^)(NSString *message))success
         failure:(void (^)(NSNumber *code, NSString *error))failure {
    [OApiManager ApiPost:apiurl_likeUser parameters:@{@"obj_usersign" : obj_usersign} success:^(id data, NSString *message) {
        if(success){success(message);}
    } failure:failure];
}

/**
*  取好友列表
*  @param success 成功回调
*  @param failure 失败回调
*/
+ (void)friendListSuccess:(void (^)(NSArray *chats))success
                  failure:(void (^)(NSNumber *code, NSString *error))failure {

    [OApiManager ApiGet:apiurl_getFriendList parameters:nil success:^(id data, NSString *message) {
        NSArray *obj_list = [MsgModel objectArrayWithKeyValuesArray:data];
        if (!obj_list) {
            if(failure)failure(@-1, @"APP错误");
            NSLog(@"实体错误");
        } else {
            if(success){success(obj_list);}
            [[ODBManager instance] putMessageArray:data];
            for (MsgModel *obj in obj_list) {
                if (obj.type==MessageTypeUser) {
                    [OApiManager userWithUserSign:obj.usersign success:nil failure:nil];
                }
            }
        }
    } failure:failure];
}


/**
*  取消息记录
*  @param obj_usersign 用户标识
*  @param success 成功回调
*  @param failure 失败回调
*/
+ (void)chatsWithUsersign:(NSNumber *)obj_usersign
                  success:(void (^)(NSArray *messages))success
                  failure:(void (^)(NSNumber *code, NSString *error))failure {
    [OApiManager ApiGet:apiurl_getMessages parameters:@{@"obj_usersign" : obj_usersign} success:^(id data, NSString *message) {
        if (data) {
            NSMutableArray *obj_list=[[NSMutableArray alloc] init];
            NSInteger count=[data count];
            ChatModel *top_obj=nil;
            for (NSInteger i=count; i>0; i--) {
                NSDictionary *msg=[data objectAtIndex:i-1];
                ChatModel *obj= [ChatModel objectWithKeyValues:msg];
                if (top_obj) {
                    [obj setUsersign:obj_usersign andToptime:top_obj.time];
                }else{
                    [obj setUsersign:obj_usersign andToptime:0];
                }
                top_obj=obj;
                [obj_list addObject:obj];
            }
            [[ODBManager instance] putChatArrayWithUsersign:obj_usersign value:data];
            if(success){success(obj_list);}
        }else{
            if(failure)failure(@-1, @"APP错误");
        }
    } failure:failure];
}


/**
 *  移除通话权限
 *  @param obj_usersign 用户标识
 *  @param success      成功回调
 *  @param failure      失败回调
 */
+ (void)removeAuthorityWithUsersign:(NSNumber *)obj_usersign
                            success:(void (^)(NSString *messages))success
                            failure:(void (^)(NSNumber *code, NSString *error))failure{
    [OApiManager ApiPost:apiurl_removeAuthority parameters:@{@"obj_usersign" : obj_usersign} success:^(id data, NSString *message) {
        if(success){success(message);}
    } failure:failure];
}

+ (void)noticeListSuccess:(void (^)(NSArray *messages))success
                  failure:(void (^)(NSNumber *code, NSString *error))failure{
    [OApiManager ApiGet:apiurl_newNoticeList parameters:nil success:^(id data, NSString *message) {
        NSArray *obj_list = [NewNoticeModel objectArrayWithKeyValuesArray:data];
        if (!obj_list) {
            if(failure)failure(@-1, @"APP错误");
            NSLog(@"实体错误");
        } else {
            if(success){success(obj_list);}
        }
    } failure:failure];
}

/**
*  更新地理位置
*  @param longitude 经度 例如：浮点数234.32
*  @param latitude  维度 例如：浮点数114.32
*/
+ (void)putLocateLongitude:(NSNumber *)longitude
                  latitude:(NSNumber *)latitude {
    [OApiManager ApiPost:apiurl_putLoc parameters:@{@"longitude" : longitude, @"latitude" : latitude} success:^(id data, NSString *message) {

    } failure:^(id status, NSString *message) {

    }];
}


@end