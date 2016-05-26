//
//  NSData+Extension.m
//  wengweng
//
//  Created by JasKang on 15/3/21.
//  Copyright (c) 2015年 xnnye. All rights reserved.
//

@implementation NSData (Extension)


+ (NSData *)MD5Digest:(NSData *)input {
    unsigned char result[CC_MD5_DIGEST_LENGTH];

    CC_MD5(input.bytes, (CC_LONG) input.length, result);
    return [[NSData alloc] initWithBytes:result length:CC_MD5_DIGEST_LENGTH];
}

- (NSData *)MD5Digest {
    return [NSData MD5Digest:self];
}

+ (NSString *)MD5HexDigest:(NSData *)input {
    unsigned char result[CC_MD5_DIGEST_LENGTH];

    CC_MD5(input.bytes, (CC_LONG) input.length, result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x", result[i]];
    }
    return ret;
}

- (NSString *)MD5HexDigest {
    return [NSData MD5HexDigest:self];
}

- (NSString *)detectImageSuffix {
    uint8_t c;
    NSString *imageFormat = @"";
    [self getBytes:&c length:1];

    switch (c) {
        case 0xFF:
            imageFormat = @".jpg";
            break;
        case 0x89:
            imageFormat = @".png";
            break;
        case 0x47:
            imageFormat = @".gif";
            break;
        case 0x49:
        case 0x4D:
            imageFormat = @".tiff";
            break;
        case 0x42:
            imageFormat = @".bmp";
            break;
        default:
            break;
    }
    return imageFormat;
}

@end

