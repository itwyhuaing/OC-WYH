//
//  NetUtil.m
//  OptimizedProDemo
//
//  Created by hnbwyh on 2018/1/30.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "NetUtil.h"
#import "AppDelegate.h"

@implementation NetUtil

+ (NSString *)returnCurrentEquipmentNetStatus{
    
    NSString *netStatus = @"获取网络状态失败";
    
    UIApplication *application = [UIApplication sharedApplication];
    if (application.statusBarHidden) {
        netStatus = @"未获取到网络状态";
        return netStatus;
    }
    NSArray *children;
    /*适配X取网络状态*/
    if ([[application valueForKeyPath:@"_statusBar"] isKindOfClass:NSClassFromString(@"UIStatusBar_Modern")]) {
        children = [[[[application valueForKeyPath:@"_statusBar"] valueForKeyPath:@"_statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    } else {
        children = [[[application valueForKeyPath:@"_statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    }
    //    = [[[app valueForKey:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    int type = 0;
    for (UIView *v in children) {
        if ([v isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            type = [[v valueForKeyPath:@"dataNetworkType"] intValue];
        }
    }
    
    switch (type) {
        case 0:
            netStatus = @"unreachable";
            break;
        case 1:
            netStatus = @"2G";
            break;
        case 2:
            netStatus = @"3G";
            break;
        case 3:
            netStatus = @"4G";
            break;
        case 4:
            netStatus = @"LTE";
            break;
        case 5:
            netStatus = @"wifi";
            break;
        default:
            break;
    }
    
    return netStatus;
}

@end
