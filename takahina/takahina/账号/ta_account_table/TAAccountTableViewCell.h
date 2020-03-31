//
//  TAAccountTableViewCell.h
//  takahina
//
//  Created by beyond on 2020/03/30.
//  Copyright © 2020 beyond. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TAAccountTableViewCell : UITableViewCell
+ (instancetype)taTableViewCell;
@property (nonatomic,weak) IBOutlet UILabel *xib_ta_label_account;
@property (nonatomic,weak) IBOutlet UILabel *xib_ta_label_password;
@property (nonatomic,weak) IBOutlet UILabel *xib_ta_label_type;
@property (nonatomic,weak) IBOutlet UILabel *xib_ta_label_remark;
@property (nonatomic,weak) IBOutlet UILabel *xib_ta_label_date;
@property (nonatomic,weak) IBOutlet UILabel *xib_ta_label_family;
@property (nonatomic,weak) IBOutlet UIButton *xib_ta_btn_del;
@end

NS_ASSUME_NONNULL_END
