//
//  TAAddFamilyViewController.h
//  takahina
//
//  Created by beyond on 2020/03/29.
//  Copyright © 2020 beyond. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TAAddFamilyViewController : UIViewController
@property (nonatomic,weak) IBOutlet UITextField *xib_ta_textField_relation;
@property (nonatomic,weak) IBOutlet UITextField *xib_ta_textField_interest;
@property (nonatomic,weak) IBOutlet UITextField *xib_ta_textField_description;

- (IBAction)addTAFamilyBtnClicked:(UIButton *)sender;
@end

NS_ASSUME_NONNULL_END
