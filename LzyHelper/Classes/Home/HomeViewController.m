//
//  HomeViewController.m
//  LzyHelper
//
//  Created by Lzy on 2017/10/25.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import "HomeViewController.h"
#import "CYLTabBarController.h"

//#import "ViewController.h"
//#import "MineViewController.h"
//#import "Masonry_CodeViewController.h"
//#import "DelayMethodViewController.h"
//#import "Masonry_AutoLayoutViewController.h"


@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(strong, nonatomic)UITableView *myTableView;
@property(strong, nonatomic)NSMutableArray *dataSourceArray;
@property(strong, nonatomic)NSMutableArray *titlesArray;
@end


@implementation HomeViewController
-(void)configTop{
    self.navigationItem.title = @"首页(3)";
    //✅sets navigation bar title.The right way to set the title of the navigation
//      self.tabBarItem.title = @"首页23333";
    //❌sets tab bar title. Even the `tabBarItem.title` changed, this will be ignored in tabbar.
//      self.title = @"首页1";
    //❌sets both of these. Do not do this‼️‼️This may cause something strange like this : http://i68.tinypic.com/282l3x4.jpg .
    [self.navigationController.tabBarItem setBadgeValue:@"3"];
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSourceArray = @[].mutableCopy;
    self.titlesArray = @[].mutableCopy;
    [self configTop];
    [self configTableView];
    
    [self addCell:@"Masonry_AutoLayout" class:@"Masonry_AutoLayoutViewController"];
    [self addCell:@"Masonry_Code" class:@"Masonry_CodeViewController"];
    [self addCell:@"DelyMethod延时方法" class:@"DelayMethodViewController"];
    [self addCell:@"瀑布流" class:@"WaterFallViewController"];
    [self addCell:@"WebView添加头尾视图" class:@"TestWebViewController"];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//懒加载这样写
-(NSMutableArray *)dataSourceArray{
    if (!_dataSourceArray) {
        _dataSourceArray = [[NSMutableArray alloc] initWithArray:@[@"Masonry_AutoLayoutViewController",@"Masonry_CodeViewController",@"DelayMethodViewController"]];
    }
    return _dataSourceArray;
}


#pragma mark - UI
-(void)configTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [tableView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];

    self.myTableView = tableView;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return YES;
    }
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
}

#pragma mark - Action
- (void)addCell:(NSString *)title class:(NSString *)className {
    [self.titlesArray addObject:title];
    [self.dataSourceArray addObject:className];
}

#pragma mark - TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 30)];
    return headerView;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 30)];
    return footerView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}


- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    [[cell textLabel] setText:[NSString stringWithFormat:@"%@：%@", @(indexPath.row),[self.dataSourceArray objectAtIndex:indexPath.row]]];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSNumber *badgeNumber = @(indexPath.row + 1);
    self.navigationItem.title = [NSString stringWithFormat:@"首页(%@)", badgeNumber];
    [self.navigationController.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%@", badgeNumber]];
    [self configSelect:tableView forIndexPath:indexPath];

}
//-(void)configSelect:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath{
//    UIViewController *vc = nil;
//    switch (indexPath.row) {
//        case 0:
//            //    viewController.hidesBottomBarWhenPushed = YES;
//            // This property needs to be set before pushing viewController to the navigationController's stack. Meanwhile as it is all base on BaseNavigationController, there is no need to do this.
//            vc = [Masonry_AutoLayoutViewController new];
//            ((Masonry_AutoLayoutViewController *)vc).title = @"Masonry_AutoLayout";
//            [self.navigationController pushViewController:vc animated:YES];
//            break;
//        case 1:
//            vc = [Masonry_CodeViewController new];
//            ((Masonry_CodeViewController *)vc).title = @"Masonry_Code";
//            [self.navigationController pushViewController:vc animated:YES];
//            break;
//        case 2:
//            vc = [DelayMethodViewController new];
//            ((DelayMethodViewController *)vc).title = @"延时方法";
//            [self.navigationController pushViewController:vc animated:YES];
//            break;
//
//        default:
//            break;
//    }
//}
-(void)configSelect:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath{
    NSString *className = self.dataSourceArray[indexPath.row];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *vc = [[class alloc] init];
        vc.title = self.titlesArray[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    //#import "CYLTabBarController.h"
//    [self cyl_popSelectTabBarChildViewControllerAtIndex:1 completion:^(__kindof UIViewController *selectedTabBarChildViewController) {
//        MineViewController *mineViewController = selectedTabBarChildViewController;
//        [mineViewController testPush];
//    }];
//}












@end
