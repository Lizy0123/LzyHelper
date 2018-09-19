//
//  Masonry_LabelViewController.m
//  LzyHelper
//
//  Created by Lzy on 2017/10/27.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import "Masonry_LabelViewController.h"

@interface Masonry_LabelViewController ()

@end

@implementation Masonry_LabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}
-(void)configUI{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.lessThanOrEqualTo(@60);
    }];

    label.text = @"Masonry是一个轻量级的布局框架与更好的包装AutoLayout语法。Masonry有它自己的布局方式，描述NSLayoutConstraints使布局代码更简洁易读。Masonry支持iOS和Mac OS X。Masonry github 地址:https://github.com/SnapKit/MasonryMasonry是一个轻量级的布局框架与更好的包装AutoLayout语法。Masonry有它自己的布局方式，";
    label.preferredMaxLayoutWidth = kScreen_Width;
    [label setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    label.numberOfLines = 0;
    label.backgroundColor = UIColor.redColor;

    UILabel * label2 = [[UILabel alloc] initWithFrame:CGRectZero];
    label2.text = @"Masonry是一个轻量级的布局框架与更好的包装AutoLayout语法。Masonry有它自己的布局方式，描述NSLayoutConstraints使布局代码更简洁易读。Masonry支持iOS和Mac OS X。";
    label2.preferredMaxLayoutWidth = kScreen_Width;
    [label2 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    label2.numberOfLines = 0;
    label2.backgroundColor = UIColor.redColor;
    [self.view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(label.mas_bottom).offset(5);
        make.right.mas_equalTo(0);
    }];


}


@end
