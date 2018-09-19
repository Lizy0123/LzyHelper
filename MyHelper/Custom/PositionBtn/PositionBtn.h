//
//  PositionBtn.h
//  LzyHelper
//
//  Created by Lzy on 2017/11/10.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,kBtnType) {
    kBtnTypeNomal  = 0,//默认
    kBtnTypeTitleLeft   = 1,//标题在左
    kBtnTypeTitleBottom = 2,//标题在下
};
@interface PositionBtn : UIButton
///图片大小
@property (assign,nonatomic)IBInspectable CGSize imageSize;
///图片相对于 top/right 的 offset
@property (assign,nonatomic)IBInspectable CGFloat offset;

@property (assign,nonatomic)IBInspectable kBtnType btnType;
@end
