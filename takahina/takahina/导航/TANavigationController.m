//
//  TANavigationController.m
//  takahina
//
//  Created by beyond on 2020/03/29.
//  Copyright © 2020 beyond. All rights reserved.
//

#import "TANavigationController.h"
@interface TANavigationController ()
@end

@implementation TANavigationController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationBar setBackgroundImage:[self ta_imageFromColor:ta_yellowColor] forBarMetrics:(UIBarMetricsDefault)];
    
    [self.navigationBar setTitleTextAttributes:
    @{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
      NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (UIImage *)ta_imageFromColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([NSStringFromClass([viewController class]) isEqualToString:@"TAMineViewController"] ) {
        viewController.hidesBottomBarWhenPushed = NO;
    }else{
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}
@end
