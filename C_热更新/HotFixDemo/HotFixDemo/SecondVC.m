//
//  SecondVC.m
//  HotFixDemo
//
//  Created by hnbwyh on 2018/3/12.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "SecondVC.h"
#import "ThirdVC.h"
 

@interface SecondVC ()

@end

@implementation SecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated{
    NSLog(@" %s ",__FUNCTION__);
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"SecondVC";
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    ThirdVC *vc = [[ThirdVC alloc] init];
    [self.navigationController pushViewController:vc animated:TRUE];
    
}

@end
