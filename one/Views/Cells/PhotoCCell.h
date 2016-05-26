//
//  PhotoCCell.h
//  one
//
//  Created by JasKang on 15/5/27.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCCell : UICollectionViewCell

- (void)configWithUrl:(NSURL *)url;
- (void)configWithImage:(NSString *)imagename;

@end
