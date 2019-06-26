//
//  AppDelegate.m
//  TargetPrj
//
//  Created by hnbwyh on 2019/6/21.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeVC.h"
#import "DtVC.h"
#import "TabBarAdapter.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
#ifdef kTargetFH
    NSLog(@" \n 方式一：海房 \n ");
    [self fh];
#else
    NSLog(@" \n 方式一：移民 \n ");
    [self ym];
#endif
    
    if (kTarget) {
        NSLog(@" \n 方式二：海房 \n ");
    }else {
        NSLog(@" \n 方式二：移民 \n ");
    }
    
    
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark --- 多 Target 业务拆分

- (void)fh {
//    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[HomeVC new]];
    self.window.rootViewController = [[TabBarAdapter defaultInstance] adapterTabBarVCWithType:WindowRootTabBarTypeFangChan];
}

- (void)ym {
//    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[DtVC new]];
    self.window.rootViewController = [[TabBarAdapter defaultInstance] adapterTabBarVCWithType:WindowRootTabBarTypeYiMing];
}

@end
