//
//  TotalUpdateController.m
//  LzyHelper
//
//  Created by Lzy on 2017/10/27.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import "TotalUpdateController.h"

@interface TotalUpdateController ()
@property(strong, nonatomic)UIView *purpleView;
@property(strong, nonatomic)UIView *orangeView;
@property(strong, nonatomic)UILabel *label;
@property(assign, nonatomic)BOOL isExpaned;
@end

@implementation TotalUpdateController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configView];
}
-(void)configView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = NO;
    //pupleView
    UIView *purpleView = [[UIView alloc] init];
    purpleView.backgroundColor = UIColor.purpleColor;
    purpleView.layer.borderColor = UIColor.blackColor.CGColor;
    purpleView.layer.borderWidth = 2;
    [self.view addSubview:purpleView];
    self.purpleView = purpleView;
    // 添加点击事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionPurpleViewTap)];
    [self.purpleView addGestureRecognizer:tap];
    self.isExpaned = NO;
    // 约束
    [self.purpleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(-300).priorityLow();
    }];
    //Label
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.textColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"点击purple部分放大，orange部分最大值250，最小值90";
    [self.purpleView addSubview:label];
    self.label = label;

    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
    }];


    //OrangeView
    UIView *orangeView = UIView.new;
    orangeView.backgroundColor = UIColor.orangeColor;
    orangeView.layer.borderColor = UIColor.blackColor.CGColor;
    orangeView.layer.borderWidth = 2;
    [self.view addSubview:orangeView];
    self.orangeView = orangeView;

    [self.orangeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.purpleView);
        make.width.height.lessThanOrEqualTo(@250);
        make.width.height.greaterThanOrEqualTo(@90);
    }];




//    // 这里，我们不使用updateViewConstraints方法，但是我们一样可以做到。
//    // 不过苹果推荐在updateViewConstraints方法中更新或者添加约束的
//    //ViewDidLoad中都不用添加约束，直接在下面的方法中添加了约束
//    [self updateViewConstraintsWithExpand:NO animated:NO];

}


#pragma mark Action
- (void)actionPurpleViewTap {
    self.isExpaned = !self.isExpaned;
    [self.view setNeedsUpdateConstraints];

    //    [self.view updateConstraintsIfNeeded];
    //    NSLog(@"%s", __func__);
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];


//    // 这里，我们不使用updateViewConstraints方法，但是我们一样可以做到。
//    // 不过苹果推荐在updateViewConstraints方法中更新或者添加约束的
//    //ViewDidLoad中都不用添加约束，直接在下面的方法中添加了约束
//    [self updateViewConstraintsWithExpand:!self.isExpaned animated:YES];

}

#pragma mark - **************** updateViewConstraints
// 苹果推荐在uodateVViewConstraints 中更新或者添加约束
-(void)updateViewConstraintsWithExpand:(BOOL)isExpanded animated:(BOOL)animated{
    self.isExpaned = isExpanded;
    [self.purpleView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        if (isExpanded) {
            make.bottom.mas_equalTo(-20);
        }else{
            make.bottom.mas_equalTo(-300);
        }
    }];
    [self.orangeView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.purpleView);
        if (!isExpanded) {
            make.width.height.mas_equalTo(100 * 0.5).priorityLow();
        }else{
            make.width.height.mas_equalTo(100 * 0.3).priorityLow();
        }
        // 最大值为250
        make.width.height.lessThanOrEqualTo(@250);
         // 最小值为90
        make.width.height.greaterThanOrEqualTo(@90);
    }];

    if (animated) {
        [self.view setNeedsUpdateConstraints];
        [self.view updateConstraintsIfNeeded];
        [UIView animateWithDuration:0.5 animations:^{
            [self.view layoutIfNeeded];
        }];
    }


}
- (void)updateViewConstraints {
    if (self.isExpaned) {
        [self.purpleView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-10).priorityLow();
        }];
    } else {
        [self.purpleView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-300).priorityLow();
        }];
    }

    [self.orangeView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.purpleView);
        // 这里使用优先级处理
        // 设置其最大值为250，最小值为90
        if (!self.isExpaned) {
            make.width.height.mas_equalTo(100 * 0.5).priorityLow();
        } else {
            make.width.height.mas_equalTo(100 * 3).priorityLow();
        }
    }];


    [super updateViewConstraints];
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
