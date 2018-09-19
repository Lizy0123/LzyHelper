//
//  TabBarControllerConfig.m
//  LzyHelper
//
//  Created by Lzy on 2017/10/25.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import "TabBarControllerConfig.h"
#import "BaseNavigationController.h"
static CGFloat const kTabBarControllerHeight = 40.f;

#import "HomeViewController.h"
#import "MineViewController.h"

@interface TabBarControllerConfig()<UITabBarControllerDelegate>
@property (nonatomic, readwrite, strong) BaseTabBarController *tabBarController;
@end


@implementation TabBarControllerConfig

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (NSArray *)viewControllers {
    UIViewController *firstNavigationController = [[BaseNavigationController alloc] initWithRootViewController:[[HomeViewController alloc] init]];
    UIViewController *fourthNavigationController = [[BaseNavigationController alloc] initWithRootViewController:[[MineViewController alloc] init]];
    return @[
             firstNavigationController,
             fourthNavigationController
             ];
}
- (NSArray *)tabItemsAttributesArr {
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"首页",
                                                 CYLTabBarItemImage : @"home_normal",  /* NSString and UIImage are supported*/
                                                 CYLTabBarItemSelectedImage : @"home_highlight", /* NSString and UIImage are supported*/
                                                 };

    NSDictionary *fourthTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"我的",
                                                  CYLTabBarItemImage : @"account_normal",
                                                  CYLTabBarItemSelectedImage : @"account_highlight"
                                                  };
    return @[
             firstTabBarItemsAttributes,
             fourthTabBarItemsAttributes
             ];;
}
/**
 *  lazy load tabBarController
 *
 *  @return CYLTabBarController
 */
- (BaseTabBarController *)tabBarController {
    if (_tabBarController == nil) {
        /**
         * 以下两行代码目的在于手动设置让TabBarItem只显示图标，不显示文字，并让图标垂直居中。
         * 等效于在 `-tabItemsAttributesArr` 方法中不传 `CYLTabBarItemTitle` 字段。
         * 更推荐后一种做法。
         */
        UIEdgeInsets imageInsets = UIEdgeInsetsZero;//UIEdgeInsetsMake(4.5, 0, -4.5, 0);
        UIOffset titlePositionAdjustment = UIOffsetZero;//UIOffsetMake(0, MAXFLOAT);

        BaseTabBarController *tabBarController = [BaseTabBarController tabBarControllerWithViewControllers:self.viewControllers tabBarItemsAttributes:self.tabItemsAttributesArr imageInsets:imageInsets titlePositionAdjustment:titlePositionAdjustment];
        [self configTabBarAppearance:tabBarController];
        _tabBarController = tabBarController;
    }
    return _tabBarController;
}

- (void)configTabBarAppearance:(CYLTabBarController *)tabBarController {
#warning Customize your tabBar Appearance
    // 自定义 TabBar 高度
//     tabBarController.tabBarHeight = kTabBarControllerHeight;

    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];

    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];

    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];

    // TabBarItem选中后的背景颜色
// [self customizeTabBarSelectionIndicatorImage];

    // update TabBar when TabBarItem width did update
    // 如果你的App需要支持横竖屏，请使用该方法移除注释 '//'
// [self updateTabBarCustomizationWhenTabBarItemWidthDidUpdate];

    // set the bar shadow image
    // This shadow image attribute is ignored if the tab bar does not also have a custom background image.So at least set somthing.
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tapbar_top_line"]];

    // 设置背景图片
//     UITabBar *tabBarAppearance = [UITabBar appearance];
//     [tabBarAppearance setBackgroundImage:[UIImage imageNamed:@"tab_bar"]];

    // 去除 TabBar 自带的顶部阴影
// [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
}
- (void)updateTabBarCustomizationWhenTabBarItemWidthDidUpdate {
    void (^deviceOrientationDidChangeBlock)(NSNotification *) = ^(NSNotification *notification) {
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        if ((orientation == UIDeviceOrientationLandscapeLeft) || (orientation == UIDeviceOrientationLandscapeRight)) {
            NSLog(@"Landscape Left or Right !");
        } else if (orientation == UIDeviceOrientationPortrait) {
            NSLog(@"Landscape portrait!");
        }
        [self customizeTabBarSelectionIndicatorImage];
    };
    [[NSNotificationCenter defaultCenter] addObserverForName:CYLTabBarItemWidthDidChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:deviceOrientationDidChangeBlock];
}

- (void)customizeTabBarSelectionIndicatorImage {
    ///Get initialized TabBar Height if exists, otherwise get Default TabBar Height.
    CGFloat tabBarHeight = kTabBarControllerHeight;
    CGSize selectionIndicatorImageSize = CGSizeMake(CYLTabBarItemWidth, tabBarHeight);
    //Get initialized TabBar if exists.
    UITabBar *tabBar = [self cyl_tabBarController].tabBar ?: [UITabBar appearance];
    [tabBar setSelectionIndicatorImage:
    [[self class] imageWithColor:[UIColor yellowColor] size:selectionIndicatorImageSize]];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width + 1, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end




//#import "AddProductViewController.h"
#import "LoginViewController.h"
#import "BaseViewController.h"

@interface PlusButtonSubclass ()<UIActionSheetDelegate> {
    CGFloat _buttonImageHeight;
    UIView *_botView;
    UIView *_mengBanView;
}

@end

@implementation PlusButtonSubclass

#pragma mark -
#pragma mark - Life Cycle

+ (void)load {
    //请在 `-[AppDelegate application:didFinishLaunchingWithOptions:]` 中进行注册，否则iOS10系统下存在Crash风险。
    //[super registerPlusButton];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

//上下结构的 button
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 控件大小,间距大小
    // 注意：一定要根据项目中的图片去调整下面的0.7和0.9，Demo之所以这么设置，因为demo中的 plusButton 的 icon 不是正方形。
    CGFloat const imageViewEdgeWidth   = self.bounds.size.width * 0.7;
    CGFloat const imageViewEdgeHeight  = imageViewEdgeWidth * 0.9;
    
    CGFloat const centerOfView    = self.bounds.size.width * 0.5;
    CGFloat const labelLineHeight = self.titleLabel.font.lineHeight;
    CGFloat const verticalMargin  = (self.bounds.size.height - labelLineHeight - imageViewEdgeHeight) * 0.5;
    
    // imageView 和 titleLabel 中心的 Y 值
    CGFloat const centerOfImageView  = verticalMargin + imageViewEdgeHeight * 0.7;
    CGFloat const centerOfTitleLabel = imageViewEdgeHeight  + verticalMargin * 2 + labelLineHeight * 0.5 + 5+5+5;
    
    //imageView position 位置
    self.imageView.bounds = CGRectMake(0, 0, imageViewEdgeWidth, imageViewEdgeHeight);
    self.imageView.center = CGPointMake(centerOfView, centerOfImageView);
    
    //title position 位置
    self.titleLabel.bounds = CGRectMake(0, 0, self.bounds.size.width, labelLineHeight);
    self.titleLabel.center = CGPointMake(centerOfView, centerOfTitleLabel);
}

#pragma mark -
#pragma mark - CYLPlusButtonSubclassing Methods

/*
 *
 Create a custom UIButton with title and add it to the center of our tab bar
 *
 */
+ (id)plusButton {
    PlusButtonSubclass *button = [[PlusButtonSubclass alloc] init];
    [button setImage:[UIImage imageNamed:@"tabbar_middle"] forState:UIControlStateNormal];
    
    [button setTitle:@"发布" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [button setTitle:@"发布" forState:UIControlStateSelected];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    
    button.titleLabel.font = [UIFont systemFontOfSize:9.5];
    [button sizeToFit]; // or set frame in this way `button.frame = CGRectMake(0.0, 0.0, 250, 100);`
    //    button.frame = CGRectMake(0.0, 0.0, 250, 100);
    //    button.backgroundColor = [UIColor redColor];
    
    // if you use `+plusChildViewController` , do not addTarget to plusButton.
    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
    return button;
}
/*
 *
 Create a custom UIButton without title and add it to the center of our tab bar
 *
 */
//+ (id)plusButton
//{
//
//    UIImage *buttonImage = [UIImage imageNamed:@"hood.png"];
//    UIImage *highlightImage = [UIImage imageNamed:@"hood-selected.png"];
//
//    CYLPlusButtonSubclass* button = [CYLPlusButtonSubclass buttonWithType:UIButtonTypeCustom];
//
//    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
//    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
//    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
//    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
//    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
//
//    return button;
//}

/*
 #pragma mark 弹出框方法
 -(void)cnacle{
 [UIView animateWithDuration:1 animations:^{
 
 _botView.frame = CGRectMake(0,kScreen_Height, kScreen_Width, 300);
 
 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
 
 [_botView removeFromSuperview];
 [_mengBanView removeFromSuperview];
 });
 
 }];
 
 }
 */

#pragma mark - CYLPlusButtonSubclassing

//+ (UIViewController *)plusChildViewController {
//    UIViewController *plusChildViewController = [[UIViewController alloc] init];
//    plusChildViewController.view.backgroundColor = [UIColor redColor];
//    plusChildViewController.navigationItem.title = @"PlusChildViewController";
//    UIViewController *plusChildNavigationController = [[UINavigationController alloc]
//                                                   initWithRootViewController:plusChildViewController];
//    return plusChildNavigationController;
//}
//
//+ (NSUInteger)indexOfPlusButtonInTabBar {
//    return 1;
//}
//
//+ (BOOL)shouldSelectPlusChildViewController {
//    BOOL isSelected = CYLExternPlusButton.selected;
//    if (isSelected) {
//        NSLog(@"🔴类名与方法名：%@（在第%@行），描述：%@", @(__PRETTY_FUNCTION__), @(__LINE__), @"PlusButton is selected");
//    } else {
//        NSLog(@"🔴类名与方法名：%@（在第%@行），描述：%@", @(__PRETTY_FUNCTION__), @(__LINE__), @"PlusButton is not selected");
//    }
//    return YES;
//}
//- (void)clickPublish {
//    CYLTabBarController *tabBarController = [self cyl_tabBarController];
//    UIViewController *viewController = tabBarController.selectedViewController;
//
//    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
//                                                             delegate:nil
//                                                    cancelButtonTitle:@"取消"
//                                               destructiveButtonTitle:nil
//                                                    otherButtonTitles:@"拍照", @"从相册选取", @"淘宝一键转卖", nil];
//    [actionSheet showInView:viewController.view];
//}
//
//#pragma mark - UIActionSheetDelegate
//
//- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
//    NSLog(@"buttonIndex = %@", @(buttonIndex));
//}

- (void)clickPublish {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"上传设备" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
        BaseNavigationController *viewController = tabBarController.selectedViewController;
        if ([kStringSessionId length]) {
//            AddProductViewController *vc = [[AddProductViewController alloc]init];
//            vc.title = @"上传设备";
//            vc.isEquipment = YES;
//            [viewController pushViewController:vc animated:YES];
        }else{
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
            [viewController presentViewController:nav animated:YES completion:^{
            }];
        }
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"上传材料" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
        BaseNavigationController *viewController = tabBarController.selectedViewController;
        if ([kStringSessionId length]) {
//            AddProductViewController *vc = [[AddProductViewController alloc]init];
//            vc.title = @"上传材料";
//            vc.isEquipment = NO;
//            [viewController pushViewController:vc animated:YES];
        }else{
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
            [viewController presentViewController:nav animated:YES completion:^{
            }];
        }
    }];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:cancelAction];
    
    CYLTabBarController *tabBarController = [self cyl_tabBarController];
    [tabBarController.selectedViewController presentViewController:alert animated:YES completion:nil];
}

+ (CGFloat)multiplierOfTabBarHeight:(CGFloat)tabBarHeight {
    return  0.3;
}

+ (CGFloat)constantOfPlusButtonCenterYOffsetForTabBarHeight:(CGFloat)tabBarHeight {
    return  -10;
}

+ (NSUInteger)indexOfPlusButtonInTabBar {
    return 0;
}

+ (CGFloat)multiplerInCenterY {
    return  0.5;
}

@end
