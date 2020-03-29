//
//  TARegisterViewController.h
//  takahina
//
//  Created by beyond on 2020/03/29.
//  Copyright © 2020 beyond. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TARegisterViewController : UIViewController

@property (nonatomic,weak) IBOutlet UITextField *xib_ta_textField_telephone;
@property (nonatomic,weak) IBOutlet UITextField *xib_textField_ta_pwd;
- (IBAction)loginTAButtonClicked:(UIButton *)sender;
- (IBAction)privacyTAButtonClicked:(UIButton *)sender;
- (IBAction)registerTAButtonClicked:(UIButton *)sender;
@end

NS_ASSUME_NONNULL_END
