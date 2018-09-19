//
//  Masonry_AnimationConstraintViewController.m
//  LzyHelper
//
//  Created by Lzy on 2017/10/26.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import "Masonry_AnimationConstraintViewController.h"

@interface Masonry_AnimationConstraintViewController ()

@end

@implementation Masonry_AnimationConstraintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configView];
}
-(void)configView{
    UIView *redView = [[UIView alloc]init];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];

    UIView *greenView = [[UIView alloc]init];
    greenView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:greenView];

    UIView *blueView = [[UIView alloc]init];
    blueView.backgroundColor  = [UIColor blueColor];
    [self.view addSubview:blueView];

    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.bottom.equalTo(self.view.mas_bottom).offset(-20);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.2);
        make.height.equalTo(self.view.mas_height).multipliedBy(0.2);
    }];
    [greenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(redView.mas_right).offset(20);
        make.bottom.equalTo(self.view.mas_bottom).offset(-20);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.2);
        make.height.equalTo(self.view.mas_height).multipliedBy(0.2);
    }];
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(greenView.mas_right).offset(20);
        make.bottom.equalTo(self.view.mas_bottom).offset(-20);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.2);
        make.height.equalTo(self.view.mas_height).multipliedBy(0.2);
        make.left.equalTo(redView.mas_right).offset(20).priority(250);
    }];
    __block Masonry_AnimationConstraintViewController/*主控制器*/ *weakSelf = self;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [greenView removeFromSuperview];
        [UIView animateWithDuration:1.0f animations:^{
            [weakSelf.view layoutIfNeeded];
        }];
    });
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
