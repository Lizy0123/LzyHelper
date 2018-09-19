//
//  UIBadgeView.h
//  LzyHelper
//
//  Created by Lzy on 2017/11/11.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#define  kBadgeTipStr @"badgeTip"

@interface UIBadgeView : UIView
/**
 * Text that is displayed in the upper-right corner of the item with a surrounding background.
 */
@property (nonatomic, copy) NSString *badgeValue;

+ (UIBadgeView *)viewWithBadgeTip:(NSString *)badgeValue;
+ (CGSize)badgeSizeWithStr:(NSString *)badgeValue font:(UIFont *)font;

- (CGSize)badgeSizeWithStr:(NSString *)badgeValue;
@end
