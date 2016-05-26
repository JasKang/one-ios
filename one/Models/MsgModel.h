//
// Created by JasKang on 15/6/23.
// Copyright (c) 2015 JasKang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"


@interface MsgModel : BaseModel

//"type": 1, //用户与小助手
//"nick_name": "嗡嗡小助手",
//"ytx": {
//    "voip_account": ""
//},
//"photo": "http://imwengweng/images/logo_web.png",
//"usersign": "",
//"new_message_count": 4,  //未读消息数
//"update_time": "14087759944",
//"last_message": {
//    "type": 1,     //1：匹配上的提示  2：通话提示
//            "chat_id": 25,
//            "status": 0,
//            "duration": 0,
//            "action_usersign": "",
//            "time": 1433946041,
//            "message": "test"
//}


@property(nonatomic, assign) MessageTypeEnum type;
@property(nonatomic, copy) NSString *nick_name;
@property(nonatomic, strong) NSURL *photo;
@property(nonatomic, assign) NSUInteger new_message_count;
@property(nonatomic, strong) NSNumber *usersign;
@property(nonatomic, assign) NSInteger update_time;
@property(nonatomic, strong) VoipModel *voip;
@property(nonatomic, strong) ChatModel *chat;

@end