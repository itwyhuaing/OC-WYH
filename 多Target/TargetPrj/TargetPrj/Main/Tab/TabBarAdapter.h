//
//  TabBarAdapter.h
//  hinabian
//
//  Created by hnbwyh on 2019/5/10.
//  Copyright © 2019 深圳市海那边科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CYLTabBarController/CYLTabBarController.h>

// 对应不同业务的 TabBarController 根控制器
typedef enum : NSUInteger {
    WindowRootTabBarTypeYiMing = 99999,
    WindowRootTabBarTypeFangChan,
    WindowRootTabBarTypeNone,
} WindowRootTabBarType;

NS_ASSUME_NONNULL_BEGIN

@interface TabBarAdapter : NSObject

/**
 实例化单例
 */
+ (instancetype)defaultInstance;

/**
 实例化对象
 */
- (CYLTabBarController *)adapterTabBarVCWithType:(WindowRootTabBarType)rootType;

@end

NS_ASSUME_NONNULL_END
