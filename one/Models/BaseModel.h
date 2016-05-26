//
// Created by JasKang on 15/6/23.
// Copyright (c) 2015 JasKang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

typedef enum {
    UserStatusEnumNone = 0, //未完善资料
    UserStatusEnumDone = 1, //已经完善资料
} UserStatusEnum;

/**
*  喜欢状态
*/
typedef enum {
    LikeEnumNone = 0, //未点击
    LikeEnumYes = 1, //赞
    LikeEnumBoth = 2//互相赞
} LikeEnum;

typedef enum {
    SexEnumNone = 0, //未设置
    SexEnumWomen = 1, //女
    SexEnumMen = 2 //男
} SexEnum;

typedef enum {
    NewNoticeTypeEnumNone = 0,
    NewNoticeTypeEnumZan = 1,
} NewNoticeTypeEnum;



typedef enum {
    MessageTypeNewer = 0, //新通知
    MessageTypeHelper = 1, //小助手
    MessageTypeUser = 2//用户消息
} MessageTypeEnum;

typedef enum {
    ChatTypeEnumText = 1, //文字消息
    ChatTypeEnumCall = 2 ,//通话
} ChatTypeEnum;

typedef enum {
    ChatCallStatusEnumFail = 0, //未接通
    ChatCallStatusEnumStream = 2 ,//已接通
} ChatCallStatusEnum;



@interface BaseModel : NSObject

@end