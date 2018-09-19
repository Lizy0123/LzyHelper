//
//  UIView+PressMenu.h
//  LzyHelper
//
//  Created by Lzy on 2017/11/11.
//  Copyright © 2017年 Lzy. All rights reserved.
//
/*
 NSArray *menuTitles;
 if ([curCommentItem.author.global_key isEqualToString:[Login curLoginUser].global_key]) {
 menuTitles = @[@"拷贝文字", @"删除"];
 } else {
 menuTitles = @[@"拷贝文字", @"回复"];
 }
 __weak typeof(self) weakSelf = self;
 [cell.contentView showMenuTitles:menuTitles menuClickedBlock:^(NSInteger index, NSString *title) {
 if ([title hasPrefix:@"拷贝"]) {
 [[UIPasteboard generalPasteboard] setString:curCommentItem.content];
 } else if ([title isEqualToString:@"删除"]){
 [weakSelf deleteComment:curCommentItem];
 } else if ([title isEqualToString:@"回复"]){
 [weakSelf goToAddCommentVCToUser:curCommentItem.author.name];
 }
 }];

 */

/*
 @weakify(self);
 [self addPressMenuTitles:@[@"删除"] menuClickedBlock:^(NSInteger index, NSString *title) {
 @strongify(self);
 if (self.deleteBlock) {
 self.deleteBlock(self.curTag);
 }
 }];
 self.pressGR.minimumPressDuration = 0.2;//菜单更易弹出
 */
#import <UIKit/UIKit.h>

@interface UIView (PressMenu)
@property (strong, nonatomic) NSArray *menuTitles;
@property (strong, nonatomic) UILongPressGestureRecognizer *pressGR;
@property (copy, nonatomic) void(^menuClickedBlock)(NSInteger index, NSString *title);
@property (strong, nonatomic) UIMenuController *menuVC;

- (void)addPressMenuTitles:(NSArray *)menuTitles menuClickedBlock:(void(^)(NSInteger index, NSString *title))block;
- (void)showMenuTitles:(NSArray *)menuTitles menuClickedBlock:(void(^)(NSInteger index, NSString *title))block;

- (BOOL)isMenuVCVisible;
- (void)removePressMenu;
@end
