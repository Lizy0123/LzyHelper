//
//  Masonry_AutoLayoutViewController.m
//  LzyHelper
//
//  Created by Lzy on 2017/10/26.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import "Masonry_AutoLayoutViewController.h"
#import "AbreastLabelViewController.h"



@interface Masonry_AutoLayoutViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(strong, nonatomic)UITableView *myTableView;
@property(strong, nonatomic)NSMutableArray *dataSourceArray;

@end

@implementation Masonry_AutoLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSMutableArray *)dataSourceArray{
    if (!_dataSourceArray) {
        _dataSourceArray = [[NSMutableArray alloc] initWithArray:@[@"并排Label自适应",@"FixedSize：固定尺寸的约束",@"RelativeConstraint相对约束",@"AnimationConstraint动画约束"]];
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
    [self configSelect:tableView forIndexPath:indexPath];
}
-(void)configSelect:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = nil;
    switch (indexPath.row) {
        case 0:
            // viewController.hidesBottomBarWhenPushed = YES;
            // This property needs to be set before pushing viewController to the navigationController's stack. Meanwhile as it is all base on BaseNavigationController, there is no need to do this.
            vc = [AbreastLabelViewController new];
            ((AbreastLabelViewController *)vc).title = @"并排label自适应";
            [self.navigationController pushViewController:vc animated:YES];
            break;
        case 1:
//            vc = [Masonry_FixedSizeViewController new];
//            ((Masonry_FixedSizeViewController *)vc).title = @"固定尺寸的约束";
//            [self.navigationController pushViewController:vc animated:YES];
            break;
        case 2:
//            vc = [Masonry_RelativeConstraintViewController new];
//            ((Masonry_RelativeConstraintViewController *)vc).title = @"相对约束";
//            [self.navigationController pushViewController:vc animated:YES];
            break;
        case 3:
//            vc = [Masonry_AnimationConstraintViewController new];
//            ((Masonry_AnimationConstraintViewController *)vc).title = @"动画约束";
//            [self.navigationController pushViewController:vc animated:YES];
            break;
        case 4:

            break;

        default:
            break;
    }
}


@end
