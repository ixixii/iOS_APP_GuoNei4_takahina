//
//  TAPrivacyViewController.m
//  takahina
//
//  Created by beyond on 2020/03/29.
//  Copyright © 2020 beyond. All rights reserved.
//

#import "TAPrivacyViewController.h"

@interface TAPrivacyViewController ()<UIWebViewDelegate>

@end

@implementation TAPrivacyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.xib_ta_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://shimo.im/docs/6GPTwkV63cqCpqGv"] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5.2]];
    self.xib_ta_webView.delegate = self;
    [self.xib_ta_indicator startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.xib_ta_indicator removeFromSuperview];
}
- (IBAction)closeTAButtonClicked:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
