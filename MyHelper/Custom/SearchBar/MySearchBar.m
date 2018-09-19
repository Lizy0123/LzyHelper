//
//  MySearchBar.m
//  LzyHelper
//
//  Created by Lzy on 2017/10/25.
//  Copyright © 2017年 Lzy. All rights reserved.
//

@import UIKit;
@implementation UIImage (UIImageAddition)

+ (instancetype)resizableImageNamed:(NSString *)name
{
    return [self resizableImageNamed:name left:0.5 top:0.5];
}

+ (instancetype)resizableImageNamed:(NSString *)name left:(CGFloat)leftRatio top:(CGFloat)topRatio{
    UIImage *image = [UIImage imageNamed:name];
    CGFloat left = image.size.width * leftRatio;
    CGFloat top = image.size.height * topRatio;
    return [image stretchableImageWithLeftCapWidth:left topCapHeight:top];
}
@end


#import "MySearchBar.h"

@implementation MySearchBar
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.设置背景图片
        self.background = [UIImage resizableImageNamed:@"searchbar_textfield_background_os7"];

        // 2.设置文字居中和文字大小
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.font = [UIFont systemFontOfSize:13];

        // 3.添加放大镜
        UIImage *image = [UIImage imageNamed:@"searchbar_textfield_search_icon_os7"];
        UIImageView *icon = [[UIImageView alloc] initWithImage:image];
        //        [self addSubview:icon];

        //仅修改icon的宽度,xyh值不变
        icon.frame = CGRectMake(CGRectGetMinX(icon.frame),
                                CGRectGetMinY(icon.frame),
                                30,
                                CGRectGetHeight(icon.frame)
                                );
        icon.contentMode = UIViewContentModeCenter;
        self.leftView = icon;
        self.leftViewMode = UITextFieldViewModeAlways;

        // 4.设置提示文字
        self.placeholder = @"请输入搜索条件";

        // 5.设置清除按钮
        self.clearButtonMode = UITextFieldViewModeAlways;
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
