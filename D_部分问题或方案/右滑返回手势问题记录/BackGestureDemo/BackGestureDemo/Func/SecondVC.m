//
//  SecondVC.m
//  BackGestureDemo
//
//  Created by hnbwyh on 2018/7/18.
//  Copyright © 2018年 ZhiXingLife. All rights reserved.
//

#import "SecondVC.h"

@interface SecondVC ()<UIGestureRecognizerDelegate>

@end

@implementation SecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass([self class]);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor               = [UIColor whiteColor];
    
    // 返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(0, 0, 40.0, 40.0)];
    [backBtn addTarget:self action:@selector(back_preVC) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    //self.navigationItem.leftBarButtonItem = backItem;
}

- (void)back_preVC{
    [self.navigationController popViewControllerAnimated:TRUE];
}


-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return TRUE;
}

@end
