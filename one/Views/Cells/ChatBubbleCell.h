//
//  ChatBubbleCell.h
//  one
//
//  Created by JasKang on 15/5/29.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatBubbleCell : UITableViewCell

-(void)bindData:(ChatModel *)data obj_photo:(NSURL *)photo;

@end
