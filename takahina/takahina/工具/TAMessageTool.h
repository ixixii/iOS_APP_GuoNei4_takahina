//
//  TAMessageTool.h
//  takahina
//
//  Created by beyond on 2020/04/02.
//  Copyright © 2020 beyond. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface TAMessageTool : NSObject
+(void)showTAMessage:(NSString *)message;
+(void)showTAMessage:(NSString *)message duration:(NSInteger)duration;
+(void)showTAMessage:(NSString *)message duration:(NSInteger)duration positionY:(NSInteger)positionY;
@end

NS_ASSUME_NONNULL_END
