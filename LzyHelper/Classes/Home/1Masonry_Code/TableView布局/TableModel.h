//
//  TableModel.h
//  LzyHelper
//
//  Created by Lzy on 2017/10/27.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableModel : NSObject
@property(copy, nonatomic)NSString *title;
@property(copy, nonatomic)NSString *desc;
@property(assign, nonatomic)BOOL isExpanded;
@end

typedef void(^TableBlock)(NSIndexPath *indexPath);
@interface TableCell : UITableViewCell
@property(strong, nonatomic)UILabel *titleLabel;
@property(strong, nonatomic)UILabel *descLabel;
@property(strong, nonatomic)NSIndexPath *indexPath;
@property(copy, nonatomic)TableBlock block;

-(void)configCellWithModel:(TableModel *)model;
+(CGFloat)heightWithModel:(TableModel *)model;
@end
