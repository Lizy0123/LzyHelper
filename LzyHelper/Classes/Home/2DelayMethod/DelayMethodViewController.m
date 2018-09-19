//
//  DelayMethodViewController.m
//  LzyHelper
//
//  Created by Lzy on 2017/10/26.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import "DelayMethodViewController.h"

@interface DelayMethodViewController ()

@end

@implementation DelayMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"delayMethodStart");
    [self methodOnePerformSelector];
//    [self methodTwoNSTimer];
//    [self methodThreeSleep];
//    [self methodFourGCD];
    NSLog(@"nextMethod");
}
- (void)methodFiveAnimation{
    [UIView animateWithDuration:0 delay:2.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
    } completion:^(BOOL finished) {
        [self delayMethod];
    }];
}
- (void)methodFourGCD{
    //4.GCD方法dispatch_after
    //此方式在可以在参数中选择执行的线程。
    //非阻塞式
    int64_t delayInSeconds = 10.0; // 延迟的时间
    __block DelayMethodViewController/*主控制器*/ *weakSelf = self;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(delayTime, dispatch_get_main_queue(), ^(void){
        [weakSelf delayMethod];
    });
}
- (void)methodThreeSleep{
    //3.NSThread线程sleep方法
    //阻塞式，建议放在主线程中执行会卡住界面。
    //在主线程和子线程中均可执行。
    [NSThread sleepForTimeInterval:2.0];
}
- (void)methodTwoNSTimer{
    //2.NSTimer定时器方法
    //非阻塞式
    //通过NSTimer类的- (void)invalidate;取消执行。
    //必须在主线程中执行，否则无效。
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(delayMethod) userInfo:nil repeats:NO];
    NSLog(@"%@",timer)
}
- (void)methodOnePerformSelector{
    //1.performSelector方法
    //非阻塞式
    //取消执行[NSObject cancelPreviousPerformRequestsWithTarget:self];撤回全部申请延迟执行的方法
    //必须在主线程中执行，否则无效。

    [self performSelector:@selector(delayMethod) withObject:nil/*可传任意类型参数*/ afterDelay:2.0];
}



- (void)delayMethod{
    NSLog(@"delayMethodEnd");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
