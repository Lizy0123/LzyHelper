//
//  PositionBtn.m
//  LzyHelper
//
//  Created by Lzy on 2017/11/10.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import "PositionBtn.h"

@implementation PositionBtn

- (void)setBtnType:(kBtnType)btnType{
    _btnType = btnType;

    if (btnType != kBtnTypeNomal) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
}

//重写父类方法,改变标题和image的坐标
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    if (self.btnType == kBtnTypeTitleLeft) {
        CGFloat x = contentRect.size.width - self.offset - self.imageSize.width ;
        CGFloat y =  contentRect.size.height -  self.imageSize.height;
        y = y/2;
        CGRect rect = CGRectMake(x,y,self.imageSize.width,self.imageSize.height);
        return rect;
    } else if (self.btnType == kBtnTypeTitleBottom) {
        CGFloat x =  contentRect.size.width -  self.imageSize.width;
        CGFloat  y=   self.offset   ;
        x = x / 2;
        CGRect rect = CGRectMake(x,y,self.imageSize.width,self.imageSize.height);
        return rect;
    } else {
        return [super imageRectForContentRect:contentRect];
    }
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    if (self.btnType == kBtnTypeTitleLeft) {
        return CGRectMake(0, 0, contentRect.size.width - self.offset - self.imageSize.width , contentRect.size.height);
    } else if (self.btnType == kBtnTypeTitleBottom) {
        return CGRectMake(0,   self.offset + self.imageSize.height , contentRect.size.width , contentRect.size.height - self.offset - self.imageSize.height );
    } else {
        return [super titleRectForContentRect:contentRect];
    }
}


@end
