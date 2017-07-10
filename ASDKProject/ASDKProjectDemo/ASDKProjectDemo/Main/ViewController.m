//
//  ViewController.m
//  ASDKProjectDemo
//
//  Created by hnbwyh on 17/7/10.
//  Copyright © 2017年 hainbwyh. All rights reserved.
//

#import "ViewController.h"
#import "FirstASVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, 35, 35)];
    [btn addTarget:self action:@selector(rightNavBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitle:@"启动" forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    if (self.navigationController.viewControllers.count > 1) {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setFrame:CGRectMake(0, 0, 35, 35)];
        [backBtn addTarget:self action:@selector(backNavBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        backBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [backBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    }
    
}

- (void)rightNavBtnClick:(UIButton *)btn{
    [self.navigationController pushViewController:[[FirstASVC alloc] init] animated:YES];
}

- (void)backNavBtnClick:(UIButton *)btn{
    
}

@end
