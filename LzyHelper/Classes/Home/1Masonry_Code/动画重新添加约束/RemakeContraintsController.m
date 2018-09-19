//
//  RemakeContraintsController.m
//  LzyHelper
//
//  Created by Lzy on 2017/10/27.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import "RemakeContraintsController.h"

@interface RemakeContraintsController ()
@property(strong, nonatomic)UIButton *growingBtn;
@property(assign, nonatomic)BOOL isExpanded;
@end

@implementation RemakeContraintsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configView];
}
-(void)configView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;

    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *growingBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.growingBtn = growingBtn;
    [self.growingBtn setTitle:@"点我展开" forState:UIControlStateNormal];
    self.growingBtn.layer.borderColor = UIColor.greenColor.CGColor;
    self.growingBtn.layer.borderWidth = 3;
    self.growingBtn.backgroundColor = [UIColor redColor];
    [self.growingBtn addTarget:self action:@selector(growButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:growingBtn];
    self.isExpanded = NO;
}

// 重写updateViewConstraints
- (void)updateViewConstraints {
    NSLog(@"%s", __func__);
    // 这里使用update也是一样的。
    // remake会将之前的全部移除，然后重新添加
    // block用到self会造曾循环，使用weak
    __weak __typeof(self) weakSelf = self;
    //    [self.growingBtn mas_updateConstraints:^(MASConstraintMaker *make) {
    //        make.top.mas_equalTo(0);
    //        make.left.right.mas_equalTo(0);
    //        if (weakSelf.isExpanded) {
    //            make.bottom.mas_equalTo(0);
    //        } else {
    //            make.bottom.mas_equalTo(-350);
    //        }
    //    }];

    [self.growingBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        if (weakSelf.isExpanded) {
            make.bottom.mas_equalTo(0);
        } else {
            make.bottom.mas_equalTo(-350);
        }
    }];

    [super updateViewConstraints];
}

- (void)growButtonClicked:(UIButton *)growingBtn {
    self.isExpanded = !self.isExpanded;
    if (!self.isExpanded) {
        [self.growingBtn setTitle:@"点我展开" forState:UIControlStateNormal];
    } else {
        [self.growingBtn setTitle:@"点我收起" forState:UIControlStateNormal];
    }

    // 告诉self.view约束需要更新
    [self.view setNeedsUpdateConstraints];
    // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
    [self.view updateConstraintsIfNeeded];

    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

@end
