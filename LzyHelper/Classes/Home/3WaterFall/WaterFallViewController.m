//
//  WaterFallViewController.m
//  LzyHelper
//
//  Created by Lzy on 2017/11/10.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import "WaterFallViewController.h"

@interface WaterFallViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(strong, nonatomic)UITableView *myTableView;
@property(strong, nonatomic)NSMutableArray *dataSourceArray;
@property(strong, nonatomic)NSMutableArray *titlesArray;

@end

@implementation WaterFallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSourceArray = @[].mutableCopy;
    self.titlesArray = @[].mutableCopy;
    // 利用class的好处，不用导入这么多头文件了
    [self addCell:@"瀑布流1" class:@"WaterFall1ViewController"];
    [self addCell:@"瀑布流2" class:@"WaterFall2ViewController"];
    [self addCell:@"瀑布流3" class:@"WaterFall3ViewController"];


    [self configTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UI
-(void)configTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [[cell textLabel] setText:[NSString stringWithFormat:@"%@：%@%@", @(indexPath.row),[self.titlesArray objectAtIndex:indexPath.row],[self.dataSourceArray objectAtIndex:indexPath.row]]];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self configSelect:tableView forIndexPath:indexPath];
}
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

@end
