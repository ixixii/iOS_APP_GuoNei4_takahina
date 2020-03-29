//
//  TAFeedViewController.m
//  takahina
//
//  Created by beyond on 2020/03/29.
//  Copyright © 2020 beyond. All rights reserved.
//

#import "TAFeedViewController.h"

@interface TAFeedViewController ()

@end

@implementation TAFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"反馈意见";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
- (IBAction)ta_sendBtnClicked:(UIButton *)sender
{
    if(self.ta_xib_textView.text.length > 0 && ![self.ta_xib_textView.text isEqualToString:@"请输入你的意见或建议"]){
        [self.view endEditing:YES];
        [MBProgressHUD showMessage:@"发送中。。。"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
            [MBProgressHUD showSuccess:@"发送成功！"];
            __weak __typeof__(self) weakSelf = self;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.view endEditing:YES];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
        });
    }else{
        [MBProgressHUD showError:@"请输入内容后再发送"];
    }
}@end
