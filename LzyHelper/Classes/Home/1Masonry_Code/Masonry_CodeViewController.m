//
//  Masonry_CodeViewController.m
//  LzyHelper
//
//  Created by Lzy on 2017/10/26.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import "Masonry_CodeViewController.h"



@interface Masonry_CodeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(strong, nonatomic)UITableView *myTableView;
@property(strong, nonatomic)NSMutableArray *dataSourceArray;
@property(strong, nonatomic)NSMutableArray *titlesArray;
@end

@implementation Masonry_CodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSourceArray = @[].mutableCopy;
    self.titlesArray = @[].mutableCopy;
    // 利用class的好处，不用导入这么多头文件了
    [self addCell:@"基本演示" class:@"BasicController"];
    [self addCell:@"Label自适应" class:@"Masonry_LabelViewController"];

    [self addCell:@"更新约束" class:@"UpdateConstraintsController"];
    [self addCell:@"更新约束键盘" class:@"UpdateConstraintKeyboardViewController"];

    [self addCell:@"动画重新添加约束" class:@"RemakeContraintsController"];
    [self addCell:@"整体动画更新约束" class:@"TotalUpdateController"];
    [self addCell:@"复合view循环约束" class:@"CompositeController"];
    [self addCell:@"约束百分比" class:@"AspectFitController"];
    [self addCell:@"基本动画" class:@"BasicAnimatedController"];
    [self addCell:@"ScrollView布局" class:@"ScrollViewController"];
    [self addCell:@"复杂ScrollView布局" class:@"ScrollViewComplexController"];

    [self addCell:@"TableView布局" class:@"TableViewController"];
    [self addCell:@"TableView头脚视图布局" class:@"HeaderFooterViewController"];
    
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
