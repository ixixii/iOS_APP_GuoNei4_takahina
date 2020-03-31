//
//  TAFamilyHeadView.m
//  takahina
//
//  Created by beyond on 2020/03/29.
//  Copyright © 2020 beyond. All rights reserved.
//

#import "TAFamilyHeadView.h"

@implementation TAFamilyHeadView
+ (instancetype)taFamilyHeadView
{
    return [[NSBundle mainBundle]loadNibNamed:@"TAFamilyHeadView" owner:nil options:nil][0];
}
@end
