//
//  TAFamilyTableViewCell.h
//  takahina
//
//  Created by beyond on 2020/03/29.
//  Copyright © 2020 beyond. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TAFamilyTableViewCell : UITableViewCell
@property (nonatomic,weak) IBOutlet UILabel *xib_ta_label_relation;
@property (nonatomic,weak) IBOutlet UILabel *xib_ta_label_interest;
@property (nonatomic,weak) IBOutlet UILabel *xib_ta_label_description;

@property (nonatomic,weak) IBOutlet UIButton *xib_ta_button_delete;
+ (instancetype)taFamilyTableViewCell;
@end

NS_ASSUME_NONNULL_END
