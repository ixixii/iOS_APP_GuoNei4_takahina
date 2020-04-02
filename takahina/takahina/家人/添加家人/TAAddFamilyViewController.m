//
//  TAAddFamilyViewController.m
//  takahina
//
//  Created by beyond on 2020/03/29.
//  Copyright © 2020 beyond. All rights reserved.
//

#import "TAAddFamilyViewController.h"
@interface TAAddFamilyViewController ()

@end

@implementation TAAddFamilyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加家人";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
- (void)addTAFamilyBtnClicked:(UIButton *)sender
{
    if(_xib_ta_textField_relation.text.length == 0){
        [TAMessageTool showTAMessage:@"请输入家人关系"];
        return;
    }
    if(_xib_ta_textField_interest.text.length == 0){
        [TAMessageTool showTAMessage:@"请输入账号热点"];
        return;
    }
    if(_xib_ta_textField_description.text.length == 0){
        [TAMessageTool showTAMessage:@"请输入家人描述"];
        return;
    }
    NSArray *taFamilyArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDefault_ta_familyArr"];
    NSDictionary *newTAFamily = @{
        @"ta_relation": _xib_ta_textField_relation.text,
        @"ta_interest": _xib_ta_textField_interest.text,
        @"ta_description": _xib_ta_textField_description.text
    };
    NSMutableArray *mTAArr = [NSMutableArray arrayWithArray:taFamilyArr];
    [mTAArr addObject:newTAFamily];
    [[NSUserDefaults standardUserDefaults] setObject:mTAArr forKey:@"userDefault_ta_familyArr"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.view endEditing:YES];
    [TAMessageTool showTAMessage:@"发送中..." duration:3];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [TAMessageTool showTAMessage:@"添加成功" duration:3];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    });
}
@end
