//
//  UILabel+Common.m
//  LzyHelper
//
//  Created by Lzy on 2017/11/10.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import "UILabel+Common.h"
#import "UIColor+Common.h"

#import <objc/runtime.h>

// st_isAnimating asscoiate key
static void * FakeLabelAnimationIsAnimatingKey = &FakeLabelAnimationIsAnimatingKey;

@interface UILabel ()

@property (assign, nonatomic) BOOL fake_isAnimating; ///< default is NO

@end

@implementation UILabel (Common)
- (void)setLongString:(NSString *)str withFitWidth:(CGFloat)width{
    [self setLongString:str withFitWidth:width maxHeight:CGFLOAT_MAX];
}

- (void) setLongString:(NSString *)str withFitWidth:(CGFloat)width maxHeight:(CGFloat)maxHeight{
    self.numberOfLines = 0;
    CGSize resultSize = [str getSizeWithFont:self.font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)];
    CGFloat resultHeight = resultSize.height;
    if (maxHeight > 0 && resultHeight > maxHeight) {
        resultHeight = maxHeight;
    }
    CGRect frame = self.frame;
    frame.size.height = resultHeight;
    [self setFrame:frame];
    self.text = str;
}

- (void) setLongString:(NSString *)str withVariableWidth:(CGFloat)maxWidth{
    self.numberOfLines = 0;
    self.text = str;
    CGSize resultSize = [str getSizeWithFont:self.font constrainedToSize:CGSizeMake(maxWidth, CGFLOAT_MAX)];
    CGRect frame = self.frame;
    frame.size.height = resultSize.height;
    frame.size.width = resultSize.width;
    [self setFrame:frame];
}

- (void)setAttrStrWithStr:(NSString *)text diffColorStr:(NSString *)diffColorStr diffColor:(UIColor *)diffColor{

    NSMutableAttributedString *attrStr;
    if (text) {
        attrStr = [[NSMutableAttributedString alloc] initWithString:text];
    }
    if (diffColorStr && diffColor) {
        NSRange diffColorRange = [text rangeOfString:diffColorStr];
        if (diffColorRange.location != NSNotFound) {
            [attrStr addAttribute:NSForegroundColorAttributeName value:diffColor range:diffColorRange];
        }
    }
    self.attributedText = attrStr;
}
- (void)addAttrDict:(NSDictionary *)attrDict toStr:(NSString *)str{
    if (str.length <= 0) {
        return;
    }
    NSMutableAttributedString *attrStr = self.attributedText? self.attributedText.mutableCopy: [[NSMutableAttributedString alloc] initWithString:self.text];
    [self addAttrDict:attrDict toRange:[attrStr.string rangeOfString:str]];
}

- (void)addAttrDict:(NSDictionary *)attrDict toRange:(NSRange)range{
    if (range.location == NSNotFound || range.length <= 0) {
        return;
    }
    NSMutableAttributedString *attrStr = self.attributedText? self.attributedText.mutableCopy: [[NSMutableAttributedString alloc] initWithString:self.text];
    if (range.location + range.length > attrStr.string.length) {
        return;
    }
    [attrStr addAttributes:attrDict range:range];
    self.attributedText = attrStr;
}

+ (instancetype)labelWithFont:(UIFont *)font textColor:(UIColor *)textColor{
    UILabel *label = [self new];
    label.font = font;
    label.textColor = textColor;
    return label;
}

+ (instancetype)labelWithSystemFontSize:(CGFloat)fontSize textColorHexString:(NSString *)stringToConvert{
    UILabel *label = [self new];
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = [UIColor colorWithHexString:stringToConvert];
    return label;
}

- (void)colorTextWithColor:(UIColor *)color range:(NSRange)range {
    NSMutableAttributedString *attrStr = self.attributedText? self.attributedText.mutableCopy: [[NSMutableAttributedString alloc] initWithString:self.text];

    [attrStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    self.attributedText = attrStr;
}

- (void)fontTextWithFont:(UIFont *)font range:(NSRange)range {
    NSMutableAttributedString *attrStr = self.attributedText? self.attributedText.mutableCopy: [[NSMutableAttributedString alloc] initWithString:self.text];

    [attrStr addAttribute:NSFontAttributeName value:font range:range];
    self.attributedText = attrStr;
}




+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space {

    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];

}

+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
}

+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace {

    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];

}

- (void)fakeStartAnimationWithDirection:(FakeAnimationDirection)direction toText:(NSString *)toText {
    if (![toText respondsToSelector:@selector(length)]) {
        return;
    }
    if (self.fake_isAnimating) {
        return;
    }
    self.fake_isAnimating = YES;
    
    UILabel *fakeLabel = [UILabel new];
    fakeLabel.frame = self.frame;
    fakeLabel.textAlignment = self.textAlignment;
    fakeLabel.font = self.font;
    fakeLabel.textColor = self.textColor;
    fakeLabel.text = toText;
    fakeLabel.backgroundColor = self.backgroundColor != nil ? self.backgroundColor : [UIColor clearColor];
    [self.superview addSubview:fakeLabel];
    
    CGFloat labelOffsetX = 0.0;
    CGFloat labelOffsetY = 0.0;
    CGFloat labelScaleX = 0.1;
    CGFloat labelScaleY = 0.1;
    
    if (direction == FakeAnimationDown || direction == FakeAnimationUp) {
        labelOffsetY = direction * CGRectGetHeight(self.bounds) / 4;
        labelScaleX = 1.0;
    }
    if (direction == FakeAnimationLeft || direction == FakeAnimationRight) {
        labelOffsetX = direction * CGRectGetWidth(self.bounds) / 2;
        labelScaleY = 1.0;
    }
    fakeLabel.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(labelScaleX, labelScaleY), CGAffineTransformMakeTranslation(labelOffsetX, labelOffsetY));
    
    [UIView animateWithDuration:kFakeLabelAnimationDuration animations:^{
        fakeLabel.transform = CGAffineTransformIdentity;
        self.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(labelScaleX, labelScaleY), CGAffineTransformMakeTranslation(-labelOffsetX, -labelOffsetY));
    } completion:^(BOOL finished) {
        self.transform = CGAffineTransformIdentity;
        [fakeLabel removeFromSuperview];
        self.text = toText;
        self.fake_isAnimating = NO;
    }];
}

- (BOOL)fake_isAnimating {
    NSNumber *isAnimatingNumber = objc_getAssociatedObject(self, FakeLabelAnimationIsAnimatingKey);
    return isAnimatingNumber.boolValue;
}

- (void)setFake_isAnimating:(BOOL)fake_isAnimating {
    objc_setAssociatedObject(self, FakeLabelAnimationIsAnimatingKey, @(fake_isAnimating), OBJC_ASSOCIATION_ASSIGN);
}
@end
