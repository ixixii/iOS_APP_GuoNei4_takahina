//
//  TAAddAccountViewController.h
//  takahina
//
//  Created by beyond on 2020/03/30.
//  Copyright © 2020 beyond. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TAAddAccountViewController : UIViewController

@property (nonatomic,weak) IBOutlet UITextField *xib_ta_textField_account;
@property (nonatomic,weak) IBOutlet UITextField *xib_ta_textField_password;
@property (nonatomic,weak) IBOutlet UITextField *xib_ta_textField_type;
@property (nonatomic,weak) IBOutlet UITextField *xib_ta_textField_remark;
@property (nonatomic,weak) IBOutlet UITextField *xib_ta_textField_date;
@property (nonatomic,weak) IBOutlet UITextField *xib_ta_textField_family;

- (IBAction)btnTAFamilyClicked:(UIButton *)sender;
- (IBAction)addTABtnClicked:(UIButton *)sender;

@property (nonatomic,strong) NSDictionary *model;

@property (nonatomic,weak) IBOutlet UIButton *xib_ta_button_add;
@property (nonatomic,weak) IBOutlet UIButton *xib_ta_button_family;
@property (nonatomic,weak) IBOutlet UIImageView *xib_ta_imageView_arrow;

@property (nonatomic,weak) IBOutlet UIButton *xib_ta_button_mask;
@property (nonatomic,weak) IBOutlet UIPickerView *xib_ta_pickerView;
- (IBAction)taButtonMaskClicked:(UIButton *)sender;
@end

NS_ASSUME_NONNULL_END
