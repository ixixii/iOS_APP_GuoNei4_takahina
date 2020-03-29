//
//  TATextField.m
//  takahina
//
//  Created by beyond on 2020/03/29.
//  Copyright © 2020 beyond. All rights reserved.
//

#import "TATextField.h"

@implementation TATextField
- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += 15; //像右边偏15
    return iconRect;
}
- (CGRect)textRectForBounds:(CGRect)bounds{
    return CGRectInset(bounds, 45, 0);
}
- (CGRect)editingRectForBounds:(CGRect)bounds{
    return CGRectInset(bounds, 45, 0);
}
@end
