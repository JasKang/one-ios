//
//  Util.h
//  wengweng
//
//  Created by JasKang on 15/3/20.
//  Copyright (c) 2015年 xnnye. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSString+Extension.h"
#import "UIView+Extension.h"
#import "UIImage+Extension.h"
#import "UITableView+Extension.h"
#import "NSData+Extension.h"
#import "NSDate+Extension.h"
#import "NSMutableArray+Extension.h"
#import "NSURL+Extension.h"

@interface Util : NSObject


/**
* 检查系统"照片"授权状态, 如果权限被关闭, 提示用户去隐私设置中打开.
*/
+ (BOOL)checkPhotoLibraryAuthorizationStatus;

/**
* 检查系统"相机"授权状态, 如果权限被关闭, 提示用户去隐私设置中打开.
*/
+ (BOOL)checkCameraAuthorizationStatus;


+ (double)distancePointsA:(CGPoint)first PointB:(CGPoint)second;

+ (int)getYear:(NSDate *)date;

+ (int)getMonth:(NSDate *)date;

+ (NSString *)getConstellation:(NSDate *)date;
@end
