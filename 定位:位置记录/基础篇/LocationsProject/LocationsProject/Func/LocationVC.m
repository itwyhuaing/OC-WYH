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
    
/*
 CLLocationManager
 
@property(assign, nonatomic) CLLocationDistance distanceFilter; // 每隔多少米重新定位一次
@property(assign, nonatomic) CLLocationAccuracy desiredAccuracy; // 定位精准度 (一般来说，越精准就越耗电)
 
 
 */

/*
 CLLocation

@property(readonly, nonatomic) CLLocationCoordinate2D coordinate; // 经纬度
 typedef struct {
     CLLocationDegrees latitude; // 纬度
     CLLocationDegrees longitude; // 经度
 } CLLocationCoordinate2D;
 
 
@property(readonly, nonatomic) CLLocationDistance altitude; // 海拔
@property(readonly, nonatomic) CLLocationAccuracy horizontalAccuracy; // 水平方向位置的精准度，倘若定位成功，该值不应小于 0
@property(readonly, nonatomic) CLLocationAccuracy verticalAccuracy; // 垂直方向位置的精准度，倘若定位成功，该值不应小于 0
@property(readonly, nonatomic, copy) NSDate *timestamp; // 获取当前位置时的时间戳
    
    
- (instancetype)initWithLatitude:(CLLocationDegrees)latitude
longitude:(CLLocationDegrees)longitude;
 
- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate
altitude:(CLLocationDistance)altitude
horizontalAccuracy:(CLLocationAccuracy)hAccuracy
verticalAccuracy:(CLLocationAccuracy)vAccuracy
timestamp:(NSDate *)timestamp;
    
- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate
altitude:(CLLocationDistance)altitude
horizontalAccuracy:(CLLocationAccuracy)hAccuracy
verticalAccuracy:(CLLocationAccuracy)vAccuracy
course:(CLLocationDirection)course
speed:(CLLocationSpeed)speed
timestamp:(NSDate *)timestamp API_AVAILABLE(ios(4.2), macos(10.7));

// 计算2个位置之间的距离
- (CLLocationDistance)distanceFromLocation:(const CLLocation *)location;
 
*/
    
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
    /*
     
     kCLAuthorizationStatusNotDetermined
     kCLAuthorizationStatusRestricted
     kCLAuthorizationStatusDenied
     kCLAuthorizationStatusAuthorizedAlways
     kCLAuthorizationStatusAuthorizedWhenInUse
     
     */
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
}

- (void)displayToastWithMessage:(NSString *)msg{
    
    UIAlertController *altvc = [UIAlertController alertControllerWithTitle:@"设置提醒" message:msg preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:altvc animated:TRUE completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:TRUE completion:nil];
    });
    
}

@end
