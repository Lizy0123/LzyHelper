//
//  UILabel+Common.h
//  LzyHelper
//
//  Created by Lzy on 2017/11/10.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, FakeAnimationDirection) {
    FakeAnimationRight = 1,       ///< left to right
    FakeAnimationLeft = -1,       ///< right to left
    FakeAnimationDown = -2,       ///< up to down
    FakeAnimationUp = 2           ///< down to up
};
// animation duration
static const NSTimeInterval kFakeLabelAnimationDuration = 0.2;
@interface UILabel (Common)

- (void) setLongString:(NSString *)str withFitWidth:(CGFloat)width;
- (void) setLongString:(NSString *)str withFitWidth:(CGFloat)width maxHeight:(CGFloat)maxHeight;
- (void) setLongString:(NSString *)str withVariableWidth:(CGFloat)maxWidth;

- (void)setAttrStrWithStr:(NSString *)text diffColorStr:(NSString *)diffColorStr diffColor:(UIColor *)diffColor;
- (void)addAttrDict:(NSDictionary *)attrDict toStr:(NSString *)str;
- (void)addAttrDict:(NSDictionary *)attrDict toRange:(NSRange)range;

+ (instancetype)labelWithFont:(UIFont *)font textColor:(UIColor *)textColor;
+ (instancetype)labelWithSystemFontSize:(CGFloat)fontSize textColorHexString:(NSString *)stringToConvert;

- (void)colorTextWithColor:(UIColor *)color range:(NSRange)range;
- (void)fontTextWithFont:(UIFont *)font range:(NSRange)range;



/**
 *  改变行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变字间距
 */
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变行间距和字间距
 */
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;


- (void)fakeStartAnimationWithDirection:(FakeAnimationDirection)direction toText:(NSString *)toText;
@end
