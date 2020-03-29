//
//  TAFeedViewController.h
//  takahina
//
//  Created by beyond on 2020/03/29.
//  Copyright © 2020 beyond. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TAFeedViewController : UIViewController
@property (nonatomic,weak) IBOutlet UITextView *ta_xib_textView;
- (IBAction)ta_sendBtnClicked:(UIButton *)sender;
@end

NS_ASSUME_NONNULL_END
