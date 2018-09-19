//
//  UIView+Common.m
//  LzyHelper
//
//  Created by Lzy on 2017/11/11.
//  Copyright © 2017年 Lzy. All rights reserved.
//
#define kTagBadgeView  1000
#define kTagBadgePointView  1001
#define kTagLineView 1007

#import "UIView+Common.h"
#import "MyGifImageView.h"
#import "UIBadgeView.h"


@implementation UIView (Common)
@dynamic borderColor,borderWidth,cornerRadius, masksToBounds;


- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
- (CGPoint)origin{
    return self.frame.origin;
}

- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)x{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)y{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)t{
    self.frame = CGRectMake(self.left, t, self.width, self.height);
}
- (CGFloat)top{
    return self.frame.origin.y;
}

- (void)setLeft:(CGFloat)l{
    self.frame = CGRectMake(l, self.top, self.width, self.height);
}
- (CGFloat)left{
    return self.frame.origin.x;
}

- (void)setBottom:(CGFloat)b{
    self.frame = CGRectMake(self.left, b - self.height, self.width, self.height);
}
- (CGFloat)bottom{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setRight:(CGFloat)r{
    self.frame = CGRectMake(r - self.width, self.top, self.width, self.height);
}
- (CGFloat)right{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGSize)size{
    return self.frame.size;
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGFloat)height{
    return self.frame.size.height;
}

-(void)setBoundsWidth:(CGFloat)boundsWidth{
    CGRect bounds = self.bounds;
    bounds.size.width = boundsWidth;
    self.bounds = bounds;
}
-(CGFloat)boundsWidth{
    return self.bounds.size.width;
}

-(void)setBoundsHeight:(CGFloat)boundsHeight{
    CGRect bounds = self.bounds;
    bounds.size.height = boundsHeight;
    self.bounds = bounds;
}
-(CGFloat)boundsHeight{
    return self.bounds.size.height;
}

- (void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
- (CGFloat)centerX{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
- (CGFloat)centerY{
    return self.center.y;
}

- (void)setMaxX:(CGFloat)maxX{
    CGRect frame = self.frame;
    frame.origin.x = maxX - frame.size.width;
    self.frame = frame;
}
- (CGFloat)maxX{
    return CGRectGetMaxX(self.frame);
}

- (void)setMaxY:(CGFloat)maxY{
    CGRect frame = self.frame;
    frame.origin.y = maxY - frame.size.height;
    self.frame = frame;
}
- (CGFloat)maxY{
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)screenX {
    CGFloat x = 0.0f;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;

        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            x -= scrollView.contentOffset.x;
        }
    }

    return x;
}
- (CGFloat)screenY {
    CGFloat y = 0.0f;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;

        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            y -= scrollView.contentOffset.y;
        }
    }
    return y;
}

- (CGRect)screenFrame {
    return CGRectMake(self.screenX, self.screenY, self.width, self.height);
}

- (void)setCornerRadius:(CGFloat)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = !!cornerRadius;
}
- (CGFloat)cornerRadius{
    return self.layer.cornerRadius;
}

- (void)setBorderWidth:(CGFloat)borderWidth{
    self.layer.borderWidth = borderWidth;
}
- (CGFloat)borderWidth{
    return self.layer.borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = borderColor.CGColor;
}
- (UIColor *)borderColor{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setShadowColor:(UIColor *)shadowColor{
    self.layer.shadowColor = shadowColor.CGColor;
}
- (UIColor *)shadowColor{
    return [UIColor colorWithCGColor:self.layer.shadowColor];
}

- (void)setShadowOpacity:(float)shadowOpacity{
    self.layer.shadowOpacity = shadowOpacity;
}
- (float)shadowOpacity{
    return self.layer.shadowOpacity;
}

- (void)setShadowOffset:(CGSize)shadowOffset{
    self.layer.shadowOffset = shadowOffset;
}
- (CGSize)shadowOffset{
    return self.layer.shadowOffset;
}

- (void)setShadowRadius:(CGFloat)shadowRadius{
    self.layer.shadowRadius = shadowRadius;
}
- (CGFloat)shadowRadius{
    return self.layer.shadowRadius;
}

- (void)setMasksToBounds:(BOOL)masksToBounds{
    [self.layer setMasksToBounds:masksToBounds];
}
- (BOOL)masksToBounds{
    return self.layer.masksToBounds;
}










#pragma mark - Method
- (UIViewController *)currentController{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

+ (instancetype)viewWithFrame:(CGRect)frame backgroundColor:(UIColor *)color{
    UIView *view = [[[self class] alloc] initWithFrame:frame];
    view.backgroundColor = color;
    return view;
}
- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView *child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}
- (void)removeViewWithTag:(NSInteger)tag{
    for (UIView *aView in [self subviews]) {
        if (aView.tag == tag) {
            [aView removeFromSuperview];
        }
    }
}
- (void)setSubScrollsToTop:(BOOL)scrollsToTop{
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIScrollView class]]) {
            [(UIScrollView *)obj setScrollEnabled:scrollsToTop];
            *stop = YES;
        }
    }];
}

- (void)doBorderWidth:(CGFloat)width color:(UIColor *)color cornerRadius:(CGFloat)cornerRadius{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderWidth = width;
    if (!color) {
        self.layer.borderColor = [UIColor blackColor].CGColor;
    }else{
        self.layer.borderColor = color.CGColor;
    }
}
- (void)addRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [CAShapeLayer new];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)addBadgeTip:(NSString *)badgeValue withCenterPosition:(CGPoint)center{
    if (!badgeValue || !badgeValue.length) {
        [self removeBadgeTips];
    }else{
        UIView *badgeV = [self viewWithTag:kTagBadgeView];
        if (badgeV && [badgeV isKindOfClass:[UIBadgeView class]]) {
            [(UIBadgeView *)badgeV setBadgeValue:badgeValue];
            badgeV.hidden = NO;
        }else{
            badgeV = [UIBadgeView viewWithBadgeTip:badgeValue];
            badgeV.tag = kTagBadgeView;
            [self addSubview:badgeV];
        }
        [badgeV setCenter:center];
    }
}
- (void)addBadgeTip:(NSString *)badgeValue{
    if (!badgeValue || !badgeValue.length) {
        [self removeBadgeTips];
    }else{
        UIView *badgeV = [self viewWithTag:kTagBadgeView];
        if (badgeV && [badgeV isKindOfClass:[UIBadgeView class]]) {
            [(UIBadgeView *)badgeV setBadgeValue:badgeValue];
        }else{
            badgeV = [UIBadgeView viewWithBadgeTip:badgeValue];
            badgeV.tag = kTagBadgeView;
            [self addSubview:badgeV];
        }
        CGSize badgeSize = badgeV.frame.size;
        CGSize selfSize = self.frame.size;
        CGFloat offset = 2.0;
        [badgeV setCenter:CGPointMake(selfSize.width- (offset+badgeSize.width/2), (offset +badgeSize.height/2))];
    }
}
- (void)addBadgePoint:(NSInteger)pointRadius withPosition:(BadgePositionType)type {

    if(pointRadius < 1)
        return;

    [self removeBadgePoint];

    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = kTagBadgePointView;
    badgeView.layer.cornerRadius = pointRadius;
    badgeView.backgroundColor = [UIColor redColor];

    switch (type) {

        case BadgePositionTypeMiddle:
            badgeView.frame = CGRectMake(0, self.frame.size.height / 2 - pointRadius, 2 * pointRadius, 2 * pointRadius);
            break;

        default:
            badgeView.frame = CGRectMake(self.frame.size.width - 2 * pointRadius, 0, 2 * pointRadius, 2 * pointRadius);
            break;
    }

    [self addSubview:badgeView];
}
- (void)addBadgePoint:(NSInteger)pointRadius withPointPosition:(CGPoint)point {

    if(pointRadius < 1)
        return;

    [self removeBadgePoint];

    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = kTagBadgePointView;
    badgeView.layer.cornerRadius = pointRadius;
    badgeView.backgroundColor = kColorHex(0xf75388);
    badgeView.frame = CGRectMake(0, 0, 2 * pointRadius, 2 * pointRadius);
    badgeView.center = point;
    [self addSubview:badgeView];
}
- (void)removeBadgePoint {

    for (UIView *subView in self.subviews) {

        if(subView.tag == kTagBadgePointView)
            [subView removeFromSuperview];
    }
}
- (void)removeBadgeTips{
    NSArray *subViews =[self subviews];
    if (subViews && [subViews count] > 0) {
        for (UIView *aView in subViews) {
            if (aView.tag == kTagBadgeView && [aView isKindOfClass:[UIBadgeView class]]) {
                aView.hidden = YES;
            }
        }
    }
}
- (void)addGradientLayerWithColors:(NSArray *)cgColorArray{
    [self addGradientLayerWithColors:cgColorArray locations:nil startPoint:CGPointMake(0.0, 0.5) endPoint:CGPointMake(1.0, 0.5)];
}
- (void)addGradientLayerWithColors:(NSArray *)cgColorArray locations:(NSArray *)floatNumArray startPoint:(CGPoint )startPoint endPoint:(CGPoint)endPoint{
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = self.bounds;
    if (cgColorArray && [cgColorArray count] > 0) {
        layer.colors = cgColorArray;
    }else{
        return;
    }
    if (floatNumArray && [floatNumArray count] == [cgColorArray count]) {
        layer.locations = floatNumArray;
    }
    layer.startPoint = startPoint;
    layer.endPoint = endPoint;
    [self.layer addSublayer:layer];
}






















- (UIImage *)snapshotWithTransparent:(BOOL)transparent {
    // Passing 0 as the last argument ensures that the image context will match the current device's
    // scaling mode.
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, !transparent, 0);

    CGContextRef cx = UIGraphicsGetCurrentContext();
    // Views that can scroll do so by modifying their bounds. We want to capture the part of the view
    // that is currently in the frame, so we offset by the bounds of the view accordingly.
    CGContextTranslateCTM(cx, -self.bounds.origin.x, -self.bounds.origin.y);
    [self.layer renderInContext:cx];

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIView *)lineViewWithPointYY:(CGFloat)pointY andColor:(UIColor *)color andLeftSpace:(CGFloat)leftSpace{
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(leftSpace, pointY, kScreen_Width - leftSpace, 0.5)];
    lineView.backgroundColor = color;
    return lineView;
}
- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andColor:(UIColor *)color andLeftSpace:(CGFloat)leftSpace{
    [self removeViewWithTag:kTagLineView];
    if (hasUp) {
        UIView *upView = [UIView lineViewWithPointYY:0 andColor:color andLeftSpace:leftSpace];
        upView.tag = kTagLineView;
        [self addSubview:upView];
    }
    if (hasDown) {
        UIView *downView = [UIView lineViewWithPointYY:CGRectGetMaxY(self.bounds)-0.5 andColor:color andLeftSpace:leftSpace];
        downView.tag = kTagLineView;
        [self addSubview:downView];
    }
}






















#pragma mark - Debug
+ (void)outputTreeInView:(UIView *)view withSeparatorCount:(NSInteger)count{
    NSString *outputStr = @"";
    outputStr = [outputStr stringByReplacingCharactersInRange:NSMakeRange(0, count) withString:@"-"];
    outputStr = [outputStr stringByAppendingString:view.description];
    printf("%s\n", outputStr.UTF8String);

    if (view.subviews.count == 0) {
        return;
    }else{
        count++;
        for (UIView *subV in view.subviews) {
            [self outputTreeInView:subV withSeparatorCount:count];
        }
    }
}

- (void)outputSubviewTree{
    [UIView outputTreeInView:self withSeparatorCount:0];
}










@end








#pragma mark - LoadingView
@interface LoadingView ()
@property (nonatomic, assign) CGFloat loopAngle, centerViewAlpha, angleStep, alphaStep;
@end
@implementation LoadingView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _centerView = [MyGifImageView new];
        _centerView.image = [MyGifImage imageNamed:@"loading_monkey@2x.gif"];
        [self addSubview:_centerView];
        [_centerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).offset(-30);
            make.size.mas_equalTo(CGSizeMake(100, 100));
        }];

//        _loopView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading_loop"]];
//        _centerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading_monkey"]];
//        [_loopView setCenter:self.center];
//        [_centerView setCenter:self.center];
//        [self addSubview:_loopView];
//        [self addSubview:_centerView];
//        [_loopView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.center.equalTo(self);
//        }];
//        [_centerView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.center.equalTo(self);
//        }];
//
//        _loopAngle = 0.0;
//        _monkeyAlpha = 1.0;
//        _angleStep = 360/3;
//        _alphaStep = 1.0/3.0;
    }
    return self;
}
- (void)startAnimating{
    self.hidden = NO;
    if (_isLoading) {
        return;
    }
    _isLoading = YES;
    //    [self loadingAnimation];
}
- (void)stopAnimating{
    self.hidden = YES;
    _isLoading = NO;
}
- (void)loadingAnimation{
    static CGFloat duration = 0.25f;
    _loopAngle += _angleStep;
    if (_centerViewAlpha >= 1.0 || _centerViewAlpha <= 0.0) {
        _alphaStep = -_alphaStep;
    }
    _centerViewAlpha += _alphaStep;
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        CGAffineTransform loopAngleTransform = CGAffineTransformMakeRotation(_loopAngle * (M_PI / 180.0f));
        _loopView.transform = loopAngleTransform;
        _centerView.alpha = _centerViewAlpha;
    } completion:^(BOOL finished) {
        if (_isLoading && [self superview] != nil) {
            [self loadingAnimation];
        }else{
            [self removeFromSuperview];

            _loopAngle = 0.0;
            _centerViewAlpha = 1.0;
            _alphaStep = ABS(_alphaStep);
            CGAffineTransform loopAngleTransform = CGAffineTransformMakeRotation(_loopAngle * (M_PI / 180.0f));
            _loopView.transform = loopAngleTransform;
            _centerView.alpha = _centerViewAlpha;
        }
    }];
}
@end


#pragma mark - BlankView
@implementation BlankPageView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)configWithType:(kBlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError offsetY:(CGFloat)offsetY reloadButtonBlock:(void (^)(id))block{
    _curType = blankPageType;
    _reloadButtonBlock = block;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_loadAndShowStatusBlock) {
            _loadAndShowStatusBlock();
        }
    });

    if (hasData) {
        [self removeFromSuperview];
        return;
    }
    self.alpha = 1.0;
    //    图片
    if (!_centerImgView) {
        _centerImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _centerImgView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_centerImgView];
    }
    //    标题
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = kColorHex(0x425063);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    //    文字
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _tipLabel.backgroundColor = [UIColor clearColor];
        _tipLabel.numberOfLines = 0;
        _tipLabel.font = [UIFont systemFontOfSize:14];
        _tipLabel.textColor = kColorHex(0x76808E);
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_tipLabel];
    }
    //    按钮
    if (!_actionButton) {//新增按钮
        _actionButton = ({
            UIButton *button = [UIButton new];
            button.backgroundColor =kColorHex(0x425063);
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            [button addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
            button.layer.cornerRadius = 4;
            button.layer.masksToBounds = YES;
            button;
        });
        [self addSubview:_actionButton];
    }
    if (!_reloadButton) {//重新加载按钮
        _reloadButton = ({
            UIButton *button = [UIButton new];
            button.backgroundColor = kColorHex(0x425063);
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            [button addTarget:self action:@selector(reloadButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            button.layer.cornerRadius = 4;
            button.layer.masksToBounds = YES;
            button;
        });
        [self addSubview:_reloadButton];
    }
    NSString *imageName, *titleStr, *tipStr;
    NSString *buttonTitle;
    if (hasError) {
        //        加载失败
        _actionButton.hidden = YES;

        tipStr = @"呀，网络出了问题";
        imageName = @"blankpage_image_LoadFail";
        buttonTitle = @"重新连接网络";
    }else{
        //        空白数据
        _reloadButton.hidden = YES;

        switch (_curType) {
            case kBlankPageTypeTaskResource: {
                tipStr = @"暂无关联资源";
            }
                break;
            case kBlankPageTypeActivity://项目动态
            {
                imageName = @"blankpage_image_Activity";
                tipStr = @"当前项目暂无相关动态";
            }
                break;
            case kBlankPageTypeTask://任务列表
            {
                imageName = @"blankpage_image_Task";
                tipStr = @"这里还没有任务哦";
            }
                break;
            case kBlankPageTypeTopic://讨论列表
            {
                imageName = @"blankpage_image_Topic";
                tipStr = @"这里还没有讨论哦";
            }
                break;
            case kBlankPageTypeTweet://冒泡列表（自己的）
            {
                imageName = @"blankpage_image_Tweet";
                tipStr = @"您还没有发表过冒泡呢～";
            }
                break;
            case kBlankPageTypeTweetAction://冒泡列表（自己的）。有发冒泡的按钮
            {
                imageName = @"blankpage_image_Tweet";
                tipStr = @"您还没有发表过冒泡呢～";
                buttonTitle = @"冒个泡吧";
            }
                break;
            case kBlankPageTypeTweetOther://冒泡列表（别人的）
            {
                imageName = @"blankpage_image_Tweet";
                tipStr = @"这里还没有冒泡哦～";
            }
                break;
            case kBlankPageTypeTweetProject://冒泡列表（项目内的）
            {
                imageName = @"blankpage_image_Notice";
                tipStr = @"当前项目没有公告哦～";
            }
                break;
            case kBlankPageTypeProject://项目列表（自己的）
            {
                imageName = @"blankpage_image_Project";
                titleStr = @"欢迎来到 Coding";
                tipStr = @"协作从项目开始，赶快创建项目吧";
            }
                break;
            case kBlankPageTypeProjectOther://项目列表（别人的）
            {
                imageName = @"blankpage_image_Project";
                tipStr = @"这里还没有项目哦";
            }
                break;
            case kBlankPageTypeFileDleted://去了文件页面，发现文件已经被删除了
            {
                tipStr = @"晚了一步，此文件刚刚被人删除了～";
            }
                break;
            case kBlankPageTypeMRForbidden://去了MR页面，发现没有权限
            {
                tipStr = @"抱歉，请联系项目管理员进行代码权限设置";
            }
                break;
            case kBlankPageTypeFolderDleted://文件夹
            {
                tipStr = @"晚了一步，此文件夹刚刚被人删除了～";
            }
                break;
            case kBlankPageTypePrivateMsg://私信列表
            {
                imageName = @"";//就是空
                tipStr = @"";
            }
                break;
            case kBlankPageTypeMyJoinedTopic://我参与的话题
            {
                imageName = @"blankpage_image_Tweet";
                tipStr = @"您还没有参与过话题讨论呢～";
            }
                break;
            case kBlankPageTypeMyWatchedTopic://我关注的话题
            {
                imageName = @"blankpage_image_Tweet";
                tipStr = @"您还没有关注过话题讨论呢～";
            }
                break;
            case kBlankPageTypeOthersJoinedTopic://ta参与的话题
            {
                imageName = @"blankpage_image_Tweet";
                tipStr = @"Ta 还没有参与过话题讨论呢～";
            }
                break;
            case kBlankPageTypeOthersWatchedTopic://ta关注的话题
            {
                imageName = @"blankpage_image_Tweet";
                tipStr = @"Ta 还没有关注过话题讨论呢～";
            }
                break;
            case kBlankPageTypeFileTypeCannotSupport:
            {
                tipStr = @"还不支持查看此类型的文件呢";
            }
                break;
            case kBlankPageTypeViewTips:
            {
                imageName = @"blankpage_image_Tip";
                tipStr = @"您还没有收到通知哦";
            }
                break;
            case kBlankPageTypeShopOrders:
            {
                imageName = @"blankpage_image_ShopOrder";
                tipStr = @"还没有订单记录～";
            }
                break;
            case kBlankPageTypeShopSendOrders:
            {
                imageName = @"blankpage_image_ShopOrder";
                tipStr = @"没有已发货的订单记录～";
            }
                break;
            case kBlankPageTypeShopUnSendOrders:
            {
                imageName = @"blankpage_image_ShopOrder";
                tipStr = @"没有未发货的订单记录～";
            }
                break;
            case kBlankPageTypeNoExchangeGoods:{
                tipStr = @"还没有可兑换的商品呢～";
            }
                break;
            case kBlankPageTypeProject_ALL:
            case kBlankPageTypeProject_CREATE:
            case kBlankPageTypeProject_JOIN:{
                imageName = @"blankpage_image_Project";
                titleStr = @"欢迎来到 Coding";
                tipStr = @"协作从项目开始，赶快创建项目吧";
                buttonTitle=@"创建项目";
            }
                break;
            case kBlankPageTypeProject_WATCHED:{
                imageName = @"blankpage_image_Project";
                tipStr = @"您还没有关注过项目呢～";
                buttonTitle=@"去关注";
            }
                break;
            case kBlankPageTypeProject_STARED:{
                imageName = @"blankpage_image_Project";
                tipStr = @"您还没有收藏过项目呢～";
                buttonTitle=@"去收藏";
            }
                break;
            case kBlankPageTypeProject_SEARCH:{
                tipStr = @"什么都木有搜到，换个词再试试？";
            }
                break;
            case kBlankPageTypeTeam:{
                imageName = @"blankpage_image_Team";
                tipStr = @"您还没有参与过团队哦～";
            }
                break;
            case kBlankPageTypeFile:{
                imageName = @"blankpage_image_File";
                tipStr = @"这里还没有任何文件～";
            }
                break;
            case kBlankPageTypeMessageList:{
                imageName = @"blankpage_image_MessageList";
                tipStr = @"还没有新消息～";
            }
                break;
            default://其它页面（这里没有提到的页面，都属于其它）
            {
                tipStr = @"这里什么都没有～";
            }
                break;
        }
    }
    imageName = imageName ?: @"blankpage_image_Default";
    UIButton *bottomBtn = hasError? _reloadButton: _actionButton;
    _centerImgView.image = [UIImage imageNamed:imageName];
    _titleLabel.text = titleStr;
    _tipLabel.text = tipStr;
    [bottomBtn setTitle:buttonTitle forState:UIControlStateNormal];
    _titleLabel.hidden = titleStr.length <= 0;
    bottomBtn.hidden = buttonTitle.length <= 0;

    //    布局
    if (ABS(offsetY) > 0) {
        self.frame = CGRectMake(0, offsetY, self.width, self.height);
    }
    [_centerImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        //            if (ABS(offsetY) > 1.0) {
        //                make.top.equalTo(self).offset(offsetY);
        //            }else{
        make.top.equalTo(self.mas_bottom).multipliedBy(0.15);
        //            }
        make.size.mas_equalTo(CGSizeMake(160, 160));
    }];
    [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.right.equalTo(self).offset(-30);
        make.top.equalTo(_centerImgView.mas_bottom);
    }];
    [_tipLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_titleLabel);
        if (titleStr.length > 0) {
            make.top.equalTo(_titleLabel.mas_bottom).offset(10);
        }else{
            make.top.equalTo(_centerImgView.mas_bottom);
        }
    }];
    if (buttonTitle.length > 0) {

    }
    [bottomBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(130, 44));
        make.top.equalTo(_tipLabel.mas_bottom).offset(25);
    }];
}
- (void)reloadButtonClicked:(id)sender{
    self.hidden = YES;
    [self removeFromSuperview];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_reloadButtonBlock) {
            _reloadButtonBlock(sender);
        }
    });
}
-(void)btnAction{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_clickButtonBlock) {
            _clickButtonBlock(_curType);
        }
    });
}

@end







