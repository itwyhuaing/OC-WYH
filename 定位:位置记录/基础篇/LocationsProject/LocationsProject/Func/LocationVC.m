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
    CLLocation *location = [[CLLocation alloc] init];
    
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

@end
