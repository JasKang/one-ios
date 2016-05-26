//
// Created by JasKang on 15/6/30.
// Copyright (c) 2015 JasKang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

#define qn_host @"http://7xij68.com1.z0.glb.clouddn.com"

#define apiurl_base  @"http://dev.api.imwengweng.com/"
#define apiurl_sendCode @"http://dev.api.imwengweng.com/Api/Oauth/sendCode"
#define apiurl_configs @"http://dev.api.imwengweng.com/Api/Oauth/getConfs"
#define apiurl_register @"http://dev.api.imwengweng.com/Api/Oauth/register"
#define apiurl_login @"http://dev.api.imwengweng.com/Api/Oauth/login"
#define apiurl_forgetpassword @"http://dev.api.imwengweng.com/Api/Oauth/forgetPassword"

#define apiurl_perfctOwnInfo @"http://dev.api.imwengweng.com/Api/User/perfectUserInfo"
#define apiurl_updateOwnInfo @"http://dev.api.imwengweng.com/Api/User/modifyUserInfo"
#define apiurl_getOwnInfo @"http://dev.api.imwengweng.com/Api/User/getUserInfo"
#define apiurl_updatePwd @"http://dev.api.imwengweng.com/Api/User/modifyPassword"
#define apiurl_putLoc @"http://dev.api.imwengweng.com/Api/User/updateLocate"
#define apiurl_getFeeds @"http://dev.api.imwengweng.com/Api/User/getUserList"
#define apiurl_getUserInfo @"http://dev.api.imwengweng.com/Api/User/getUserDetail"
#define apiurl_likeUser @"http://dev.api.imwengweng.com/Api/User/likeUser"


#define apiurl_getFriendList @"http://dev.api.imwengweng.com/Api/User/getUserFriendList"
#define apiurl_getMessages @"http://dev.api.imwengweng.com/Api/User/getChatNotesList"
#define apiurl_removeAuthority @"http://dev.api.imwengweng.com/Api/User/removeAuthority"

#define apiurl_newNoticeList @"http://dev.api.imwengweng.com/Api/System/getTipNotesList"



/**
*  短信类型
*/
typedef enum {
    SmsEnumReg = 1, //注册
    SmsEnumForget = 2 //忘记密码
} SmsEnum;

@interface OApiManager : NSObject


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
       failure:(void (^)(id status, NSString *message))failure;

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
        failure:(void (^)(id status, NSString *message))failure;

/**
*  Api接口不带用户签名 Get
*  @param url api地址
*  @param params 参数
*  @param success 成功block
*  @param failure 失败block
*/
+ (void)ApiNoTokenGet:(NSString *)url
           parameters:(NSDictionary *)params
              success:(void (^)(id data, NSString *message))success
              failure:(void (^)(id status, NSString *message))failure;

/**
*  Api接口不带用户签名 Post
*  @param url api地址
*  @param params 参数
*  @param success 成功block
*  @param failure 失败block
*/
+ (void)ApiNoTokenPost:(NSString *)url
            parameters:(NSDictionary *)params
               success:(void (^)(id data, NSString *message))success
               failure:(void (^)(id status, NSString *message))failure;

/**
*  获取配置信息
*  @param version 时间戳 一个数据更新机制
*  @param success 成功回调
*  @param failure 失败回调
*/
+ (void)configWithVersion:(NSString *)version
                  success:(void (^)(NSDictionary *data))success
                  failure:(void (^)(NSNumber *code, NSString *error))failure;

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
                        failure:(void (^)(NSNumber *code, NSString *error))failure;

/**
*  接口-登录
*  @param params  参数
*  @param success 成功
*  @param failure 失败
*/
+ (void)loginWithPhoneNumber:(NSString *)phonenumber
                    password:(NSString *)password
                     success:(void (^)(UserModel *user))success
                     failure:(void (^)(NSNumber *code, NSString *error))failure;

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
                   failure:(void (^)(NSNumber *code, NSString *error))failure;

/**
*  完善资料
*  @param params  参数
*  @param success 成功回调
*  @param failure 失败回调
*/
+ (void)perfectOwnWithParams:(NSDictionary *)params
                     success:(void (^)(UserModel *))success
                     failure:(void (^)(NSNumber *code, NSString *error))failure;


/**
*  更新个人资料
*  @param params  参数
*  @param success 成功回调
*  @param failure 失败回调
*/
+ (void)updateOwnWithParams:(NSDictionary *)params
                    success:(void (^)(UserModel *))success
                    failure:(void (^)(NSNumber *code, NSString *error))failure;

/**
*  取个人资料
*  @param success 成功回调
*  @param failure 失败回调
*/
+ (void)ownSuccess:(void (^)(UserModel *))success
           failure:(void (^)(NSNumber *code, NSString *error))failure;

/**
*  取 Feeds
*  @param success 成功回调
*  @param failure 失败回调
*/
+ (void)feedsWithSex:(SexEnum)sex
             atIndex:(NSInteger)index
             success:(void (^)(NSArray *feeds))success
             failure:(void (^)(NSNumber *code, NSString *error))failure;

/**
*  取用户信息
*  @param obj_usersign 用户标识
*  @param success 成功回调
*  @param failure 失败回调
*/
+ (void)userWithUserSign:(NSNumber *)obj_usersign
                 success:(void (^)(UserModel *))success
                 failure:(void (^)(NSNumber *code, NSString *error))failure;

/**
*  点赞
*  @param obj_usersign 用户标识
*  @param success 成功回调
*  @param failure 失败回调
*/
+ (void)likeUser:(NSNumber *)obj_usersign
         success:(void (^)(NSString *message))success
         failure:(void (^)(NSNumber *code, NSString *error))failure;

/**
*  取好友列表
*  @param success 成功回调
*  @param failure 失败回调
*/
+ (void)friendListSuccess:(void (^)(NSArray *chats))success
                  failure:(void (^)(NSNumber *code, NSString *error))failure;


/**
 *  移除通话权限
 *  @param obj_usersign 用户标识
 *  @param success      成功回调
 *  @param failure      失败回调
 */
+ (void)removeAuthorityWithUsersign:(NSNumber *)obj_usersign
                            success:(void (^)(NSString *messages))success
                            failure:(void (^)(NSNumber *code, NSString *error))failure;

/**
*  取消息记录
*  @param obj_usersign 用户标识
*  @param success 成功回调
*  @param failure 失败回调
*/
+ (void)chatsWithUsersign:(NSNumber *)obj_usersign
                  success:(void (^)(NSArray *messages))success
                  failure:(void (^)(NSNumber *code, NSString *error))failure;

/**
*  更新地理位置
*  @param longitude 经度 例如：浮点数234.32
*  @param latitude  维度 例如：浮点数114.32
*/
+ (void)putLocateLongitude:(NSNumber *)longitude
                  latitude:(NSNumber *)latitude;


+ (void)noticeListSuccess:(void (^)(NSArray *messages))success
                  failure:(void (^)(NSNumber *code, NSString *error))failure;


@end