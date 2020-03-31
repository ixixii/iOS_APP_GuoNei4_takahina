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
    return [[NSBundle mainBundle]loadNibNamed:@"TAMineHeadView" owner:nil options:nil][0];
}
@end
