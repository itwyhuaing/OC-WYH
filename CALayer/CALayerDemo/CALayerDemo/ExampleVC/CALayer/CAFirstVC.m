//
//  CAFirstVCViewController.m
//  CALayerDemo
//
//  Created by hnbwyh on 2018/2/9.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "CAFirstVC.h"

@interface CAFirstVC ()

@end

@implementation CAFirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self reverseImage];
    [self card];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = FALSE;
    self.view.backgroundColor = [UIColor whiteColor];
    
}

#pragma mark --- 卡片式效果
- (void)card{
    CGRect rect = CGRectZero;
    rect.size = CGSizeMake(200, 100);
    rect.origin.x = self.view.bounds.size.width/2.0 - 200.0/2.0;
    rect.origin.y = 10.0;
    UIView *v1 = [[UIView alloc] initWithFrame:rect];
    rect.origin = CGPointMake(0.0, 0.0);
    UIView *v2 = [[UIView alloc] initWithFrame:rect];
    
    [self.view addSubview:v1];
    [v1 addSubview:v2];
    
    
    v2.backgroundColor = [UIColor cyanColor];
    v1.clipsToBounds = FALSE;
    v1.layer.cornerRadius = 5.0;
    v1.layer.shadowColor = [UIColor colorWithRed:122.0f/255.0f green:122.0f/255.0f blue:122.0f/255.0f alpha:1.0].CGColor;
    v1.layer.shadowOpacity = 0.3f;
    v1.layer.shadowRadius = 2.f;
    v1.layer.shadowOffset = CGSizeMake(0,0);
    
    v2.layer.masksToBounds = TRUE;
    v2.layer.cornerRadius = 4.f;
}

@end
