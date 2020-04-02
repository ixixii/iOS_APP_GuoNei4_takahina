//
//  TATool.m
//  takahina
//
//  Created by beyond on 2020/04/02.
//  Copyright © 2020 beyond. All rights reserved.
//

#import "TAMessageTool.h"

typedef NS_ENUM(NSInteger, TAMessagePositionY){
  TAMessagePositionY_top = 0,
  TAMessagePositionY_center,
  TAMessagePositionY_bottom
};

@implementation TAMessageTool
#pragma mark - 工具方法
+(void)showTAMessage:(NSString *)message
{
    [TAMessageTool showTAMessage:message duration:3];
}
+(void)showTAMessage:(NSString *)message duration:(NSInteger)duration
{
    [TAMessageTool showTAMessage:message duration:duration positionY:TAMessagePositionY_center];
}
+(void)showTAMessage:(NSString *)message duration:(NSInteger)duration positionY:(NSInteger)positionY
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = [UIColor blackColor];
    showview.frame = CGRectMake(1, 1, 1, 1);
    showview.alpha = 1.0f;
    showview.layer.cornerRadius = 5.0f;
    showview.layer.masksToBounds = YES;
    [window addSubview:showview];
    
    UILabel *label = [[UILabel alloc]init];
    CGSize LabelSize = [message sizeWithFont:[UIFont systemFontOfSize:22] constrainedToSize:CGSizeMake(290, 9000)];
    label.frame = CGRectMake(10, 5, LabelSize.width, LabelSize.height);
    label.text = message;
    label.numberOfLines = 0;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20];
    [showview addSubview:label];
    NSInteger messageX = (ta_ScreenWidth - LabelSize.width - 20)/2;
    NSInteger messageY = 0;
    switch (positionY) {
        case TAMessagePositionY_top:
            {
                messageY = 100;
            }
            break;
        case TAMessagePositionY_center:
        {
            messageY = ta_ScreenHeight/2 - LabelSize.height/2;
        }
            break;
        case TAMessagePositionY_bottom:
        {
            messageY = ta_ScreenHeight - 100;
        }
            break;
            
        default:
            break;
    }
    
    showview.frame = CGRectMake(messageX, messageY, LabelSize.width+20, LabelSize.height+10);
    [UIView animateWithDuration:duration animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];
}
@end
