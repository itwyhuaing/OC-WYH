//
//  RegionVC.m
//  LocationsProject
//
//  Created by hnbwyh on 2018/6/1.
//  Copyright © 2018年 ZhiXing. All rights reserved.
//

#import "RegionVC.h"
#import <CoreLocation/CoreLocation.h>

@interface RegionVC ()   <CLLocationManagerDelegate>

@property (nonatomic,strong) CLLocationManager *locationManager;

@end

@implementation RegionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注意这里只是展示区域监听代码，进入之前应该先请求一次准许地图定位即 LocationVC
    
    CLLocationDistance maxGap = self.locationManager.maximumRegionMonitoringDistance;
    CLLocationDistance gap = 1000 > maxGap ? maxGap : 1000; // 判定当前的监听区域半径是否大于最大可被监听的区域半径
    CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:CLLocationCoordinate2DMake(37.785834, -122.406417)
                                                                 radius:gap
                                                             identifier:@"JXDemo"];
    [self.locationManager startMonitoringForRegion:region]; // 开始监听
    [self.locationManager requestStateForRegion:region];    // 更新当前状态(如果发生了进入或者离开区域的动作也会调用对应的代理方法)
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"RegionVC";
}

#pragma mark ------ 懒加载

-(CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
    }
    return _locationManager;
}

#pragma mark ------ CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
     NSLog(@" %s ",__FUNCTION__);
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region{
     NSLog(@" %s ",__FUNCTION__);
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
     NSLog(@" %s ",__FUNCTION__);
}

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(nullable CLRegion *)region withError:(NSError *)error {
    NSLog(@" %s ",__FUNCTION__);
    // [self.locationManager startMonitoringForRegion:<#(nonnull CLRegion *)#>]; 失败之后可以移除最远的距离
}

-(void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region{
     NSLog(@" %s ",__FUNCTION__);
    if ([region.identifier isEqualToString:@"JXDemo"]) {
        switch (state) {
            case CLRegionStateUnknown:
                NSLog(@"CLRegionStateUnknown");
            break;
            case CLRegionStateInside:
                NSLog(@"CLRegionStateInside");
            break;
            case CLRegionStateOutside:
                NSLog(@"CLRegionStateOutside");
            break;
        }
    }
}

@end
