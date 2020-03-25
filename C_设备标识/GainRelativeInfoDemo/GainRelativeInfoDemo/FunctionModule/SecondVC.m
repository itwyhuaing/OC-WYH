//
//  SecondVC.m
//  GainRelativeInfoDemo
//
//  Created by hnbwyh on 17/7/5.
//  Copyright © 2017年 hainbwyh. All rights reserved.
//

#import "SecondVC.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@interface SecondVC ()

@property (nonatomic,strong) CTTelephonyNetworkInfo *netInfo;
@end

@implementation SecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _netInfo = [[CTTelephonyNetworkInfo alloc] init];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)rightNavBtnClick:(UIButton *)btn{
    NSLog(@" %s ",__FUNCTION__);
    self.displayLabel.text = _netInfo.currentRadioAccessTechnology;
}

@end
