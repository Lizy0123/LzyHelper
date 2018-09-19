//
//  NoDoubleClickBtn.m
//  LzyHelper
//
//  Created by Lzy on 2017/10/26.
//  Copyright © 2017年 Lzy. All rights reserved.
//
/*
 防止重复点击
 1.每次点击按钮时，先执行取消之前的按钮点击执行事件，然后再去执行一个延迟执行方法（方法中执行的是按钮执行的事件）。代码如下：
 - (void)buttonClicked:(id)sender {
 //在这里做按钮的想做的事情。
 }

 - (void)starButtonClicked:(id)sender{
 //先将未到时间执行前的任务取消。
 [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(buttonClicked:)object:sender];
 [self performSelector:@selector(buttonClicked:)withObject:sender afterDelay:0.2f];
 }

 */
#import "NoDoubleClickBtn.h"

@interface NoDoubleClickBtn ()
@property(nonatomic,assign)BOOL kFlag;
@end

@implementation NoDoubleClickBtn

- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    if (!self.kFlag){
        [super sendAction:action to:target forEvent:event];
        self.kFlag = !self.kFlag;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.kFlag = !self.kFlag;
        });
    }
    else{
        return;
    }
}


//- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
//    [super sendAction:action to:target forEvent:event];
//    self.enabled = NO;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.enabled = YES;
//    });
//}

@end
