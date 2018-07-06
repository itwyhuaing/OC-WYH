//
//  LocationVC.m
//  LocationsProject
//
//  Created by wangyinghua on 2018/2/10.
//  Copyright © 2018年 ZhiXing. All rights reserved.
//

#import "LocationVC.h"
#import <CoreLocation/CoreLocation.h>

@interface LocationVC () <CLLocationManagerDelegate>
@property (nonatomic,strong) CLLocationManager *locationManager;
@end

@implementation LocationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([CLLocationManager locationServicesEnabled]) {
        [self.locationManager startUpdatingLocation];
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    }else{
        [self displayToastWithMessage:@"系统未打开地图定位"];
    }
    [self.locationManager requestAlwaysAuthorization];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"LocationVC";
}

-(CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
    }
    return _locationManager;
}

#pragma mark ------ CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            {
                [self.locationManager startUpdatingLocation];
            }
            break;
        case kCLAuthorizationStatusNotDetermined:
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusDenied:
            {
                
            }
            break;
            
        default:
            break;
    }
    
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    NSLog(@" \n \n %@ \n \n ",locations);
    CLLocation *l = locations[0];
}

- (void)displayToastWithMessage:(NSString *)msg{
    
    UIAlertController *altvc = [UIAlertController alertControllerWithTitle:@"设置提醒" message:msg preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:altvc animated:TRUE completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:TRUE completion:nil];
    });
    
}

@end
