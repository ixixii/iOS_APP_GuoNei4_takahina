//
//  TAMineHeadView.m
//  takahina
//
//  Created by beyond on 2020/03/29.
//  Copyright © 2020 beyond. All rights reserved.
//

#import "TAMineHeadView.h"

@implementation TAMineHeadView
+ (instancetype)taMineHeadView
{
    NSArray *tmpArr = [[NSBundle mainBundle]loadNibNamed:@"TAMineHeadView" owner:nil options:nil];
    return tmpArr[0];
}
@end
