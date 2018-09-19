//
//  Masonry_RelativeConstraintViewController.m
//  LzyHelper
//
//  Created by Lzy on 2017/10/26.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import "Masonry_RelativeConstraintViewController.h"

@interface Masonry_RelativeConstraintViewController ()

@end

@implementation Masonry_RelativeConstraintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configView];
}
-(void)configView{
    UIView *gray1 = [[UIView alloc]init];
    gray1.backgroundColor = [UIColor grayColor];
    [self.view addSubview:gray1];

    UIView *red1 = [[UIView alloc]init];
    red1.backgroundColor = [UIColor redColor];
    [self.view addSubview:red1];

    UIView *gray2 = [[UIView alloc]init];
    gray2.backgroundColor = [UIColor grayColor];
    [self.view addSubview:gray2];

    UIView *red2 = [[UIView alloc]init];
    red2.backgroundColor = [UIColor redColor];
    [self.view addSubview:red2];

    UIView *gray3 = [[UIView alloc]init];
    gray3.backgroundColor = [UIColor grayColor];
    [self.view addSubview:gray3];



    //代码中View的顺序与图中从左到右的View的顺序一致
    //例子中，唯一不确定的就是灰色View的宽度，我们先把确定的约束给一个一个的添加上来

    //灰1左间距、高度、垂直位置（因为和红1底部对齐）是确定的，添加约束
    [gray1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.bottom.equalTo(red1.mas_bottom);
    }];

    //红1，宽高、左间距、底间距是确定的，添加约束
    [red1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(50);
        make.left.equalTo(gray1.mas_right);
        make.bottom.equalTo(self.view.mas_bottom).offset(-50);
    }];
    //灰2，左间距、高度、垂直位置是确定的，宽度要与灰1一致，是为了能均匀填充，添加约束
    [gray2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.and.width.equalTo(gray1);
        make.left.equalTo(red1.mas_right);
        make.bottom.equalTo(red1.mas_bottom);
    }];
    //红2，宽高、左间距、底间距是确定的，添加约束
    [red2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.and.width.equalTo(red1);
        make.left.equalTo(gray2.mas_right);
        make.bottom.equalTo(red1.mas_bottom);
    }];
    //灰3，左间距、右间距、高度、垂直位置是确定的，添加约束
    [gray3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.and.width.equalTo(gray1);
        make.left.equalTo(red2.mas_right);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(red1.mas_bottom);
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
