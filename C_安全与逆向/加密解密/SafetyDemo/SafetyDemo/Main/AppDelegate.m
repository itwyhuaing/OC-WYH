//
//  AppDelegate.m
//  AnimationDemo
//
//  Created by hnbwyh on 2020/6/28.
//  Copyright © 2020 JiXia. All rights reserved.
//

#import "AppDelegate.h"
#import "EntryTableController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[EntryTableController alloc] init]];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
