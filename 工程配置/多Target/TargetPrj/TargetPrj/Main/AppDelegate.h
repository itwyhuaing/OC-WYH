//
//  AppDelegate.h
//  TargetPrj
//
//  Created by hnbwyh on 2019/6/21.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarAdapter.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)configTabBarVCWithType:(WindowRootTabBarType)type;

@end

