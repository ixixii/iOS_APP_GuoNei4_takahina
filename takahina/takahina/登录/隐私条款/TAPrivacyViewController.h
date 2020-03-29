//
//  TAPrivacyViewController.h
//  takahina
//
//  Created by beyond on 2020/03/29.
//  Copyright © 2020 beyond. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TAPrivacyViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *xib_ta_webView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *xib_ta_indicator;

- (IBAction)closeTAButtonClicked:(UIButton *)sender;
@end

NS_ASSUME_NONNULL_END
