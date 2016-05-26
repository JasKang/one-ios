//
//  OVoipManager.m
//  one
//
//  Created by JasKang on 15/6/17.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#import "OVoipManager.h"
#import "CallInController.h"

@interface OVoipManager()

@property(nonatomic,assign) ECNetworkType networkType;
@property (nonatomic, retain) NSString *CallId;

@end

@implementation OVoipManager

+ (OVoipManager *)instance {
    static OVoipManager *_instance = nil;

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

    }

    return self;
}


/**
*  登录
*/
- (void)login{
    ECLoginInfo *loginInfo = [[ECLoginInfo alloc] initWithAccount:[AppDel localUser].voip.voip_account Password:[AppDel localUser].voip.voip_pwd];
    loginInfo.subAccount = [AppDel localUser].voip.sub_account_sid;
    loginInfo.subToken = [AppDel localUser].voip.sub_token;
    loginInfo.serviceUrl=@"app.cloopen.com:8883";
    [[ECDevice sharedInstance] login:loginInfo completion:^(ECError *error) {
        if (error.errorCode == ECErrorType_NoError) {
            VoipCallUserInfo * user = [[VoipCallUserInfo alloc]init];
            user.phoneNum = [[AppDel localUser].usersign stringValue];
            user.nickName = [AppDel localUser].nick_name;
            [[ECDevice sharedInstance].voIPManager setSelfPhoneNumber:[[AppDel localUser].usersign stringValue]];
            [[ECDevice sharedInstance].voIPManager setVoipCallUserInfo:user];
            NSLog (@"云通讯====登录成功")
        }
        else{
            NSLog (@"云通讯====登录失败")
        }
    }];
}

/**
*  退出登录
*/
- (void)logout{
    [[ECDevice sharedInstance] logout:^(ECError *error) {
        if (error.errorCode == ECErrorType_NoError) {
            VoipCallUserInfo * user = [[VoipCallUserInfo alloc]init];
            user.phoneNum = [[AppDel localUser].usersign stringValue];
            user.nickName = AppDel.localUser.nick_name;
            [[ECDevice sharedInstance].voIPManager setVoipCallUserInfo:user];
            NSLog (@"云通讯====退出成功")
        }
        else{
            NSLog (@"云通讯====退出失败")
        }
    }];
}

/**
* 获取当前登录状态
* @return 状态值
*/
- (BOOL)isOnline{
    return [[ECDevice sharedInstance] isOnline];
}

/**
*判断voip用户是否在线，同步返回结果，最长阻塞3秒
* @param  voipAccount  voip账号
* @return 1在线，0不在线
**/
-(NSInteger) isOnlineWithAccount:(NSString*) voipAccount{
    return [[ECDevice sharedInstance] checkUserOnlineWithAccount:voipAccount];
}

/**
*  拨打电话
*  @param voipAccount VoIP号码
*  @return 本次电话的id
*/
- (NSString *)makeCallWithAccount:(NSString *)voipAccount{
    // @type 0 语音 1 视频
    return [[ECDevice sharedInstance].voIPManager makeCallWithType:0 andCalled:voipAccount];
}



/**
* 挂断电话
* @param callid 电话id
*/
- (NSInteger)releaseCall:(NSString *)callid{
    return [[ECDevice sharedInstance].voIPManager releaseCall:callid];
}

/**
* 挂断电话
* @param callid 电话id
* @param reason 预留参数,挂断原因值，可以传入大于1000的值，通话对方会在onMakeCallFailed收到该值
*/
- (NSInteger)releaseCall:(NSString *)callid andReason:(NSInteger) reason{
    return [[ECDevice sharedInstance].voIPManager releaseCall:callid andReason:reason];
}

/**
* 接听电话
* @param callid 电话id
* V2.0
*/
- (NSInteger)acceptCall:(NSString*)callid{
    return [[ECDevice sharedInstance].voIPManager acceptCall:callid];
}


/**
* 拒绝呼叫(挂断一样,当被呼叫的时候被呼叫方的挂断状态)
* @param callid 电话id
* @param reason 拒绝呼叫的原因, 可以传入ReasonDeclined:用户拒绝 ReasonBusy:用户忙
*/
- (NSInteger)rejectCall:(NSString *)callid andReason:(NSInteger) reason{
    return [[ECDevice sharedInstance].voIPManager rejectCall:callid andReason:reason];
}


/**
* 获取当前通话的callid
* @return 电话id
*/
-(NSString*)getCurrentCall{
    return [[ECDevice sharedInstance].voIPManager getCurrentCall];
}



/**
* 静音设置
* @param on NO:正常 YES:静音
*/
- (NSInteger)setMute:(BOOL)on{
    return [[ECDevice sharedInstance].voIPManager setMute:on];
}

/**
* 获取当前静音状态
* @return NO:正常 YES:静音
*/
- (BOOL)getMuteStatus{
    return [[ECDevice sharedInstance].voIPManager getMuteStatus];
}

/**
* 获取当前免提状态
* @return NO:关闭 YES:打开
*/
- (BOOL)getLoudsSpeakerStatus{
    return [[ECDevice sharedInstance].voIPManager getLoudsSpeakerStatus];
}

/**
* 免提设置
* @param enable NO:关闭 YES:打开
*/
- (NSInteger)enableLoudsSpeaker:(BOOL)enable{
    return [[ECDevice sharedInstance].voIPManager enableLoudsSpeaker:enable];
}

/**
* 接近检测，通话时如果贴近听筒，关闭屏幕
* @param enable NO:关闭 YES:打开
*/
- (void)enterVoipCallFlow:(BOOL)status{
    [[ECDevice sharedInstance].voIPManager enableLoudsSpeaker:status];
}

#pragma 回调


/********************网络事件回调********************/
/**
@brief 网络改变后调用的代理方法
@param status 网络状态值
*/
- (void)onReachbilityChanged:(ECNetworkType)status{
    NSLog(@"onReachbilityChanged %ld",(long)status);
    if (status==ECNetworkType_NONE) {
        NSLog(@"无网络,请确认网络");
    }else{
        if (_networkType==ECNetworkType_NONE && [UserDefaults boolForKey:kIsLogin]) {
            [self login];
        }
    }
    _networkType=status;
}
/********************登录状态回调********************/
/**
@brief 登录状态接口
@discussion 监听与服务器的登录状态
@param error 连接的状态
*/
-(void)onConnected:(ECError*)error{
    //注意：第⼀一次登录成功不调⽤用此回调，后⾯面的登录⽰示例代码有说明
    if (error.errorCode == ECErrorType_KickedOff) {
        //异地登录
        NSLog (@"异地登录");
        [AppDel kickedOff];
    }else if (error.errorCode == ECErrorType_NoError){
        NSLog (@"服务器重联成功");
    }else{
        NSLog (@"登录失败 错误码:%ld",(long)error.errorCode);
    }
    
    NSLog(@"\r==========\ronConnected errorcode=%ld\r============", (long)error.errorCode);
}

/**
@brief 注销状态接口
@discussion 监听与服务器注销结果
@param error 注销结果
*/
-(void)onDisconnect:(ECError*)error{
    
}


/********************系统事件回调********************/
//P2P连接成功
- (void)onFirewallPolicyEnabled{

}
//音频设备开始中断
- (void)onAudioBeginInterruption{

}
//音频设备结束终端
- (void)onAudioEndInterruption{

}

/********************VoIP通话的方法********************/
//有呼叫进入
- (void)onIncomingCallReceived:(NSString*)callid withCallerAccount:(NSString *)caller withCallerPhone:(NSString *)callerphone withCallerName:(NSString *)callername withCallType:(NSInteger)calltype{
    if(self.uidelegate){
        [[ECDevice sharedInstance].voIPManager rejectCall:callid andReason:ECErrorType_CallBusy];
    }else{
        CallInController *vc=[CallInController initWithCallId:callid userSign:[NSNumber numberWithInteger:[callerphone integerValue]]];
        [[AppDel tabController] presentViewController:vc animated:YES completion:^{
            
        }];
    }
}
//呼叫事件
- (void)onCallEvents:(VoipCall*)voipCall{
    if(self.uidelegate){
        [self.uidelegate onCallEvents:voipCall];
    }
}

//外呼失败
- (void)onMakeCallFailed:(NSString *)callid withReason:(NSInteger)reason{

}
//呼叫被转接
- (void)onCallTransfered:(NSString *)callid transferTo:(NSString *)destination{

}
//视频通话中对端旋转屏幕
- (void)onMessageRemoteVideoRotate:(NSString*)degree{

}
//收到对方切换音视频的请求
//request：0  请求增加视频（需要响应） 1:请求删除视频（不需要响应）
- (void)onSwitchCallMediaTypeRequest:(NSString *)callid withRequest:(NSInteger)request{

}

//收到对方应答切换音视频请求
//切换后的媒体状态 0 有视频 1 无视频
- (void)onSwitchCallMediaTypeResponse:(NSString *)callid withResponse:(NSInteger)response{

}

//视频分辨率发生改变
- (void)onCallVideoRatioChanged:(NSString *)callid andVoIP:(NSString *)voip andIsConfrence:(BOOL)isConference andWidth:(NSInteger)width andHeight:(NSInteger)height{

}

//呼叫时，媒体初始化失败
- (void)onCallMediaInitFailed:(NSString *)callid  withMediaType:(NSInteger) mediaType withReason:(NSInteger)reason{

}

//回拨回调
- (void)onCallBackWithReason:(ECError*)reason andFrom:(NSString*)src To:(NSString*)dest{

}


/**
* 底层上报通话中得原始数据
* @param callid  会话id
* @param inData  底层上报的原始声音数据
* @param outData 加密或解密后的声音数据通过该接口返回给底层
* @param outLen  加密或解密后的声音数据长度
* @param isSend  发送或者接收数据，YES为发送，NO为接收
*/
- (void) onAudioDataWithCallid:(NSString*)callid andInData:(NSData*) inData andOutData:(void *)outData andOutLen:(int*)outLen andIsSend:(BOOL) isSend{

}

/**
* 上报音频原始数据
* @param callid  会话id
* @param inData  底层上报的原始声音数据
* @param sampleRate 采样率
* @param numChannels Channel个数
* @param codec 编解码格式
*/
- (void) onOriginalAudioDataWithCallid:(NSString*)callid andInData:(NSData*) inData andSampleRate:(NSInteger)sampleRate andNumChannels:(NSInteger)numChannels andCodec:(NSString*)codec andIsSend:(BOOL)isSend{

}


@end
