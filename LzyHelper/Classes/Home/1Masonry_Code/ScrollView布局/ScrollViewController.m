//
//  ScrollViewController.m
//  LzyHelper
//
//  Created by Lzy on 2017/10/26.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import "ScrollViewController.h"

@interface ScrollViewController ()
@property(strong, nonatomic)UIScrollView *scrollView;
@end

@implementation ScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    [self configScrollView];
}

-(void)configScrollView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = NO;
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.pagingEnabled = NO;
    scrollView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;

    UILabel *lastLabel = nil;
    for (NSUInteger i = 0; i< 20; ++i) {
        UILabel *label = [UILabel new];
        label.numberOfLines = 0;
        label.layer.borderColor = [UIColor greenColor].CGColor;
        label.layer.borderWidth = 2.0f;
        label.textColor = kRandomColor;
        label.textAlignment = NSTextAlignmentLeft;
        label.text = [self randomText];
        [self.scrollView addSubview:label];

        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(self.view).offset(-15);

            if (lastLabel) {
                make.top.mas_equalTo(lastLabel.mas_bottom).offset(20);
            } else {
                make.top.mas_equalTo(self.scrollView).offset(20);
            }
        }];
        lastLabel = label;
    }
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);

        // 让scrollview的contentSize随着内容的增多而变化
        make.bottom.mas_equalTo(lastLabel.mas_bottom).offset(20);
    }];





}
-(NSString *)randomText{
    CGFloat length = arc4random()% 27 +5;
    NSMutableString * str = [NSMutableString new];
    for (NSInteger i =  0; i< length; ++i) {
        [str appendString:@"Hello World 0123 你好"];
    }return str;
}

@end
