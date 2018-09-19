//
//  CollectionReusableView.m
//  LzyHelper
//
//  Created by Lzy on 2017/11/11.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import "CollectionReusableView.h"

@implementation CollectionReusableView
-(id)initWithFrame:(CGRect)frame{
    if (self= [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 44)];
        label.text = @"  商品区";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = kColorHex(0x777777);
        label.font = [UIFont boldSystemFontOfSize:18];
        label.backgroundColor = [UIColor redColor];
        [self addSubview:label];
        self.label = label;
    }return self;
}

@end
