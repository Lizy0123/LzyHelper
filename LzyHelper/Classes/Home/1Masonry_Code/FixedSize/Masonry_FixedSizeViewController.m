//
//  Masonry_FixedSizeViewController.m
//  LzyHelper
//
//  Created by Lzy on 2017/10/26.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import "Masonry_FixedSizeViewController.h"

@interface Masonry_FixedSizeViewController ()

@end

@implementation Masonry_FixedSizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configView];
}
-(void)configView{
    UIView *redView = [[UIView alloc]init];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];

    UIView *blueView = [[UIView alloc]init];
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];

    UIView *yellow = [[UIView alloc]init];
    yellow.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:yellow];

    UIView *green = [[UIView alloc]init];
    green.backgroundColor = [UIColor greenColor];
    [self.view addSubview:green];


    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);//使左边等于self.view的左边，间距为0
        make.top.equalTo(self.view.mas_top).offset(0);//使顶部与self.view的间距为0
        make.width.equalTo(self.view.mas_width).multipliedBy(0.5);//设置宽度为self.view的一半，multipliedBy是倍数的意思，也就是，使宽度等于self.view宽度的0.5倍
        make.height.equalTo(self.view.mas_height).multipliedBy(0.5);//设置高度为self.view高度的一半
    }];
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.equalTo(redView);//使宽高等于redView
        make.top.equalTo(redView.mas_top);//与redView顶部对齐
        make.left.equalTo(redView.mas_right);//与redView的间距为0
    }];
    [yellow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(redView);//与redView左对齐
        make.top.equalTo(redView.mas_bottom);//与redView底部间距为0
        make.width.and.height.equalTo(redView);//与redView宽高相等
    }];
    [green mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(yellow.mas_right);//与yellow右边间距为0
        make.top.equalTo(blueView.mas_bottom);//与blueView底部间距为0
        make.width.and.height.equalTo(redView);//与redView等宽高
    }];
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
