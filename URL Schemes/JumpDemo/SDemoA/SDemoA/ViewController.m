//
//  ViewController.m
//  SDemoA
//
//  Created by hnbwyh on 2018/5/2.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    self.title = @"点击屏幕跳转应用";
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSURL *URL = [NSURL URLWithString:@"appSDemoB://Detail?para=88"]; // 指定页面 、携带参数
    if ([[UIApplication sharedApplication] canOpenURL:URL]) {
        [[UIApplication sharedApplication] openURL:URL];
    }else{
        NSLog(@"未能打开应用 B");
    }
    
}

@end
