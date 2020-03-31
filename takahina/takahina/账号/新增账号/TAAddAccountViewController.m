//
//  TAAddAccountViewController.m
//  takahina
//
//  Created by beyond on 2020/03/30.
//  Copyright © 2020 beyond. All rights reserved.
//

#import "TAAddAccountViewController.h"
#import "CZPickerView.h"
#import "CXDatePickerView.h"
#import "MBProgressHUD+NJ.h"
@interface TAAddAccountViewController ()<CZPickerViewDelegate,CZPickerViewDataSource>
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
    CZPickerView *pickerr = [[CZPickerView alloc] initWithHeaderTitle:@"请选择账号所属家人"
                                                       cancelButtonTitle:@"取消"
                                                      confirmButtonTitle:@"确定"];
        pickerr.checkMarkNeedless = YES;
        pickerr.delegate = self;
        pickerr.dataSource = self;
        pickerr.tapBackgroundToDismiss = YES;
        [pickerr show];
}
#pragma mark - CZPickerView datasource 和 delegate
- (NSInteger)numberOfRowsInPickerView:(CZPickerView *)pickerView
{
    return _ta_familyArr.count;
}
- (NSString *)czpickerView:(CZPickerView *)pickerView titleForRow:(NSInteger)row
{
    return [_ta_familyArr[row] objectForKey:@"ta_relation"];
}
- (void)czpickerView:(CZPickerView *)pickerView
didConfirmWithItemAtRow:(NSInteger)row
{
    [pickerView setHidden:YES];
    _xib_ta_textField_family.text = [_ta_familyArr[row] objectForKey:@"ta_relation"];
}

#pragma mark - btn 事件
- (void)addTABtnClicked:(UIButton *)sender
{
    if(_xib_ta_textField_account.text.length == 0){
        [MBProgressHUD showError:@"账号不能为空"];
        return;
    }
    if(_xib_ta_textField_password.text.length == 0){
        [MBProgressHUD showError:@"密码不能为空"];
        return;
    }
    if(_xib_ta_textField_type.text.length == 0){
        [MBProgressHUD showError:@"账号类型不能为空"];
        return;
    }
    if(_xib_ta_textField_remark.text.length == 0){
        [MBProgressHUD showError:@"描述不能为空"];
        return;
    }
    if(_xib_ta_textField_family.text.length == 0){
        [MBProgressHUD showError:@"所属家人不能为空"];
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
    
    [MBProgressHUD showMessage:@"发送中..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        [MBProgressHUD showSuccess:@"添加账号成功"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    });
}

@end
