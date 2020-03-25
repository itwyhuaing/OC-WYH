//
//  FourthVC.m
//  GainRelativeInfoDemo
//
//  Created by hnbwyh on 17/7/5.
//  Copyright © 2017年 hainbwyh. All rights reserved.
//

#import "FourthVC.h"
#import <AdSupport/AdSupport.h>

@interface FourthVC ()

@end

@implementation FourthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)rightNavBtnClick:(UIButton *)btn{
    /******************** UA ***********************/
    // UA - 取旧的
    UIWebView* tempWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
    NSString* OldUserAgent = [tempWebView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    // UA - 需要修改时，先修改
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *newAgent = [NSString stringWithFormat:@"%@%@%@",OldUserAgent,[infoDictionary objectForKey:@"CFBundleName"],[infoDictionary objectForKey:@"CFBundleShortVersionString"]];
    NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:newAgent, @"UserAgent", nil];
    // UA - 需要修改时，再 regist
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
    
    /******************** idfa ***********************/
    NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    /******************** UDID ***********************/
    
    /******************** IDFV ***********************/
    NSString *IDFV = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    /******************** 硬件设备信息 ***********************/
    UIDevice *device = [UIDevice currentDevice];
    
    
    
    NSString *displayText = [NSString stringWithFormat:@"1> WebUA: \n%@ \n \n 2> idfa: \n%@ \n \n 3> iOS5之后 禁止获取UDID \n \n 4> IDFV : \n%@",OldUserAgent,idfa,IDFV];
    self.displayLabel.text = displayText;
}

@end
