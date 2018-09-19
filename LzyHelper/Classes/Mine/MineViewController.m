//
//  MineViewController.m
//  LzyHelper
//
//  Created by Lzy on 2017/10/25.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import "MineViewController.h"
#import "MySearchBar.h"

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"我的"];
    [self.view setBackgroundColor:[UIColor redColor]];

    UIButton * btn = [UIButton buttonWithTitle:@"你好qrer" titleColor:[UIColor blueColor]];
    btn.frame = CGRectMake(100, 150, 90, 50);
    [btn userNameStyle];
    [btn addTarget:self action:@selector(inv:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];


    UIButton * button = [UIButton buttonWithStyle:StrapDangerStyle andTitle:@"哈哈哈" andFrame:CGRectMake(16, 16, 100, 20) target:self action:@selector(inv:)];
    [self.view addSubview:button];

    // 给导航条右边添加一个按钮
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(setting)];

    self.navigationItem.rightBarButtonItem = item;


    // 1.创建一个搜索框
    MySearchBar *searchBar = [[MySearchBar alloc] init];

    // 2.设置frame 注意:由于设置的是导航条的头部视图,所以x,y无效
    searchBar.frame = CGRectMake(0, 0, 300, 35);

    // 3.把搜索框添加到导航控制器的View中
    self.navigationItem.titleView = searchBar;

}
-(void)inv:(id)sender{
    [sender animateToImage:@"tweet_btn_liked"];
    [sender startQueryAnimate];
    int64_t delayInSeconds = 3.0; // 延迟的时间
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(delayTime, dispatch_get_main_queue(), ^(void){
        [sender stopQueryAnimate];
    });

}
- (void)setting
{
    // 跳转到下一个控制器
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor purpleColor];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)testPush {
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:viewController animated:YES];
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
