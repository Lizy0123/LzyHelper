//
//  UpdateConstraintsController.m
//  LzyHelper
//
//  Created by Lzy on 2017/10/26.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import "UpdateConstraintsController.h"

@interface UpdateConstraintsController ()
@property(strong, nonatomic)UIButton *plusBtn;
@property(strong, nonatomic)UIButton *minusBtn;
@property(assign, nonatomic)CGFloat scacle;
@end

@implementation UpdateConstraintsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSomeViewInARow];
    [self configGrowBtn];

}

- (void)configSomeViewInARow {
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn1.layer.borderColor = [UIColor redColor].CGColor;
    btn1.layer.borderWidth = 2;
    [self.view addSubview:btn1];

    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn2.layer.borderColor = [UIColor redColor].CGColor;
    btn2.layer.borderWidth = 2;
    [self.view addSubview:btn2];

    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn3.layer.borderColor = [UIColor redColor].CGColor;
    btn3.layer.borderWidth = 2;
    [self.view addSubview:btn3];
    // 沿着轴线显示  此种是确定btn的宽和距离两边的距离来自动布局
    //    [@[btn1, btn2, btn3] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal
    //                                  withFixedItemLength:90
    //                                          leadSpacing:15
    //                                          tailSpacing:15];
    // 确定btn之间的间距和屏幕两边来自动布局
    [@[btn1, btn2, btn3] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal
                                     withFixedSpacing:20
                                          leadSpacing:20
                                          tailSpacing:20];


    [@[btn1, btn2, btn3] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
    }];
}
-(void)configGrowBtn{
    UIButton *growingBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.plusBtn = growingBtn;
    [self.plusBtn setTitle:@"+" forState:UIControlStateNormal];
    [self.plusBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    self.plusBtn.layer.borderColor = UIColor.greenColor.CGColor;
    self.plusBtn.layer.borderWidth = 3;
    self.scacle = 1.0;

    [self.plusBtn addTarget:self action:@selector(GrowButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:growingBtn];

    [self.plusBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        // // 初始宽、高为100，优先级最低,设置他的优先级是低的
        make.width.height.mas_equalTo(80 * self.scacle).priorityLow();
         // 最大放大到整个view
        make.width.height.lessThanOrEqualTo(self.view);
    }];
}
#pragma mark - updateViewConstraints
// 重写updateViewConstraints方法，根据打印可以看出执行顺序。
- (void)updateViewConstraints {
    NSLog(@"%s2", __func__);
    [self.plusBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);

        // 初始宽、高为100，优先级最低
        make.width.height.mas_equalTo(100 * self.scacle).priorityLow();
        // 最大放大到整个view
        make.width.height.lessThanOrEqualTo(self.view);
    }];

    [super updateViewConstraints];
}

- (void)GrowButtonClick:(UIButton *)growingBtn {
    NSLog(@"%s1", __func__);
    self.scacle += 0.2;
    // 告诉self.view 约束更新
    [self.view setNeedsUpdateConstraints];
    // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
    [self.view updateConstraintsIfNeeded];
    NSLog(@"%s3", __func__);
    [UIView animateWithDuration:0.4 animations:^{
        [self.view layoutIfNeeded];
    }];
}


@end
