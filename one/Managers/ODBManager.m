//
// Created by JasKang on 15/6/13.
// Copyright (c) 2015 JasKang. All rights reserved.
//

#import "ODBManager.h"
#import "YTKKeyValueStore.h"

#define DB_NAME @"one_v3.db"

#define DB_TABLE_USER @"users"
#define DB_TABLE_MESSAGE @"messages"
#define DB_TABLE_CHAT @"chats"

@interface ODBManager ()
@property(nonatomic,strong) YTKKeyValueStore *store;
@property(nonatomic,strong) NSString *messageTableName;
@end

@implementation ODBManager

+ (ODBManager *)instance {
    static ODBManager *_instance = nil;
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
        // 执行打开数据库和创建表操作
        _store = [[YTKKeyValueStore alloc] initDBWithName:DB_NAME];
        [_store createTableWithName:DB_TABLE_USER];
        _messageTableName=[NSString stringWithFormat:@"%@_%@",DB_TABLE_MESSAGE,[[AppDel localUser].usersign stringValue]];
        [_store createTableWithName:_messageTableName];
        
    }
    return self;
}

-(void)putUserWithValue:(NSDictionary *)data{
    [_store putObject:data withId:[data[@"usersign"] stringValue] intoTable:DB_TABLE_USER];
}

-(UserModel *)userWithUserSign:(NSNumber *)usersign{
    NSDictionary *obj = [_store getObjectById:[usersign stringValue] fromTable:DB_TABLE_USER];
    if (obj) {
        return [UserModel objectWithKeyValues:obj];
    }
    return nil;
}


-(void)putMessage:(NSDictionary *)data{
    [_store putObject:data withId:data[@"usersign"] intoTable:_messageTableName];
}
-(void)putMessageArray:(NSArray *)data{
    [_store clearTable:_messageTableName];
    for (NSDictionary *object in data) {
        if ([object[@"usersign"] isKindOfClass:[NSString class]]) {
            [_store putObject:object withId:@"0" intoTable:_messageTableName];
        }else{
            [_store putObject:object withId:[object[@"usersign"] stringValue] intoTable:_messageTableName];
        }
        
    }
}
-(NSArray *)messageArray{
    NSArray *obj_list=[_store getAllItemsFromTable:_messageTableName];
    NSMutableArray *temp_list=[[NSMutableArray alloc] init];
    for (YTKKeyValueItem *object in obj_list) {
        [temp_list addObject:[MsgModel objectWithKeyValues:object.itemObject]];
    }
    return temp_list;
}


-(void)putChatArrayWithUsersign:(NSNumber *)usersign value:(NSArray *)data{
    NSString *tableName=[NSString stringWithFormat:@"%@_%@_%@",DB_TABLE_CHAT,[[AppDel localUser].usersign stringValue],[usersign stringValue]];
    [_store createTableWithName:tableName];
    for (NSDictionary *object in data) {
        [_store putObject:object withId:[object[@"chat_id"] stringValue] intoTable:tableName];
    }
}
-(NSArray *)chatArrayWithUsersign:(NSNumber *)usersign{
    NSString *tableName=[NSString stringWithFormat:@"%@_%@_%@",DB_TABLE_CHAT,[[AppDel localUser].usersign stringValue],[usersign stringValue]];
    NSArray *obj_list=[_store getAllItemsFromTable:tableName];
    
    NSMutableArray *temp_list=[[NSMutableArray alloc] init];
    if (obj_list.count>0) {
        NSInteger count=[obj_list count];
        ChatModel *top_obj=nil;
        for (NSInteger i=count; i>0; i--) {
            YTKKeyValueItem *msg= obj_list[i - 1];
            ChatModel *obj= [ChatModel objectWithKeyValues:msg.itemObject];
            if (top_obj) {
                [obj setUsersign:usersign andToptime:top_obj.time];
            }else{
                [obj setUsersign:usersign andToptime:0];
            }
            top_obj=obj;
            [temp_list addObject:obj];
        }
    }
    return temp_list;
}


@end