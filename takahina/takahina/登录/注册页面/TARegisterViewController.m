//
//  TARegisterViewController.m
//  takahina
//
//  Created by beyond on 2020/03/29.
//  Copyright © 2020 beyond. All rights reserved.
//

#import "TARegisterViewController.h"
#import "MBProgressHUD+NJ.h"

@interface TARegisterViewController ()

@end

@implementation TARegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)loginTAButtonClicked:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)privacyTAButtonClicked:(UIButton *)sender
{
    UIViewController *ctrl = [[NSClassFromString(@"TAPrivacyViewController") alloc] init];
    [self presentViewController:ctrl animated:YES completion:nil];
}
- (void)registerTAButtonClicked:(UIButton *)sender
{
    if(_xib_ta_textField_telephone.text.length == 0){
        [MBProgressHUD showError:@"手机号码不能为空"];
        return;
    }
    if(_xib_textField_ta_pwd.text.length == 0){
        [MBProgressHUD showError:@"注册密码不能为空"];
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:_xib_ta_textField_telephone.text forKey:@"userDefault_ta_telephone"];
    [[NSUserDefaults standardUserDefaults] setObject:_xib_textField_ta_pwd.text forKey:@"userDefault_ta_pwd"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [MBProgressHUD showMessage:@"请求中..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        [MBProgressHUD showSuccess:@"注册成功，请前往登录"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    });
}
@end
