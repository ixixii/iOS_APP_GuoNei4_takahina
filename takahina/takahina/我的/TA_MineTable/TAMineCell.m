//
//  TAMineCell.m
//  takahina
//
//  Created by beyond on 2020/03/29.
//  Copyright © 2020 beyond. All rights reserved.
//

#import "TAMineCell.h"

@implementation TAMineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)taMineCell
{
    NSArray *tmpArr = [[NSBundle mainBundle]loadNibNamed:@"TAMineCell" owner:nil options:nil];
    return tmpArr[0];
}


@end
