//
//  NSString+Extension.m
//  wengweng
//
//  Created by JasKang on 15/3/20.
//  Copyright (c) 2015年 xnnye. All rights reserved.
//


@implementation NSString (Extension)

- (NSString *)md5 {
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG) strlen(cStr), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x", result[i]];
    }
    return hash;
}

- (NSString *)sha1 {
    const char *cStr = [self UTF8String];
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(cStr, (CC_LONG) strlen(cStr), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x", result[i]];
    }
    return hash;
}


/**
*  URLEncode
*  @return url编码字符串
*/
- (NSString *)urlEncode {
    //!  @  $  &  (  )  =  +  ~  `  ;  '  :  ,  /  ?
    //%21%40%24%26%28%29%3D%2B%7E%60%3B%27%3A%2C%2F%3F
    NSArray *escapeChars = @[@";", @"/", @"?", @":",
            @"@", @"&", @"=", @"+", @"$", @",",
            @"!", @"'", @"(", @")", @"*"];

    NSArray *replaceChars = @[@"%3B", @"%2F", @"%3F", @"%3A",
            @"%40", @"%26", @"%3D", @"%2B", @"%24", @"%2C",
            @"%21", @"%27", @"%28", @"%29", @"%2A"];

    int len = (int) [escapeChars count];

    NSMutableString *temp = [[self
            stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
            mutableCopy];

    int i;
    for (i = 0; i < len; i++) {

        [temp replaceOccurrencesOfString:escapeChars[i]
                              withString:replaceChars[i]
                                 options:NSLiteralSearch
                                   range:NSMakeRange(0, [temp length])];
    }

    NSString *outStr = [NSString stringWithString:temp];

    return outStr;
}

- (CGFloat)widthWithFont:(UIFont *)font {
    return [self sizeWithAttributes:@{NSFontAttributeName : font}].width;
}

- (CGFloat)heightWithFont:(UIFont *)font Width:(CGFloat)width {
    //设置一个行高上限
    CGSize titleSize = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
    return titleSize.height;
}




-(id)JSONValue;
{
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

+ (NSString *)JSONStringWithObject:(id)object;
{
    NSError* error = nil;
    NSData *result = [NSJSONSerialization dataWithJSONObject:object options:kNilOptions error:&error];
    if (error != nil) return nil;
    NSString *json= [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    return json;
}


+ (NSString *)jsonStringWithString:(NSString *)string {
    return [NSString stringWithFormat:@"\"%@\"",
                                      [[string stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"] stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""]
    ];
}

+ (NSString *)jsonStringWithArray:(NSArray *)array {
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"["];
    NSMutableArray *values = [NSMutableArray array];
    for (id valueObj in array) {
        NSString *value = [NSString jsonStringWithObject:valueObj];
        if (value) {
            [values addObject:[NSString stringWithFormat:@"%@", value]];
        }
    }
    [reString appendFormat:@"%@", [values componentsJoinedByString:@","]];
    [reString appendString:@"]"];
    return reString;
}

+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dictionary {
    NSArray *keys = [dictionary allKeys];
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"{"];
    NSMutableArray *keyValues = [NSMutableArray array];
    for (int i = 0; i < [keys count]; i++) {
        NSString *name = keys[i];
        id valueObj = dictionary[name];
        NSString *value = [NSString jsonStringWithObject:valueObj];
        if (value) {
            [keyValues addObject:[NSString stringWithFormat:@"\"%@\":%@", name, value]];
        }
    }
    [reString appendFormat:@"%@", [keyValues componentsJoinedByString:@","]];
    [reString appendString:@"}"];
    return reString;
}

+ (NSString *)jsonStringWithObject:(id)object {
    NSString *value = nil;
    if (!object) {
        return value;
    }
    if ([object isKindOfClass:[NSString class]]) {
        value = [NSString jsonStringWithString:object];
    } else if ([object isKindOfClass:[NSDictionary class]]) {
        value = [NSString jsonStringWithDictionary:object];
    } else if ([object isKindOfClass:[NSArray class]]) {
        value = [NSString jsonStringWithArray:object];
    }
    return value;
}

+ (NSString *)jsonStringWithObjectOriginal:(id)object {
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (!jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

+ (NSString *)timeFormatted:(NSInteger)totalSeconds {

    long seconds = totalSeconds % 60;
    long minutes = (totalSeconds / 60) % 60;
    long hours = totalSeconds / 3600;
    if (hours > 0) {
        return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", hours, minutes, seconds];
    } else {
        return [NSString stringWithFormat:@"%02ld:%02ld", minutes, seconds];
        //        return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",hours, minutes,seconds];
    }

}
@end