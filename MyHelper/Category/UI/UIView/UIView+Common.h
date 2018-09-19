//
//  UIView+Common.h
//  LzyHelper
//
//  Created by Lzy on 2017/11/11.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Common)
#pragma mark - Property
@property(assign, nonatomic) CGPoint origin;
@property(assign, nonatomic) CGFloat x;
@property(assign, nonatomic) CGFloat y;
@property(assign, nonatomic) CGFloat top;
@property(assign, nonatomic) CGFloat left;
@property(assign, nonatomic) CGFloat bottom;
@property(assign, nonatomic) CGFloat right;
@property(assign, nonatomic) CGSize size;
@property(assign, nonatomic) CGFloat width;
@property(assign, nonatomic) CGFloat height;
@property(assign, nonatomic) CGFloat boundsWidth;
@property(assign, nonatomic) CGFloat boundsHeight;
@property(assign, nonatomic) CGFloat centerX;
@property(assign, nonatomic) CGFloat centerY;
@property(assign, nonatomic) CGFloat maxX;
@property(assign, nonatomic) CGFloat maxY;
@property(readonly, nonatomic) CGFloat screenX;
@property(readonly, nonatomic) CGFloat screenY;
@property(readonly, nonatomic) CGRect screenFrame;

@property(nonatomic) IBInspectable CGFloat cornerRadius;
@property(nonatomic) IBInspectable CGFloat borderWidth;
@property(nonatomic) IBInspectable UIColor *borderColor;
@property(nonatomic) IBInspectable UIColor *shadowColor;
@property(nonatomic) IBInspectable float shadowOpacity;
@property(nonatomic) IBInspectable CGSize shadowOffset;
@property(nonatomic) IBInspectable CGFloat shadowRadius;
@property(nonatomic) IBInspectable BOOL masksToBounds;



#pragma mark - Method
- (UIViewController *)currentController;
/**
 快速创建一个view

 @param frame view的frame
 @param color view的backgroundCloor
 @return 创建好的view
 */
+ (instancetype)viewWithFrame:(CGRect)frame backgroundColor:(UIColor *)color;
/**
 移除所有的子view
 */
- (void)removeAllSubviews;
- (void)removeViewWithTag:(NSInteger)tag;
- (void)setSubScrollsToTop:(BOOL)scrollsToTop;

- (void)doBorderWidth:(CGFloat)width color:(UIColor *)color cornerRadius:(CGFloat)cornerRadius;
- (void)addRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;




typedef NS_ENUM(NSInteger, BadgePositionType) {

    BadgePositionTypeDefault = 0,
    BadgePositionTypeMiddle
};
- (void)addBadgeTip:(NSString *)badgeValue withCenterPosition:(CGPoint)center;
- (void)addBadgeTip:(NSString *)badgeValue;
- (void)addBadgePoint:(NSInteger)pointRadius withPosition:(BadgePositionType)type;
- (void)addBadgePoint:(NSInteger)pointRadius withPointPosition:(CGPoint)point;
- (void)removeBadgePoint;
- (void)removeBadgeTips;


/**
 * Returns a snapshot of the view.
 *
 * This method takes into account the offset of scrollable views and captures whatever is currently
 * in the frame of the view.
 *
 * @param transparent Return a snapshot of the view with transparency if transparent is YES.
 */
- (UIImage *)snapshotWithTransparent:(BOOL)transparent;
/**
 渐变色

 @param cgColorArray 用.CGColor
 */
- (void)addGradientLayerWithColors:(NSArray *)cgColorArray;
- (void)addGradientLayerWithColors:(NSArray *)cgColorArray locations:(NSArray *)floatNumArray startPoint:(CGPoint )aPoint endPoint:(CGPoint)endPoint;

+ (UIView *)lineViewWithPointYY:(CGFloat)pointY andColor:(UIColor *)color andLeftSpace:(CGFloat)leftSpace;
- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andColor:(UIColor *)color andLeftSpace:(CGFloat)leftSpace;






































#pragma mark - mark Debug
+ (void)outputTreeInView:(UIView *)view withSeparatorCount:(NSInteger)count;//输出某个View的subview目录
- (void)outputSubviewTree;//输出子视图的目录树


@end



#pragma mark - LoadingView
@interface LoadingView : UIView
@property(strong, nonatomic) UIImageView *centerView, *loopView;
@property(assign, nonatomic, readonly) BOOL isLoading;

-(void)startAnimating;
-(void)stopAnimating;
@end

typedef NS_ENUM(NSInteger, kBlankPageType)
{
    kBlankPageTypeView = 0,
    kBlankPageTypeActivity,
    kBlankPageTypeTaskResource,
    kBlankPageTypeTask,
    kBlankPageTypeTopic,
    kBlankPageTypeTweet,
    kBlankPageTypeTweetAction,
    kBlankPageTypeTweetOther,
    kBlankPageTypeTweetProject,
    kBlankPageTypeProject,
    kBlankPageTypeProjectOther,
    kBlankPageTypeFileDleted,
    kBlankPageTypeMRForbidden,
    kBlankPageTypeFolderDleted,
    kBlankPageTypePrivateMsg,
    kBlankPageTypeMyWatchedTopic,
    kBlankPageTypeMyJoinedTopic,
    kBlankPageTypeOthersWatchedTopic,
    kBlankPageTypeOthersJoinedTopic,
    kBlankPageTypeFileTypeCannotSupport,
    kBlankPageTypeViewTips,
    kBlankPageTypeShopOrders,
    kBlankPageTypeShopSendOrders,
    kBlankPageTypeShopUnSendOrders,
    kBlankPageTypeNoExchangeGoods,
    kBlankPageTypeProject_ALL,
    kBlankPageTypeProject_CREATE,
    kBlankPageTypeProject_JOIN,
    kBlankPageTypeProject_WATCHED,
    kBlankPageTypeProject_STARED,
    kBlankPageTypeProject_SEARCH,
    kBlankPageTypeTeam,
    kBlankPageTypeFile,
    kBlankPageTypeMessageList,
};
#pragma mark - BlankView
@interface BlankPageView : UIView
@property (strong, nonatomic) UIImageView *centerImgView;
@property (strong, nonatomic) UILabel *tipLabel, *titleLabel;
@property (strong, nonatomic) UIButton *reloadButton, *actionButton;
@property (assign, nonatomic) kBlankPageType curType;
@property (copy, nonatomic) void(^reloadButtonBlock)(id sender);
@property (copy, nonatomic) void(^loadAndShowStatusBlock)(void);
@property (copy, nonatomic) void(^clickButtonBlock)(kBlankPageType curType);
- (void)configWithType:(kBlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError offsetY:(CGFloat)offsetY reloadButtonBlock:(void(^)(id sender))block;
@end




