//
//  OVoipManager.h
//  one
//
//  Created by JasKang on 15/6/17.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECDeviceHeaders.h"

@protocol OVoipUIDelegate
//呼叫事件
- (void)onCallEvents:(VoipCall*)voipCall;

@end

@interface OVoipManager : NSObject<ECDeviceDelegate,ECVoIPCallDelegate,AVAudioPlayerDelegate>

@property (nonatomic, weak) id<OVoipUIDelegate> uidelegate;

+ (OVoipManager *)instance;

/**
*  登录
*/
- (void)login;

/**
*  退出登录
*/
- (void)logout;

/**
* 获取当前登录状态
* @return 状态值
*/
- (BOOL)isOnline;

/**
*判断voip用户是否在线，同步返回结果，最长阻塞3秒
* @param  voipAccount  voip账号
* @return 1在线，0不在线
**/
-(NSInteger)isOnlineWithAccount:(NSString*) voipAccount;

/**
*  拨打电话
*  @param caller VoIP号码
*  @return 本次电话的id
*/
- (NSString *)makeCallWithAccount:(NSString *)voipAccount;

/**
* 挂断电话
* @param callid 电话id
*/
- (NSInteger)releaseCall:(NSString *)callid;
/**
* 挂断电话
* @param callid 电话id
* @param reason 预留参数,挂断原因值，可以传入大于1000的值，通话对方会在onMakeCallFailed收到该值
*/
- (NSInteger)releaseCall:(NSString *)callid andReason:(NSInteger) reason;
/**
* 接听电话
* @param callid 电话id
* V2.0
*/
- (NSInteger)acceptCall:(NSString*)callid;

/**
* 拒绝呼叫(挂断一样,当被呼叫的时候被呼叫方的挂断状态)
* @param callid 电话id
* @param reason 拒绝呼叫的原因, 可以传入ReasonDeclined:用户拒绝 ReasonBusy:用户忙
*/
- (NSInteger)rejectCall:(NSString *)callid andReason:(NSInteger) reason;

/**
* 获取当前通话的callid
* @return 电话id
*/
-(NSString*)getCurrentCall;

/**
* 静音设置
* @param on NO:正常 YES:静音
*/
- (NSInteger)setMute:(BOOL)on;
/**
* 获取当前静音状态
* @return NO:正常 YES:静音
*/
- (BOOL)getMuteStatus;
/**
* 获取当前免提状态
* @return NO:关闭 YES:打开
*/
- (BOOL)getLoudsSpeakerStatus;
/**
* 免提设置
* @param enable NO:关闭 YES:打开
*/
- (NSInteger)enableLoudsSpeaker:(BOOL)enable;
/**
* 接近检测，通话时如果贴近听筒，关闭屏幕
* @param enable NO:关闭 YES:打开
*/
- (void)enterVoipCallFlow:(BOOL)status;


@end
