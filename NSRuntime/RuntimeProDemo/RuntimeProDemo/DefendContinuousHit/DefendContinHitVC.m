//
//  DefendContinHitVC.m
//  RuntimeProDemo
//
//  Created by hnbwyh on 2018/1/29.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "DefendContinHitVC.h"
#import "UIControl+ClickEvent.h"



@interface DefendContinHitVC ()

@end

@implementation DefendContinHitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"UIButton 防连击";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, 80.0, 30.0)];
    btn.center = self.view.center;
    btn.custom_acceptEventInterval = 2.0;
    [self.view addSubview:btn];
    [btn setTitle:@"点击测试" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickEventBtn:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark ------ 获取属性列表与方法列表

- (void)clickEventBtn:(UIButton *)btn{

    NSLog(@" %s ",__FUNCTION__);
}

@end
