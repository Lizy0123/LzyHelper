//
//  BaseNavigationController.m
//  LzyHelper
//
//  Created by Lzy on 2017/10/25.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_X (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 812.0f)

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        if (!IS_IPHONE_X) {
            viewController.hidesBottomBarWhenPushed = YES;
        }
    }
    [super pushViewController:viewController animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavigationBarAppearance];
}
/**
 *  设置navigationBar样式
 */
-(void)configNavigationBarAppearance{
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];

    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        backgroundImage = [UIImage imageNamed:@"navigationbar_background_tall"];

        textAttributes = @{
                           NSFontAttributeName : [UIFont boldSystemFontOfSize:18],
                           NSForegroundColorAttributeName : [UIColor blackColor],
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        backgroundImage = [UIImage imageNamed:@"navigationbar_background"];
        textAttributes = @{
                           UITextAttributeFont : [UIFont boldSystemFontOfSize:18],
                           UITextAttributeTextColor : [UIColor blackColor],
                           UITextAttributeTextShadowColor : [UIColor clearColor],
                           UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }

    [navigationBarAppearance setBackgroundImage:backgroundImage
                                  forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
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
