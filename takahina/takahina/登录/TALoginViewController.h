//
//  TALoginViewController.h
//  takahina
//
//  Created by beyond on 2020/03/29.
//  Copyright © 2020 beyond. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TALoginViewController : UIViewController
@property (nonatomic,weak) IBOutlet UITextField *xib_textField_ta_telephone;
@property (nonatomic,weak) IBOutlet UITextField *xib_textField_ta_pwd;

- (IBAction)regitsterTAButtonClicked:(UIButton *)sender;
- (IBAction)loginTAButtonClicked:(UIButton *)sender;
@end

NS_ASSUME_NONNULL_END
