//
//  WordCollectionViewCell.m
//  SelfSizingWaterfallCollectionViewLayout
//
//  Created by Adam Waite on 01/10/2014.
//  Copyright (c) 2014 adamjwaite.co.uk. All rights reserved.
//

#import "WordCollectionViewCell.h"

@implementation WordCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
        label.text = @"LabelContent";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = kColorHex(0x777777);
        label.clipsToBounds = YES;
        label.font = [UIFont systemFontOfSize:13];
        label.backgroundColor = [UIColor redColor];
        label.numberOfLines = 0;
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        self.label = label;
    }return self;
}
//- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
//{
//    self.label.preferredMaxLayoutWidth = layoutAttributes.size.width - 16.0f;
//    UICollectionViewLayoutAttributes *preferredAttributes = [layoutAttributes copy];
//    preferredAttributes.size = CGSizeMake(layoutAttributes.size.width, self.label.intrinsicContentSize.height + 16.0f);
//    return preferredAttributes;
//}

@end
