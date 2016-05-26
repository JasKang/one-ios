//
//  UITableView+Extension.h
//  wengweng
//
//  Created by JasKang on 15/3/20.
//  Copyright (c) 2015年 xnnye. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UITableView (Extension)

- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
        withLeftSpace:(CGFloat)leftSpace;

- (void)reloadDataAtSection:(NSInteger)section AtRow:(NSInteger)row;

@end