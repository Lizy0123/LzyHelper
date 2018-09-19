//
//  UITableView+Common.h
//  YLuxury
//
//  Created by Lzy on 2017/5/10.
//  Copyright © 2017年 YLuxury. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Common)
- (void)addRadiusforCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace;
- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpaceAndSectionLine:(CGFloat)leftSpace;
- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace hasSectionLine:(BOOL)hasSectionLine;


@end

