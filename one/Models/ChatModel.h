//
// Created by JasKang on 15/6/23.
// Copyright (c) 2015 JasKang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"


@interface ChatModel : BaseModel

//"type": 1,     //1：匹配上的提示  2：通话提示
//"chat_id": 25,
//"status": 0,
//"duration": 0,
//"action_usersign": "",
//"time": 1433946041,
//"message": "test"

//type:2,          //1：匹配上的提示  2：通话提示
//chat_id: 25,
//status: 0|2,            //0 未接  2接通并且完成了通话
//duration: 0,             //通话时长，单位:秒
//action_usersign: 26,      //主动拨电话的用户的用户
//time: 1427120968,        //显示时间
//message:""                  //匹配的提示文案

@property(nonatomic, strong) NSNumber *target_usersign;
@property(nonatomic, strong) NSNumber *local_usersign;

@property(nonatomic, strong) NSNumber *action_usersign;

@property(nonatomic, copy) NSString *message;

@property(nonatomic, assign) NSInteger chat_id;
@property(nonatomic, assign) ChatTypeEnum type;
@property(nonatomic, assign) ChatCallStatusEnum status;
@property(nonatomic, assign) NSInteger duration;
@property(nonatomic, assign) NSInteger time;

@property(nonatomic, assign) BOOL showtime;

@property(nonatomic, assign) float cellheight;
@property(nonatomic, assign) float bubblewidth;
@property(nonatomic, assign) float bubbleheight;


- (void)setUsersign:(NSNumber *)usersign andToptime:(NSInteger)toptime;

@end