//
//  WaterFall2ViewController.m
//  LzyHelper
//
//  Created by Lzy on 2017/11/11.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import "WaterFall2ViewController.h"
#import "CollectionViewCell.h"
#import "CollectionReusableView.h"
#import "SelfSizingWaterfallCollectionViewLayout.h"
//#import "WordCollectionViewHeader.h"
#import "WordCollectionViewCell.h"
#import "CollectionReusableView.h"


@interface WaterFall2ViewController ()<SelfSizingWaterfallCollectionViewLayoutDelegate, UICollectionViewDataSource>
@property(strong, nonatomic)UICollectionView *myCollectionView;
@property(strong, nonatomic)NSMutableArray *dataSourceArray;
@property(strong, nonatomic)UIActivityIndicatorView *activityView;

@end

@implementation WaterFall2ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Refresh" style:UIBarButtonItemStylePlain target:self action:@selector(actionRefresh:)];
    
    [self actionRefresh:nil];
    [self configMyCollectionView];
}

#pragma mark UI
-(void)configRefresh{
    // 为瀑布流控件添加下拉加载和上拉加载
    self.myCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 模拟网络请求延迟
            
            //            // 清空数据
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
-(void)configMyCollectionView{
    SelfSizingWaterfallCollectionViewLayout *layout = [[SelfSizingWaterfallCollectionViewLayout alloc] init];

    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerClass:[WordCollectionViewCell class] forCellWithReuseIdentifier:@"WordCell"];
    [collectionView registerClass:[CollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WordHeader"];
//    [collectionView registerClass:[CollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reuseFooterId];

    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.myCollectionView = collectionView;
}



#pragma mark - Action
- (void)actionRefresh:(id)sender{
    if (!self.dataSourceArray) {
        self.dataSourceArray = [NSMutableArray array];
    }

    NSUInteger randomNumberOfSections =  (arc4random() % 10) + 1;
    for (NSUInteger sectIdx = 0; sectIdx < randomNumberOfSections; sectIdx++) {
        self.dataSourceArray[sectIdx] = [NSMutableArray array];
        NSUInteger randomNumberOfItems = (arc4random() % 21) + 1;
        for (NSUInteger itemIdx = 0; itemIdx < randomNumberOfItems; itemIdx++) {
            [self.dataSourceArray[sectIdx] addObject:[NSString randomStr]];
        }
    }

    [self.myCollectionView reloadData];
}
#pragma mark Cell Data
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    [super traitCollectionDidChange:previousTraitCollection];
    [self.myCollectionView reloadData];
}

#pragma mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataSourceArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.dataSourceArray[section] count];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
     CollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WordHeader" forIndexPath:indexPath];
    reusableView.label.text = [NSString stringWithFormat:@"Section %@", @(indexPath.section + 1)];
    return reusableView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WordCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WordCell" forIndexPath:indexPath];
    cell.label.text = self.dataSourceArray[indexPath.section][indexPath.item];
    return cell;
}

#pragma mark SelfSizingWaterfallCollectionViewLayoutDelegate
- (NSUInteger)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout numberOfColumnsInSection:(NSUInteger)section{
    NSUInteger compactColumns = 2;
    if (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular) {
        return compactColumns + 1;
    }

    return compactColumns;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout estimatedHeightForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self.dataSourceArray[indexPath.section][indexPath.item] heightWithFont:13 width:kScreen_Width - 32];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSUInteger)section{
    return CGSizeMake(CGRectGetWidth(collectionView.frame), 80.0f);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(16.0f, 16.0f, 16.0f, 16.0f);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 8.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 8.0f;
}
@end
