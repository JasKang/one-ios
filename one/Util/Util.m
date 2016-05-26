//
//  Util.m
//  wengweng
//
//  Created by JasKang on 15/3/20.
//  Copyright (c) 2015年 xnnye. All rights reserved.
//

#import "BlocksKit+UIKit.h"

@implementation Util

+ (BOOL)checkPhotoLibraryAuthorizationStatus {
    if ([ALAssetsLibrary respondsToSelector:@selector(authorizationStatus)]) {
        ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
        if (ALAuthorizationStatusDenied == authStatus ||
                ALAuthorizationStatusRestricted == authStatus) {
            [self showSettingAlertStr:@"请在iPhone的“设置->隐私->照片”中打开本应用的访问权限"];
            return NO;
        }
    }
    return YES;
}

+ (BOOL)checkCameraAuthorizationStatus {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        //        kTipAlert(@"该设备不支持拍照");
        return NO;
    }

    if ([AVCaptureDevice respondsToSelector:@selector(authorizationStatusForMediaType:)]) {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (AVAuthorizationStatusDenied == authStatus ||
                AVAuthorizationStatusRestricted == authStatus) {
            [self showSettingAlertStr:@"请在iPhone的“设置->隐私->相机”中打开本应用的访问权限"];
            return NO;
        }
    }

    return YES;
}

+ (void)showSettingAlertStr:(NSString *)tipStr {
    //iOS8+系统下可跳转到‘设置’页面，否则只弹出提示窗即可
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1) {
        UIAlertView *alertView = [UIAlertView bk_alertViewWithTitle:@"提示" message:tipStr];
        [alertView bk_setCancelButtonWithTitle:@"取消" handler:nil];
        [alertView bk_addButtonWithTitle:@"设置" handler:nil];
        [alertView bk_setDidDismissBlock:^(UIAlertView *alert, NSInteger index) {
            if (index == 1) {
                UIApplication *app = [UIApplication sharedApplication];
                NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([app canOpenURL:settingsURL]) {
                    [app openURL:settingsURL];
                }
            }
        }];
        [alertView show];
    } else {
        NSLog(@"%@", tipStr);
    }
}

+ (double)distancePointsA:(CGPoint)first PointB:(CGPoint)second {
    CGFloat deltaX = second.x - first.x;
    CGFloat deltaY = second.y - first.y;
    return sqrt(deltaX * deltaX + deltaY * deltaY);
}


+ (int)getYear:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    int year = (int) [comps year];
    return year;
}

+ (int)getMonth:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    int month = (int) [comps month];
    return month;
}

+ (NSString *)getConstellation:(NSDate *)date {
    //计算星座

    NSString *retStr = @"";
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM"];
    int i_month = 0;
    NSString *theMonth = [dateFormat stringFromDate:date];
    if ([[theMonth substringToIndex:0] isEqualToString:@"0"]) {
        i_month = [[theMonth substringFromIndex:1] intValue];
    } else {
        i_month = [theMonth intValue];
    }

    [dateFormat setDateFormat:@"dd"];
    int i_day = 0;
    NSString *theDay = [dateFormat stringFromDate:date];
    if ([[theDay substringToIndex:0] isEqualToString:@"0"]) {
        i_day = [[theDay substringFromIndex:1] intValue];
    } else {
        i_day = [theDay intValue];
    }
    /*
     摩羯座 12月22日------1月19日
     水瓶座 1月20日-------2月18日
     双鱼座 2月19日-------3月20日
     白羊座 3月21日-------4月19日
     金牛座 4月20日-------5月20日
     双子座 5月21日-------6月21日
     巨蟹座 6月22日-------7月22日
     狮子座 7月23日-------8月22日
     处女座 8月23日-------9月22日
     天秤座 9月23日------10月23日
     天蝎座 10月24日-----11月21日
     射手座 11月22日-----12月21日
     */
    switch (i_month) {
        case 1:
            if (i_day >= 20 && i_day <= 31) {
                retStr = @"水瓶座";
            }
            if (i_day >= 1 && i_day <= 19) {
                retStr = @"摩羯座";
            }
            break;
        case 2:
            if (i_day >= 1 && i_day <= 18) {
                retStr = @"水瓶座";
            }
            if (i_day >= 19 && i_day <= 31) {
                retStr = @"双鱼座";
            }
            break;
        case 3:
            if (i_day >= 1 && i_day <= 20) {
                retStr = @"双鱼座";
            }
            if (i_day >= 21 && i_day <= 31) {
                retStr = @"白羊座";
            }
            break;
        case 4:
            if (i_day >= 1 && i_day <= 19) {
                retStr = @"白羊座";
            }
            if (i_day >= 20 && i_day <= 31) {
                retStr = @"金牛座";
            }
            break;
        case 5:
            if (i_day >= 1 && i_day <= 20) {
                retStr = @"金牛座";
            }
            if (i_day >= 21 && i_day <= 31) {
                retStr = @"双子座";
            }
            break;
        case 6:
            if (i_day >= 1 && i_day <= 21) {
                retStr = @"双子座";
            }
            if (i_day >= 22 && i_day <= 31) {
                retStr = @"巨蟹座";
            }
            break;
        case 7:
            if (i_day >= 1 && i_day <= 22) {
                retStr = @"巨蟹座";
            }
            if (i_day >= 23 && i_day <= 31) {
                retStr = @"狮子座";
            }
            break;
        case 8:
            if (i_day >= 1 && i_day <= 22) {
                retStr = @"狮子座";
            }
            if (i_day >= 23 && i_day <= 31) {
                retStr = @"处女座";
            }
            break;
        case 9:
            if (i_day >= 1 && i_day <= 22) {
                retStr = @"处女座";
            }
            if (i_day >= 23 && i_day <= 31) {
                retStr = @"天秤座";
            }
            break;
        case 10:
            if (i_day >= 1 && i_day <= 23) {
                retStr = @"天秤座";
            }
            if (i_day >= 24 && i_day <= 31) {
                retStr = @"天蝎座";
            }
            break;
        case 11:
            if (i_day >= 1 && i_day <= 21) {
                retStr = @"天蝎座";
            }
            if (i_day >= 22 && i_day <= 31) {
                retStr = @"射手座";
            }
            break;
        case 12:
            if (i_day >= 1 && i_day <= 21) {
                retStr = @"射手座";
            }
            if (i_day >= 21 && i_day <= 31) {
                retStr = @"摩羯座";
            }
            break;
    }
    return retStr;
}

@end
