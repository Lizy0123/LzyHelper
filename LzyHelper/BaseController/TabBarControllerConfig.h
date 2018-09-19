//
//  TabBarControllerConfig.h
//  LzyHelper
//
//  Created by Lzy on 2017/10/25.
//  Copyright © 2017年 Lzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseTabBarController.h"

@interface TabBarControllerConfig : NSObject
@property (nonatomic, readonly, strong) BaseTabBarController *tabBarController;
@property (nonatomic, copy) NSString *context;
@end

@interface PlusButtonSubclass : CYLPlusButton <CYLPlusButtonSubclassing>

@end
