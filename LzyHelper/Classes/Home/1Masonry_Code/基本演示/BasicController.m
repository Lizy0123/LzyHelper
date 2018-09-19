//
//  BasicController.m
//  LzyHelper
//
//  Created by Lzy on 2017/10/26.
//  Copyright © 2017年 Lzy. All rights reserved.
//
//1.Masonry的约束添加思维其实与苹果原API的添加思维是相同的，只是Masonry语法更简洁，代码更优美
/*
 1.Autolayout所倡导的两个核心词是约束,参照,dan其实核心思想还是为了设置frame,无论我们如何添加约束，最终还是为了确定其位置与尺寸,所以，Autolayout的关键就是如何设置约束，让空间满足位置,尺寸这两个必要条件
 2.当一个控件的约束已经能够满足上述两个条件了，就不要再添加多余的约束了，很容易会照成约束冲突除非你想设置其他优先级的约束,优先级会在例子中说明其用处
 */
//2.固定约束注意锚点的运用，
/*
 使用Masonry不需要设置控件的translatesAutoresizingMaskIntoConstraints属性为NO;
 防止block中的循环引用，使用弱引用（这是错误观点），在这里block是局部的引用，block内部引用self不会造成循环引用的
 __weak typeof (self) weakSelf = self;（没必要的写法）
 */
#import "BasicController.h"

@interface BasicController ()

@end

@implementation BasicController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configView];
//    [self basicConstraintMethod];//约束的三种方法
//    [self basicConstraintType];//常见约束的各种类型
//    [self basicConstraintAttention];//注意点

}
-(void)configView{
    UIView *greenView = UIView.new;
    greenView.backgroundColor = UIColor.greenColor;
    greenView.layer.borderColor = UIColor.blackColor.CGColor;
    greenView.layer.borderWidth = 2;
    [self.view addSubview:greenView];

    UIView *redView = UIView.new;
    redView.backgroundColor = UIColor.redColor;
    redView.layer.borderColor = UIColor.blackColor.CGColor;
    redView.layer.borderWidth = 2;
    [self.view addSubview:redView];

    UIView *blueView = UIView.new;
    blueView.backgroundColor = UIColor.blueColor;
    blueView.layer.borderColor = UIColor.blackColor.CGColor;
    blueView.layer.borderWidth = 2;
    [self.view addSubview:blueView];


    // 使这三个控件等高
    CGFloat padding = 10;
    [greenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(padding);
        make.right.mas_equalTo(redView.mas_left).offset(-padding);
        make.bottom.mas_equalTo(blueView.mas_top).offset(-padding);
        // 三个控件等高
        make.height.mas_equalTo(@[redView, blueView]);
        // 红、绿这两个控件等高
        make.width.mas_equalTo(redView);
    }];

    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.bottom.mas_equalTo(greenView);
        make.right.mas_equalTo(-padding);
        make.left.mas_equalTo(greenView.mas_right).offset(padding);
    }];

    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(80);
        make.bottom.mas_equalTo(-padding);
        make.left.mas_equalTo(padding);
        make.right.mas_equalTo(-padding);
    }];




    UIView * view = [UIView new];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(300, 300));
    }];

    //约束iconView距离各个边距为30
    UIView *iconView = [[UIView alloc] init];
    [iconView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:iconView];
    //    [iconView mas_remakeConstraints:^(MASConstraintMaker *make) {
    //        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(30, 30, 30, 30));
    //    }];

    [iconView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-30);
        make.top.equalTo(self.view).offset(30);
        make.height.width.equalTo(@(100));
        make.size.mas_equalTo(CGPointMake(1, 1));

        make.size.mas_equalTo(self.view).multipliedBy(0.5);
        make.top.greaterThanOrEqualTo(self.view).offset(10);
    }];
    //    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(self.view.mas_top).with.offset(10);  //with 增强可读性
    //        make.left.equalTo(self.view.mas_right).and.offset(10); //and 增强可读性
    //        make.bottom.equalTo(self.view.mas_top).offset(-10);
    //        make.right.equalTo(self.view.mas_right).offset(-10);
    //        make.width.equalTo(self.view.mas_width);
    //
    //        make.height.equalTo(@[self.view, self.view]); //约束参数相同可以通过数组
    //    }];

}



-(void)basicConstraintMethod{
    //约束的三种方法
    /**
     //这个方法只会添加新的约束
     [blueView mas_makeConstraints:^(MASConstraintMaker *make)  {
     }];

     // 这个方法会将以前的所有约束删掉，添加新的约束
     [blueView mas_remakeConstraints:^(MASConstraintMaker *make) {
     }];

     // 这个方法将会覆盖以前的某些特定的约束
     [blueView mas_updateConstraints:^(MASConstraintMaker *make) {
     }];
     */
}
-(void)basicConstraintType{
    //常见约束的各种类型
    /**
     1.尺寸：width、height、size
     2.边界：left、leading、right、trailing、top、bottom
     3.中心点：center、centerX、centerY
     4.边界：edges
     5.偏移量：offset、insets、sizeOffset、centerOffset
     6.priority()约束优先级（0~1000），multipler乘因数, dividedBy除因数
     */
}
-(void)basicConstraintAttention{
    //注意点
    /*1.
     使用Masonry不需要设置控件的translatesAutoresizingMaskIntoConstraints属性为NO;
     防止block中的循环引用，使用弱引用（这是错误观点），在这里block是局部的引用，block内部引用self不会造成循环引用的
     __weak typeof (self) weakSelf = self;（没必要的写法）
     */
    /*2.
     当约束冲突发生的时候，我们可以设置view的key来定位是哪个view
     redView.mas_key = @"redView";
     greenView.mas_key = @"greenView";
     blueView.mas_key = @"blueView";
     若是觉得这样一个个设置比较繁琐，怎么办呢，Masonry则提供了批量设置的宏MASAttachKeys
     MASAttachKeys(redView,greenView,blueView); //一句代码即可全部设置
     */
    /*3.equalTo 和 mas_equalTo的区别
     mas_equalTo只是对其参数进行了一个BOX(装箱) 操作，目前支持的类型：数值类型（NSNumber）、 点（CGPoint）、大小（CGSize）、边距（UIEdgeInsets），
     而equalTo：这个方法不会对参数进行包装。
     */
}

@end
