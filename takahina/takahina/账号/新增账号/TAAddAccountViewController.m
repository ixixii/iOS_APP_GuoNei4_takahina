//
//  TAAddAccountViewController.m
//  takahina
//
//  Created by beyond on 2020/03/30.
//  Copyright © 2020 beyond. All rights reserved.
//

#import "TAAddAccountViewController.h"
@interface TAAddAccountViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSArray *_ta_familyArr;
}
@end

@implementation TAAddAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加账号";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    _ta_familyArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDefault_ta_familyArr"];
    
    // 数据回显
    if(_model){
        self.title = @"账号详情";
        _xib_ta_textField_account.text = _model[@"ta_account"];
        _xib_ta_textField_password.text = _model[@"ta_password"];
        _xib_ta_textField_type.text = _model[@"ta_type"];
        _xib_ta_textField_remark.text = _model[@"ta_remark"];
        _xib_ta_textField_date.text = _model[@"ta_date"];
        _xib_ta_textField_family.text = _model[@"ta_family"];
        
        _xib_ta_button_add.hidden = YES;
        _xib_ta_button_family.userInteractionEnabled = NO;
        _xib_ta_imageView_arrow.hidden = YES;
        
        _xib_ta_textField_account.userInteractionEnabled = NO;
        _xib_ta_textField_password.userInteractionEnabled = NO;
        _xib_ta_textField_type.userInteractionEnabled = NO;
        _xib_ta_textField_remark.userInteractionEnabled = NO;
        _xib_ta_textField_date.userInteractionEnabled = NO;
    }
}

#pragma mark - 按钮事件
- (void)btnTAFamilyClicked:(UIButton *)sender
{
    [self.view endEditing:YES];
    _xib_ta_pickerView.hidden = NO;
    _xib_ta_button_mask.hidden = NO;
}
#pragma mark - pickerView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _ta_familyArr.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_ta_familyArr[row] objectForKey:@"ta_relation"];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [pickerView setHidden:YES];
    _xib_ta_button_mask.hidden = YES;
    _xib_ta_textField_family.text = [_ta_familyArr[row] objectForKey:@"ta_relation"];
}
- (void)taButtonMaskClicked:(UIButton *)sender
{
    sender.hidden = YES;
    _xib_ta_pickerView.hidden = YES;
}
#pragma mark - btn 事件
- (void)addTABtnClicked:(UIButton *)sender
{
    if(_xib_ta_textField_account.text.length == 0){
        [TAMessageTool showTAMessage:@"账号不能为空"];
        return;
    }
    if(_xib_ta_textField_password.text.length == 0){
        [TAMessageTool showTAMessage:@"密码不能为空"];
        return;
    }
    if(_xib_ta_textField_type.text.length == 0){
        [TAMessageTool showTAMessage:@"账号类型不能为空"];
        return;
    }
    if(_xib_ta_textField_remark.text.length == 0){
        [TAMessageTool showTAMessage:@"描述不能为空"];
        return;
    }
    if(_xib_ta_textField_date.text.length == 0){
        [TAMessageTool showTAMessage:@"创建时间不能为空"];
        return;
    }
    if(_xib_ta_textField_family.text.length == 0){
        [TAMessageTool showTAMessage:@"所属家人不能为空"];
        return;
    }
    
    NSString *tmpRemarker = _xib_ta_textField_remark.text;
    if(_xib_ta_textField_remark.text.length == 0){
        tmpRemarker = @"---";
    }
    NSArray *accountArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDefault_ta_accountArr"];
    NSDictionary *newTAAccount = @{
        @"ta_account": _xib_ta_textField_account.text,
        @"ta_password": _xib_ta_textField_password.text,
        @"ta_type": _xib_ta_textField_type.text,
        @"ta_remark": tmpRemarker,
        @"ta_date": _xib_ta_textField_date.text,
        @"ta_family": _xib_ta_textField_family.text
    };
    NSMutableArray *mTAArr = [NSMutableArray arrayWithArray:accountArr];
    [mTAArr addObject:newTAAccount];
    [[NSUserDefaults standardUserDefaults] setObject:mTAArr forKey:@"userDefault_ta_accountArr"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.view endEditing:YES];
    [TAMessageTool showTAMessage:@"发送中..." duration:3];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [TAMessageTool showTAMessage:@"添加账号成功" duration:3];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    });
}

@end
