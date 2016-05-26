//
//  NSString+Extension.h
//  wengweng
//
//  Created by JasKang on 15/3/20.
//  Copyright (c) 2015年 xnnye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

- (NSString *)md5;

- (NSString *)sha1;

- (NSString *)urlEncode;

- (CGFloat)widthWithFont:(UIFont *)font;

- (CGFloat)heightWithFont:(UIFont *)font Width:(CGFloat)width;

-(id)JSONValue;

+ (NSString *)JSONStringWithObject:(id)object;

+ (NSString *)jsonStringWithString:(NSString *)string;

+ (NSString *)jsonStringWithArray:(NSArray *)array;

+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dictionary;

+ (NSString *)jsonStringWithObject:(id)object;

+ (NSString *)jsonStringWithObjectOriginal:(id)object;

+ (NSString *)timeFormatted:(NSInteger)totalSeconds;
@end
