//
//  ViewController.m
//  BackGestureDemo
//
//  Created by hnbwyh on 2018/7/18.
//  Copyright © 2018年 ZhiXingLife. All rights reserved.
//

#import "ViewController.h"
#import "FirstVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass([self class]);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor               = [UIColor whiteColor];
    
    UILabel *l = [[UILabel alloc] init];
    [self.view addSubview:l];
    [l setFrame:self.view.bounds];
    l.textColor = [UIColor cyanColor];
    l.backgroundColor  = [UIColor orangeColor];
    l.numberOfLines = 0;
    l.text = @"1.点击任意处跳转至下一级 \n 2.FirstVC 为隐藏原生导航栏，拦截手势回调代理 \n ";
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    FirstVC *vc = [[FirstVC alloc] init];
    [self.navigationController pushViewController:vc animated:TRUE];
}

@end
