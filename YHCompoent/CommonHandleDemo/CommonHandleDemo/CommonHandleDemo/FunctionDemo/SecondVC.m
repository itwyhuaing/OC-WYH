//
//  SecondVC.m
//  CommonHandleDemo
//
//  Created by hnbwyh on 2018/3/1.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "SecondVC.h"

@interface SecondVC ()

@end

@implementation SecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"SecondVC";
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UIPasteboard *ps = [UIPasteboard generalPasteboard];
    NSLog(@" === ");
}

@end
