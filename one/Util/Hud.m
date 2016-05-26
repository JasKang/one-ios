//
//  Hud.m
//  wengweng
//
//  Created by JasKang on 15/3/21.
//  Copyright (c) 2015年 xnnye. All rights reserved.
//

@implementation Hud


+ (void)showText:(NSString *)text InView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:NO];
    hud.mode = MBProgressHUDModeText;
    hud.userInteractionEnabled = NO;
    hud.labelText = text;
    hud.margin = 15;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.5f];
}

+ (void)showInView:(UIView *)view {
    [MBProgressHUD showHUDAddedTo:view animated:NO];
}

+ (void)hideInView:(UIView *)view {
    [MBProgressHUD hideAllHUDsForView:view animated:NO];
}

+ (void)show {
    [MBProgressHUD showHUDAddedTo:KeyWindow animated:NO];
}

+ (void)showText:(NSString *)text {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:KeyWindow animated:NO];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.margin = 15;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.5f];
}

+ (void)hide {
    [MBProgressHUD hideAllHUDsForView:KeyWindow animated:NO];
}


@end
