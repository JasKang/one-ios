//
// Created by JasKang on 15/6/17.
// Copyright (c) 2015 JasKang. All rights reserved.
//

#import "CallInController.h"
#import "ODBManager.h"

@interface CallInController () {
    int hhInt;
    int mmInt;
    int ssInt;
}

@property(nonatomic, strong) UserModel *user;

@property(nonatomic, strong) UIImageView *ivPhoto;
@property(nonatomic, strong) UILabel *ibtime;

@property(nonatomic, strong) UIButton *btnLeft;

@property(nonatomic, strong) UIButton *btnRight;

@property(nonatomic, strong) NSTimer *timer;

@property(nonatomic, strong) NSString *callId;
@property(nonatomic, strong) NSNumber *usersign;
@property(nonatomic, assign) enum ECallStatus status;
@end

@implementation CallInController

+ (instancetype)initWithCallId:(NSString *)callid userSign:(NSNumber *)usersign {
    CallInController *vc = [[CallInController alloc] init];
    vc.callId = callid;
    vc.usersign = usersign;
    vc.user = [[ODBManager instance] userWithUserSign:usersign];
    return vc;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    hhInt = 0;
    mmInt = 0;
    ssInt = 0;

    // Do any additional setup after loading the view.
    self.view = [[UIView alloc] initWithFrame:ScreenBounds];
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:ScreenBounds];
    [bgView setContentMode:UIViewContentModeScaleAspectFill];
    [bgView setBackgroundColor:[UIColor blackColor]];
    [bgView sd_setImageWithURL:_user.photo placeholderImage:[UIImage imageNamed:@"tou_normal"]];
    [self.view addSubview:bgView];

    self.ivPhoto = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth - 170) / 2, (CGFloat) (ScreenHeight * 0.22), 170, 170)];
    self.ivPhoto.layer.cornerRadius = 3.0;
    self.ivPhoto.layer.masksToBounds = YES;
    [self.ivPhoto sd_setImageWithURL:_user.photo placeholderImage:[UIImage imageNamed:@"tou_normal"]];
    [self.view addSubview:self.ivPhoto];

    UILabel *ibnickname = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth - 170) / 2, (CGFloat) (ScreenHeight * 0.1), 170, 21)];
    [ibnickname setText:_user.nick_name];
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
    [self.ibtime setText:@"等待接听..."];
    [self.ibtime setTextColor:[UIColor whiteColor]];
    [self.ibtime setFont:[UIFont systemFontOfSize:12]];
    [self.ibtime setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:self.ibtime];

    self.btnLeft = [[UIButton alloc] initWithFrame:CGRectMake((CGFloat) (ScreenWidth / 4 - 37.5), (CGFloat) (ScreenHeight * 0.78), 75, 75)];
    [self.btnLeft setImage:LoadImage(@"Call_Refuse_noraml") forState:UIControlStateNormal];
    [self.btnLeft setImage:LoadImage(@"Call_Refuse_pressed") forState:UIControlStateHighlighted];
    [self.btnLeft addTarget:self action:@selector(tapLeft) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnLeft];

    self.btnRight = [[UIButton alloc] initWithFrame:CGRectMake((CGFloat) (ScreenWidth - ScreenWidth / 4 - 37.5), (CGFloat) (ScreenHeight * 0.78), 75, 75)];
    [self.btnRight setImage:LoadImage(@"Call_Connect_normal") forState:UIControlStateNormal];
    [self.btnRight setImage:LoadImage(@"Call_Connect_pressed") forState:UIControlStateHighlighted];
    [self.btnRight addTarget:self action:@selector(tapRight) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnRight];

    [OVoipManager instance].uidelegate = self;
}

- (void)onCallEvents:(VoipCall *)voipCall {

    switch (voipCall.callStatus) {
        case ECallRing: {

        }
            break;
        case ECallStreaming: {

            [[ECDevice sharedInstance].voIPManager enableLoudsSpeaker:NO];

            self.ibtime.text = @"00:00";
            [self.btnRight setImage:LoadImage(@"Call_Handsfree_normal") forState:UIControlStateNormal];
            [self.btnRight setImage:LoadImage(@"Call_Handsfree_pressed") forState:UIControlStateHighlighted];
            if (![self.timer isValid]) {
                self.timer = [NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(updateRealtimeLabel) userInfo:nil repeats:YES];
                [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
                [self.timer fire];
            }
        }
            break;

        case ECallEnd: {
            [[OVoipManager instance] releaseCall:_callId];
            [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(backFront) userInfo:nil repeats:NO];
            break;
        }
            break;
        case ECallFailed: {
            //            [AppVoip.player stop];
            [[OVoipManager instance] releaseCall:_callId];
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
    if (_status == ECallStreaming) {
        if ([[OVoipManager instance] getLoudsSpeakerStatus]) {
            [[OVoipManager instance] enableLoudsSpeaker:NO];
            [self.btnRight setImage:LoadImage(@"Call_Handsfree_normal") forState:UIControlStateNormal];
            [self.btnRight setImage:LoadImage(@"Call_Handsfree_pressed") forState:UIControlStateHighlighted];
        } else {
            [[OVoipManager instance] enableLoudsSpeaker:YES];
            [self.btnRight setImage:LoadImage(@"Call_Handsfree_pressed") forState:UIControlStateNormal];
            [self.btnRight setImage:LoadImage(@"Call_Handsfree_normal") forState:UIControlStateHighlighted];
        }
    } else {
        [[OVoipManager instance] acceptCall:_callId];
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