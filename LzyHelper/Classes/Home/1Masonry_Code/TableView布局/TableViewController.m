//
//  TableViewController.m
//  LzyHelper
//
//  Created by Lzy on 2017/10/27.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import "TableViewController.h"
#import "TableModel.h"

@interface TableViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(strong, nonatomic)UITableView *myTableView;
@property(strong, nonatomic)NSMutableArray *dataSourceArray;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTableView];
}
-(void)configTableView{
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = NO;

    self.dataSourceArray = @[].mutableCopy;

    self.myTableView = [[UITableView alloc] init];
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.view addSubview:self.myTableView];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];

    for (NSUInteger i = 0; i < 10; ++i) {
        TableModel *model = [[TableModel alloc] init];
        model.title = @"测试标题，可能很长很长，反正随便写着先吧！";
        model.desc = @"描述内容通常都是很长很长的，描述内容通常都是很长很长的，描述内容通常都是很长很长的，描述内容通常都是很长很长的，描述内容通常都是很长很长的，描述内容通常都是很长很长的，描述内容通常都是很长很长的，描述内容通常都是很长很长的，描述内容通常都是很长很长的，描述内容通常都是很长很长的，描述内容通常都是很长很长的，";

        [self.dataSourceArray addObject:model];
    }

    [self.myTableView reloadData];
}
#pragma mark - **************** 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CellIdentifier";

    TableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (!cell) {
        cell = [[TableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    cell.indexPath = indexPath;
    cell.block = ^(NSIndexPath *path) {
        [tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
    };
    TableModel *model = [self.dataSourceArray objectAtIndex:indexPath.row];
    [cell configCellWithModel:model];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableModel *model = [self.dataSourceArray objectAtIndex:indexPath.row];

    return [TableCell heightWithModel:model];
}
@end
