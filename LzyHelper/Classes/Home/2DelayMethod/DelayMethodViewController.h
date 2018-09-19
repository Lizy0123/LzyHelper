//
//  DelayMethodViewController.h
//  LzyHelper
//
//  Created by Lzy on 2017/10/26.
//  Copyright © 2017年 Lzy. All rights reserved.

#import "BaseViewController.h"

@interface DelayMethodViewController : BaseViewController

//NSDelayedPerforming
/*
我们一般让某个对象延时执行某个方法都会调用包含  afterDelay这个参数的方法，此参数即代表延时多长时间执行 ，但是这一系列的方法的参数都只接受继承自NSObject类得对象，也就是说如果我们要向其中传入基本的数据类型，那就必须涉及到数据类型转换，这显然会增加开销，而且这一系列的方法最多也就能传如一个参数，如果我们要传多个参数怎么办呢 ，如果想继续使用这个方法，那我们就必须把多个参数写入数组或字典中去，然后把数组或字典对象传给这个方法，那么着就又会增加我们插入数组或字典，解析数组或字典的代码 ，数据量达到一定情况的话，这个开销是可想而知的，而且我们还要知道数组和字典中得每个对象都代表什么，很麻烦；
 */
//- (void)performSelector:(SEL _Nullable )aSelector withObject:(nullable id)anArgument afterDelay:(NSTimeInterval)delay inModes:(NSArray<NSRunLoopMode> *_Nullable)modes;
//- (void)performSelector:(SEL _Nullable )aSelector withObject:(nullable id)anArgument afterDelay:(NSTimeInterval)delay;
//+ (void)cancelPreviousPerformRequestsWithTarget:(id _Nullable )aTarget selector:(SEL _Nullable )aSelector object:(nullable id)anArgument;
//+ (void)cancelPreviousPerformRequestsWithTarget:(id _Nullable )aTarget;
//- (void)performSelector:(SEL _Nullable )aSelector onThread:(NSThread *_Nonnull)thr withObject:(nullable id)arg waitUntilDone:(BOOL)wait;




@end
