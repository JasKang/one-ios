//
// Created by JasKang on 15/6/23.
// Copyright (c) 2015 JasKang. All rights reserved.
//

#import "ChatModel.h"

@interface ChatModel ()

@end

@implementation ChatModel


+ (NSArray *)ignoredPropertyNames {
    return @[@"target_usersign",@"local_usersign",@"showtime",@"cellheight",@"bubblewidth",@"bubbleheight"];
}

- (void) setUsersign:(NSNumber *)usersign andToptime:(NSInteger)toptime{
    if (toptime==0) {
        self.showtime=YES;
    }else{
        self.showtime= [[NSDate dateWithTimeIntervalSince1970:self.time] timeDifferenceWith:[NSDate dateWithTimeIntervalSince1970:toptime]]>10*60;
    }

    if (self.type==ChatTypeEnumText) {

        CGFloat bubbleheight=[self.message heightWithFont:[UIFont systemFontOfSize:14] Width:ScreenWidth-125];

        CGFloat bubblewidth=[self.message widthWithFont:[UIFont systemFontOfSize:14]];


        bubbleheight= bubbleheight< 45 ? 45.f:bubbleheight;
        if (self.showtime) {
            self.cellheight = (bubbleheight+30+12.5f);
        }else{
            self.cellheight = bubbleheight+12.5f;
        }

        if (bubblewidth>(ScreenWidth-125)) {
            self.bubbleheight = bubbleheight;
            self.bubblewidth  = ScreenWidth-125+37;
        }else{
            self.bubbleheight = 44.5;
            self.bubblewidth  = bubblewidth+37;
        }


    }else{
        if (self.status==ChatCallStatusEnumFail) {
            self.message=@"未接通";
        }else{
            self.message=[NSString stringWithFormat:@"通话时间 %@",[NSString timeFormatted:self.duration]];
        }

        if (self.showtime) {
            self.cellheight = 45+30+12.5;
        }else{
            self.cellheight = 45+12.5;
        }

        if (self.status==ChatCallStatusEnumFail) {
            self.bubbleheight = 44.5;
            self.bubblewidth  = 124;
        }
        if (self.status==ChatCallStatusEnumStream) {
            if([NSString timeFormatted:self.duration].length>5){
                self.bubbleheight = 44.5;
                self.bubblewidth  = 185;
            }else{
                self.bubbleheight = 44.5;
                self.bubblewidth  = 170;
            }
        }
    }
}
//
//- (void)keyValuesDidFinishConvertingToObject {

//}

@end