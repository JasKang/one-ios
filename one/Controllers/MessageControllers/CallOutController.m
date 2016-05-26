//
// Created by JasKang on 15/6/16.
// Copyright (c) 2015 JasKang. All rights reserved.
//

#import "CallOutController.h"
#import "ODBManager.h"

@interface CallOutController () {
    int hhInt;
    int mmInt;
    int ssInt;
}

@property(nonatomic, strong) UserModel *user;

@property(nonatomic, strong) UILabel *ibtime;

@property(nonatomic, strong) UIButton *btnLeft;

@property(nonatomic, strong) UIButton *btnRight;

@property(nonatomic, strong) NSTimer *timer;

@property(nonatomic, strong) NSString *voip_account;
@property(nonatomic, strong) NSString *callId;
@property(nonatomic, strong) NSNumber *usersign;
@property(nonatomic, assign) enum ECallStatus status;

@end

@implementation CallOutController


+ (instancetype)initWithVoipaccount:(NSString *)voip_account userSign:(NSNumber *)usersign {
    CallOutController *vc = [[CallOutController alloc] init];
    vc.voip_account = voip_account;
    vc.usersign = usersign;
    vc.user = [[ODBManager instance] userWithUserSign:usersign];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    hhInt = 0;
    mmInt = 0;
    ssInt = 0;

    self.view = [[UIView alloc] initWithFrame:ScreenBounds];
    self.view.backgroundColor = GetUIColor(0x333333);
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:ScreenBounds];
    [bgView setContentMode:UIViewContentModeScaleAspectFill];
    [bgView sd_setImageWithURL:[self.user.photo URLWithBlur]];
    [self.view addSubview:bgView];

    UIImageView *ivPhoto = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth - 170) / 2, (CGFloat) (ScreenHeight * 0.22), 170, 170)];
    ivPhoto.layer.cornerRadius = 3.0;
    ivPhoto.layer.masksToBounds = YES;
    [ivPhoto sd_setImageWithURL:self.user.photo placeholderImage:LoadImage(@"tou_normal")];
    [self.view addSubview:ivPhoto];

    UILabel *ibnickname = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth - 170) / 2, (CGFloat) (ScreenHeight * 0.1), 170, 21)];
    [ibnickname setText:self.user.nick_name];
    [ibnickname setTextColor:[UIColor whiteColor]];
    [ibnickname setFont:[UIFont systemFontOfSize:20]];
    [ibnickname setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:ibnickname];

    UILabel *ibtip = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth - 170) / 2, (CGFloat) (ScreenHeight * 0.56), 170, 21)];
    [ibtip setText:@"尝试和他聊聊"];
    [ibtip setTextColor:[UIColor whiteColor]];
    [ibtip setFont:[UIFont systemFontOfSize:15]];
    [ibtip setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:ibtip];

    self.ibtime = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth - 170) / 2, (CGFloat) (ScreenHeight * 0.16), 170, 21)];
    [self.ibtime setText:@"正在呼叫"];
    [self.ibtime setTextColor:[UIColor whiteColor]];
    [self.ibtime setFont:[UIFont systemFontOfSize:12]];
    [self.ibtime setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:self.ibtime];

    self.btnRight = [[UIButton alloc] initWithFrame:CGRectMake((ScreenWidth - 75) / 2, (CGFloat) (ScreenHeight * 0.78), 75, 75)];
    [self.btnRight setImage:LoadImage(@"Call_Handsfree_normal") forState:UIControlStateNormal];
    [self.btnRight setImage:LoadImage(@"Call_Handsfree_pressed") forState:UIControlStateHighlighted];
    [self.btnLeft addTarget:self action:@selector(tapRight) forControlEvents:UIControlEventTouchUpInside];
    [self.btnRight setHidden:YES];
    [self.view addSubview:self.btnRight];


    self.btnLeft = [[UIButton alloc] initWithFrame:CGRectMake((ScreenWidth - 75) / 2, (CGFloat) (ScreenHeight * 0.78), 75, 75)];
    [self.btnLeft setImage:LoadImage(@"Call_Refuse_noraml") forState:UIControlStateNormal];
    [self.btnLeft setImage:LoadImage(@"Call_Refuse_pressed") forState:UIControlStateHighlighted];
    [self.btnLeft addTarget:self action:@selector(tapLeft) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnLeft];

    [OVoipManager instance].uidelegate = self;

    _callId = [[OVoipManager instance] makeCallWithAccount:_voip_account];

}

- (void)onCallEvents:(VoipCall *)voipCall {

    switch (voipCall.callStatus) {
        case ECallProceeding: {
            self.ibtime.text = @"正在呼叫...";
        }
            break;
        case ECallAlerting: {
            //关闭扬声器,听筒播放来电铃声
            self.ibtime.text = @"等待对方接听";
        }
            break;
        case ECallStreaming: {
            self.ibtime.text = @"00:00";

            [self.btnRight setHidden:NO];
            [UIView animateWithDuration:0.3f animations:^{
                self.btnLeft.frame = CGRectMake(ScreenWidth / 4 - 37.5, ScreenHeight * 0.78, 75, 75);
                self.btnRight.frame = CGRectMake(ScreenWidth - ScreenWidth / 4 - 37.5, ScreenHeight * 0.78, 75, 75);
            }];
            if (![self.timer isValid]) {
                self.timer = [NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(updateRealtimeLabel) userInfo:nil repeats:YES];
                [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
                [self.timer fire];
            }
        }
            break;
        case ECallFailed: {
            NSLog(@"reason:%d", voipCall.reason);
            if (voipCall.reason == ECErrorType_NoResponse) {
                self.ibtime.text = @"网络不给力";
            }
            else if (voipCall.reason == ECErrorType_BadCredentials) {
                self.ibtime.text = @"鉴权失败";
            }
            else if (voipCall.reason == ECErrorType_CallBusy || voipCall.reason == ECErrorType_Declined) {
                self.ibtime.text = @"您拨叫的用户正忙，请稍后再拨";
            }
            else if (voipCall.reason == ECErrorType_NoResponse) {
                self.ibtime.text = @"对方无响应";

            } else if (voipCall.reason == ECErrorType_NotFound) {

                self.ibtime.text = @"对方不在线";
            }
            else if (voipCall.reason == ECErrorType_CallMissed) {
                self.ibtime.text = @"呼叫超时";
            }
            else if (voipCall.reason == ECErrorType_NoNetwork) {
                self.ibtime.text = @"当前无网络";
            }
            else if (voipCall.reason == ECErrorType_SDKUnSupport) {
                self.ibtime.text = @"该版本不支持此功能";
            }
            else if (voipCall.reason == ECErrorType_CalleeSDKUnSupport) {
                self.ibtime.text = @"对方版本不支持音频";
            } else {
                self.ibtime.text = @"呼叫失败";
            }
            [[OVoipManager instance] releaseCall:_callId];
            [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(backFront) userInfo:nil repeats:NO];
        }
            break;
        case ECallEnd: {
            if ([self.timer isValid]) {
                [self.timer invalidate];
                self.timer = nil;
            }
            //            self.ibtime.text = @"正在挂机...";
            [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(backFront) userInfo:nil repeats:NO];
        }
            break;
        default:
            break;
    }
    _status = voipCall.callStatus;
}


- (void)tapLeft {
    [[OVoipManager instance] releaseCall:_callId];
}

- (void)tapRight {
    if ([[OVoipManager instance] getLoudsSpeakerStatus]) {
        [[OVoipManager instance] enableLoudsSpeaker:NO];
        [self.btnRight setImage:LoadImage(@"Call_Handsfree_normal") forState:UIControlStateNormal];
        [self.btnRight setImage:LoadImage(@"Call_Handsfree_pressed") forState:UIControlStateHighlighted];
    } else {
        [[OVoipManager instance] enableLoudsSpeaker:YES];
        [self.btnRight setImage:LoadImage(@"Call_Handsfree_pressed") forState:UIControlStateNormal];
        [self.btnRight setImage:LoadImage(@"Call_Handsfree_normal") forState:UIControlStateHighlighted];
    }
}

- (void)backFront {
    [OVoipManager instance].uidelegate = nil;
    if ([self.timer isValid]) {
        [self.timer invalidate];
        self.timer = nil;
    }
    [self dismissViewControllerAnimated:YES completion:^{

    }];
}


- (void)updateRealtimeLabel {
    ssInt += 1;
    if (ssInt >= 60) {
        mmInt += 1;
        ssInt -= 60;
        if (mmInt >= 60) {
            hhInt += 1;
            mmInt -= 60;
            if (hhInt >= 24) {
                hhInt = 0;
            }
        }
    }
    if (hhInt > 0) {
        self.ibtime.text = [NSString stringWithFormat:@"%02d:%02d:%02d", hhInt, mmInt, ssInt];
    }
    else {
        self.ibtime.text = [NSString stringWithFormat:@"%02d:%02d", mmInt, ssInt];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end