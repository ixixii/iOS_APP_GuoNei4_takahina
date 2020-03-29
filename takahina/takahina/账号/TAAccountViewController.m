//
//  TAAccountViewController.m
//  takahina
//
//  Created by beyond on 2020/03/29.
//  Copyright © 2020 beyond. All rights reserved.
//

#import "TAAccountViewController.h"

@interface TAAccountViewController ()

@end

@implementation TAAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ta_resetTabBarItemTextColor];
}

- (void)ta_resetTabBarItemTextColor
{
    [self.ta_xib_tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObject:ta_yellowColor forKey:NSForegroundColorAttributeName] forState:UIControlStateSelected];
}

@end
