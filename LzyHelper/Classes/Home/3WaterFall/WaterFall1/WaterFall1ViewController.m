//
//  WaterFall1ViewController.m
//  LzyHelper
//
//  Created by Lzy on 2017/11/11.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import "WaterFall1ViewController.h"
#import "JCCollectionViewWaterfallLayout.h"
#import "CollectionViewCell.h"
#import "CollectionReusableView.h"


@interface WaterFall1ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property(strong, nonatomic)UICollectionView *myCollectionView;
@property(strong, nonatomic)NSMutableArray *dataSourceArray;
@property(strong, nonatomic)UIActivityIndicatorView *activityView;

@end

@implementation WaterFall1ViewController
static NSString * const reuseHeaderId = @"headerId";
static NSString * const reuseFooterId = @"footerId";
static NSString * const reuseCellId = @"cellId";


- (void)viewDidLoad {
    [super viewDidLoad];
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.activityView];


    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    self.dataSourceArray = [NSMutableArray new];

    [self configMyCollectionView];
    [self configRefresh];
}

-(void)configMyCollectionView{
    JCCollectionViewWaterfallLayout *layout = [[JCCollectionViewWaterfallLayout alloc] init];
    layout.headerHeight = 44.0f;
    layout.footerHeight = 44.0f;


    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:reuseCellId];
    [collectionView registerClass:[CollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeaderId];
     [collectionView registerClass:[CollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reuseFooterId];

    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.myCollectionView = collectionView;
}
-(void)configRefresh{
    // 为瀑布流控件添加下拉加载和上拉加载
    self.myCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 模拟网络请求延迟
            [self serveData];
            // 清空数据
            //            [self.shops removeAllObjects];
            //
            //            [self.shops addObjectsFromArray:[self newShops]];

            // 刷新数据
            [self.myCollectionView reloadData];

            // 停止刷新
            [self.myCollectionView.mj_header endRefreshing];
        });
    }];
    // 第一次进入则自动加载
    [self.myCollectionView.mj_header beginRefreshing];
    self.myCollectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 模拟网络请求延迟
            //            [self.shops addObjectsFromArray:[self moreShopsWithCurrentPage:self.currentPage]];
            // 刷新数据
            [self.myCollectionView reloadData];
            // 停止刷新
            [self.myCollectionView.mj_footer endRefreshing];
        });
    }];
}

-(void)serveData{
    [self.activityView startAnimating];

    NSString *url = [@"http://image.haosou.com/j?q=beijing&pn=20" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/javascript"];
    [session GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.activityView stopAnimating];
        self.dataSourceArray = [NSMutableArray arrayWithArray:responseObject[@"list"]];
        [self.myCollectionView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.activityView stopAnimating];

        NSLog(@"error - %@", [error localizedDescription]);
    }];
}






#pragma mark - CollectionView
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout columnCountForSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    else {
        return 3;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if([kind isEqual:UICollectionElementKindSectionHeader]){
        CollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseHeaderId forIndexPath:indexPath];
        headerView.label.text = @"===== header =====";

        return headerView;
    }
    else {
        CollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseFooterId forIndexPath:indexPath];
        footerView.label.text = @"===== footer =====";

        return footerView;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = self.dataSourceArray[indexPath.row];
    return CGSizeMake([dict[@"width"] floatValue], [dict[@"height"] floatValue]);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseCellId forIndexPath:indexPath];
    [cell.imageView setImageWithURL:[NSURL URLWithString:self.dataSourceArray[indexPath.row][@"thumb"]]];
    return cell;
}
@end
