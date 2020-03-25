//
//  BaseVC.m
//  GCDProjectDemo
//
//  Created by wangyinghua on 2018/8/25.
//  Copyright © 2018年 ZhiXing. All rights reserved.
//

#import "BaseVC.h"

@interface BaseVC ()

@end

@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationItem.title = self.title;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor  = [UIColor whiteColor];
}

@end
