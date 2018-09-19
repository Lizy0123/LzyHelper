//
//  CollectionViewCell.m
//  LzyHelper
//
//  Created by Lzy on 2017/11/11.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.imageView = [UIImageView new];
        [self.contentView addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }return self;
}
@end
