//
//  MessageCell.m
//  one
//
//  Created by JasKang on 15/5/29.
//  Copyright (c) 2015年 JasKang. All rights reserved.
//

#import "ChatBubbleCell.h"

@interface ChatBubbleCell ()

@property(nonatomic, strong) UILabel *lbTime;
@property(nonatomic, strong) UIButton *LBubble;
@property(nonatomic, strong) UIButton *RBubble;
@property(nonatomic, strong) UIImageView *LPhoto;
@property(nonatomic, strong) UIImageView *RPhoto;
@property(nonatomic, strong) UIView *Lshadow;
@property(nonatomic, strong) UIView *Rshadow;

@end
 
@implementation ChatBubbleCell

- (void)awakeFromNib {
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundView = nil;
        self.backgroundColor = [UIColor clearColor];

        
        if (!_lbTime) {
            _lbTime = [[UILabel alloc] initWithFrame:CGRectZero];
            _lbTime.backgroundColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:0.3];
            _lbTime.textColor = GetUIColor(0x333333);
            _lbTime.textAlignment = NSTextAlignmentCenter;
            _lbTime.font = [UIFont systemFontOfSize:12];
            _lbTime.layer.cornerRadius = 2;
            _lbTime.layer.masksToBounds = YES;
            [self.contentView addSubview:_lbTime];
        }

        if (!_LPhoto) {
            _LPhoto = [[UIImageView alloc] initWithFrame:CGRectZero];
            _LPhoto.layer.cornerRadius = 4.f;
            _LPhoto.layer.masksToBounds = YES;
            _LPhoto.hidden=YES;
            [self.contentView addSubview:_LPhoto];
        }
        if (!_RPhoto) {
            _RPhoto = [[UIImageView alloc] initWithFrame:CGRectZero];
            _RPhoto.layer.cornerRadius = 4.f;
            _RPhoto.layer.masksToBounds = YES;
            _RPhoto.hidden=YES;
            _Rshadow= [[UIView alloc] initWithFrame:CGRectZero];
            _Rshadow.layer.shadowColor = [UIColor blackColor].CGColor;//阴影颜色
            _Rshadow.layer.shadowOffset = CGSizeMake(2,2);//偏移距离
            _Rshadow.layer.shadowOpacity = 0.5;//不透明度
            _Rshadow.layer.shadowRadius = 4.f;//半径
            [self.contentView addSubview:_Rshadow];
            [self.contentView addSubview:_RPhoto];
        }
        
        if (!_LBubble) {
            _LBubble = [UIButton buttonWithType:UIButtonTypeCustom];
            _LBubble.titleLabel.numberOfLines = 0;
            _LBubble.titleLabel.font = [UIFont systemFontOfSize:14];
            _LBubble.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [_LBubble setBackgroundImage:[LoadImage(@"left_Bubble") imageInsets:UIEdgeInsetsMake(35.f, 18.f, 7.f, 7.f)] forState:UIControlStateNormal];
            [_LBubble setContentEdgeInsets:UIEdgeInsetsMake(0.f, 20.f, 0.f, 10.f)];
            _LBubble.hidden=YES;
            [self.contentView addSubview:_LBubble];
        }
        if (!_RBubble) {
            _RBubble = [UIButton buttonWithType:UIButtonTypeCustom];
            _RBubble.titleLabel.numberOfLines = 0;
            _RBubble.titleLabel.font = [UIFont systemFontOfSize:14];
            _RBubble.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [_RBubble setBackgroundImage:[LoadImage(@"right_Bubble") imageInsets:UIEdgeInsetsMake(35.f, 7.f, 7.f, 18.f)] forState:UIControlStateNormal];
            [_RBubble setContentEdgeInsets:UIEdgeInsetsMake(0.f, 10.f, 0.f,20.f)];
            _RBubble.hidden=YES;
            [self.contentView addSubview:_RBubble];
        }
        
        
    }
    return self;
}

-(void)bindData:(ChatModel *)data obj_photo:(NSURL *)photo{
    CGFloat topmargin=data.showtime? 30.0f:0.0f;
    NSString *time=[[NSDate dateWithTimeIntervalSince1970:data.time] chatTime];
    [_lbTime setText:time];
    if (data.showtime) {
        [_lbTime setFrame:CGRectMake((ScreenWidth-100)/2, 5, 100, 25)];
    }else{
        [_lbTime setFrame:CGRectZero];
    }
    if ([data.action_usersign isEqualToNumber:[AppDel localUser].usersign]) {
        [_LPhoto setHidden:YES];
        [_LBubble setHidden:YES];
        
        [_RPhoto setHidden:NO];
        [_RBubble setHidden:NO];
        [_RPhoto setFrame:CGRectMake(ScreenWidth-12-45, 5+topmargin, 45, 45)];
        [_Rshadow setFrame:CGRectMake(ScreenWidth-12-45, 5+topmargin, 45, 45)];
        [_RPhoto sd_setImageWithURL:[AppDel localUser].photo placeholderImage:[UIImage imageNamed:@"tou_normal"]];
        
        
        if (data.type==ChatTypeEnumText) {
            [_RBubble setImage:nil forState:UIControlStateNormal];
            [_RBubble setTitle:data.message forState:UIControlStateNormal];
            [_RBubble setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else if (data.type==ChatTypeEnumCall){
            if (data.status==ChatCallStatusEnumFail) {
                [_RBubble setImage:[UIImage imageNamed:@"Chat_right_Missed"] forState:UIControlStateNormal];
                [_RBubble setTitle:data.message forState:UIControlStateNormal];
                [_RBubble setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }else if (data.status==ChatCallStatusEnumStream) {
                [_RBubble setImage:[UIImage imageNamed:@"Chat_Already_call"] forState:UIControlStateNormal];
                [_RBubble setTitle:data.message forState:UIControlStateNormal];
                [_RBubble setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }else{
                
            }
        }else{
            
        }
        [_RBubble setFrame:CGRectMake(ScreenWidth - data.bubblewidth - 12 - 45, 5+topmargin, data.bubblewidth, data.bubbleheight)];
    }else{
        [_RPhoto setHidden:YES];
        [_Rshadow setHidden:YES];
        [_RBubble setHidden:YES];
        
        [_LPhoto setHidden:NO];
        [_LBubble setHidden:NO];
        [_LPhoto setFrame:CGRectMake(12, 5+topmargin, 45, 45)];
        
        [_LPhoto sd_setImageWithURL:photo placeholderImage:[UIImage imageNamed:@"tou_normal"]];
        
        if (data.type==ChatTypeEnumText) {
            [_LBubble setImage:nil forState:UIControlStateNormal];
            [_LBubble setTitle:data.message forState:UIControlStateNormal];
            [_LBubble setTitleColor:GetUIColor(0x333333) forState:UIControlStateNormal];
        }else if (data.type==ChatTypeEnumCall){
            if (data.status==ChatCallStatusEnumFail) {
                [_LBubble setImage:[UIImage imageNamed:@"Chat_left_Missed"] forState:UIControlStateNormal];
                [_LBubble setTitle:data.message forState:UIControlStateNormal];
                [_LBubble setTitleColor:GetUIColor(0xf32b2b) forState:UIControlStateNormal];
            }else if (data.status==ChatCallStatusEnumStream) {
                [_LBubble setImage:[UIImage imageNamed:@"Chat_Already_call"] forState:UIControlStateNormal];
                [_LBubble setTitle:data.message forState:UIControlStateNormal];
                [_LBubble setTitleColor:GetUIColor(0x333333) forState:UIControlStateNormal];

            }else{
                
            }
        }else{
            
        }
        [_LBubble setFrame:CGRectMake(12+45, 5+topmargin, data.bubblewidth, data.bubbleheight)];
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
