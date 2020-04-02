//
//  TALoginViewController.m
//  takahina
//
//  Created by beyond on 2020/03/29.
//  Copyright © 2020 beyond. All rights reserved.
//

#import "TALoginViewController.h"

@interface TALoginViewController ()

@end

@implementation TALoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)regitsterTAButtonClicked:(UIButton *)sender
{
    [self presentViewController:[[NSClassFromString(@"TARegisterViewController") alloc]init] animated:YES completion:^{
    }];
}
- (void)loginTAButtonClicked:(UIButton *)sender
{
    [self.view endEditing:YES];
    if(_xib_textField_ta_telephone.text.length == 0){
        [TAMessageTool showTAMessage:@"请输入手机号码"];
        return;
    }
    if(_xib_textField_ta_pwd.text.length == 0){
        [TAMessageTool showTAMessage:@"请输入登陆密码"];
        return;
    }
    if([_xib_textField_ta_telephone.text isEqualToString:@"mathilda"] && [_xib_textField_ta_pwd.text isEqualToString:@"123456"]){
        [[NSUserDefaults standardUserDefaults] setObject:@"mathilda" forKey:@"userDefault_ta_telephone"];
        [[NSUserDefaults standardUserDefaults] setObject:@"123456" forKey:@"userDefault_ta_pwd"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if(![_xib_textField_ta_telephone.text isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"userDefault_ta_telephone"]] || ![_xib_textField_ta_pwd.text isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"userDefault_ta_pwd"]]){
        [TAMessageTool showTAMessage:@"手机号码或者登录密码不正确"];
        return;
    }
    [TAMessageTool showTAMessage:@"发送中..." duration:3];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [TAMessageTool showTAMessage:@"登录成功！" duration:3];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"userDefault_ta_isLogin"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    });
}
@end
