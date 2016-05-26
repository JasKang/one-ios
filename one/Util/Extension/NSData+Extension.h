//
//  NSData+Extension.h
//  wengweng
//
//  Created by JasKang on 15/3/21.
//  Copyright (c) 2015年 xnnye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Extension)

+ (NSData *)MD5Digest:(NSData *)input;

- (NSData *)MD5Digest;

+ (NSString *)MD5HexDigest:(NSData *)input;

- (NSString *)MD5HexDigest;

- (NSString *)detectImageSuffix;

@end
