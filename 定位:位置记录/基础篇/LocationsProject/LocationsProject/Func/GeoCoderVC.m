//
//  GeoCoderVC.m
//  LocationsProject
//
//  Created by hnbwyh on 2018/2/11.
//  Copyright © 2018年 ZhiXing. All rights reserved.
//

#import "GeoCoderVC.h"
#import <CoreLocation/CoreLocation.h>

@interface GeoCoderVC ()


// 地理编码
@property (weak, nonatomic) IBOutlet UITextField *inputAddress;
@property (weak, nonatomic) IBOutlet UILabel *al;
@property (weak, nonatomic) IBOutlet UILabel *lo;
@property (weak, nonatomic) IBOutlet UILabel *codeAddDetail;

// 反地理编码
@property (weak, nonatomic) IBOutlet UITextField *aliinput;
@property (weak, nonatomic) IBOutlet UITextField *loiinput;
@property (weak, nonatomic) IBOutlet UILabel *enCodeAddDetail;



@property (nonatomic,strong) CLGeocoder *geoCoder;

@end

@implementation GeoCoderVC


- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     使用 CLGeocoder 可以完成：
     1. 地理编码：根据给定的地名，获得具体的位置信息（比如经纬度、地址的全称等）
     2. 反地理编码：根据给定的经纬度，获得具体的位置信息
     */
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = FALSE;
    self.title = @"GeoCoderVC";
    
}


-(CLGeocoder *)geoCoder{
    
    if (!_geoCoder) {
        _geoCoder = [[CLGeocoder alloc] init];
    }
    return _geoCoder;
    
}


// 地理编码
- (IBAction)codeAction:(id)sender {
    NSString *address = self.inputAddress.text;
    if (address.length <= 0)
        return;
    
    [self.geoCoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
    }];
    
}


// 反地理编码
- (IBAction)enCodekAction:(id)sender {
    
}

@end
