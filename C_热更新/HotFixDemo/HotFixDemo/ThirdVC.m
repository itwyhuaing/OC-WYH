//
//  ThirdVC.m
//  HotFixDemo
//
//  Created by hnbwyh on 2018/3/12.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "ThirdVC.h"


@interface ThirdVC ()

@end

@implementation ThirdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@" %s ",__FUNCTION__);
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"ThirdVC";
}

@end
