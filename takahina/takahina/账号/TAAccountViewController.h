//
//  TAAccountViewController.h
//  takahina
//
//  Created by beyond on 2020/03/29.
//  Copyright © 2020 beyond. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TAAccountViewController : UIViewController
@property (nonatomic,weak) IBOutlet UITabBarItem *ta_xib_tabBarItem;
- (IBAction)addTABtnClicked:(UIButton *)sender;
@end

NS_ASSUME_NONNULL_END
