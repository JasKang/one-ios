//
//  NSMutableArray+Extension.m
//  wengweng
//
//  Created by JasKang on 15/3/29.
//  Copyright (c) 2015年 xnye. All rights reserved.
//

@implementation NSMutableArray (Extension)

- (void)moveObjectFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    if (toIndex != fromIndex && fromIndex < [self count] && toIndex < [self count]) {
        id obj = [self objectAtIndex:fromIndex];
        [self removeObjectAtIndex:fromIndex];
        if (toIndex >= [self count]) {
            [self addObject:obj];
        } else {
            [self insertObject:obj atIndex:toIndex];
        }
    }
}

@end
