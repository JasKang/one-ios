//
//  NSURL+Extension.m
//  wengweng
//
//  Created by JasKang on 15/4/18.
//  Copyright (c) 2015年 xnye. All rights reserved.
//

@implementation NSURL (Extension)

- (NSURL *)URLWithBlur {
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@!blur", self.absoluteString]];
}

- (NSURL *)URLWithX640 {
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@!x640", self.absoluteString]];
}

- (NSURL *)URLWithX86 {
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@!x86", self.absoluteString]];
}

- (NSURL *)URLWithx128 {
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@!x128", self.absoluteString]];
}
@end
