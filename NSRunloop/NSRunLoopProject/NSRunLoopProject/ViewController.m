//
//  ViewController.m
//  NSRunLoopProject
//
//  Created by hnbwyh on 2018/1/16.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "ViewController.h"
#import "FirstVC.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    FirstVC *vc = [[FirstVC alloc] init];
    [self.navigationController pushViewController:vc animated:TRUE];
}

@end
