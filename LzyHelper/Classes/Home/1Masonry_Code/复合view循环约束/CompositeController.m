//
//  CompositeController.m
//  LzyHelper
//
//  Created by Lzy on 2017/10/27.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import "CompositeController.h"

@interface CompositeController ()
@property(strong, nonatomic)NSMutableArray *viewArray;
@property(assign, nonatomic)BOOL isNormal;
@end

@implementation CompositeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configView];
}
- (NSMutableArray *)viewArray {
    if (_viewArray == nil) {
        _viewArray = [[NSMutableArray alloc] init];
    }

    return _viewArray;
}


-(void)configView{
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = NO;

    self.viewArray = @[].mutableCopy;

    UIView *lastview = self.view;
    for (NSInteger i = 0; i < 6; i++) {
        UIView *view = [UIView new];
        view.backgroundColor = kRandomColor;
        view.layer.borderColor = [UIColor blackColor].CGColor;
        view.layer.borderWidth = 3;
        [self.view addSubview:view];

        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(lastview).insets(UIEdgeInsetsMake(20, 20, 20, 20));
        }];

        lastview = view;
        [self.viewArray addObject:view];

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(onTap)];
        [view addGestureRecognizer:tap];
    }
    self.isNormal = YES;
}
- (void)onTap {
    UIView *lastView = self.view;

    if (self.isNormal) {
        for (NSInteger i = self.viewArray.count - 1; i >= 0; --i) {
            UIView *itemView = self.viewArray[i];
            [itemView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(lastView).insets(UIEdgeInsetsMake(20, 20, 20, 20));
            }];

            // 这样才能实现让子试图显示到前方
            [self.view bringSubviewToFront:itemView];
            lastView = itemView;
        }
    } else {
        for (NSInteger i = 0; i < self.viewArray.count; ++i) {
            UIView *itemView = [self.viewArray objectAtIndex:i];
            [itemView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(lastView).insets(UIEdgeInsetsMake(20, 20, 20, 20));
            }];

            [self.view bringSubviewToFront:itemView];
            lastView = itemView;
        }
    }

    // 突然发现这两句有没有都能实现效果~~~~~
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];


    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.isNormal = !self.isNormal;
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
