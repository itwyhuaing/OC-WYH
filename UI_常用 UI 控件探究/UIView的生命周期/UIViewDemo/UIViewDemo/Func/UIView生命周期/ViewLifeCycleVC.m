//
//  ViewLifeCycleVC.m
//  UIViewDemo
//
//  Created by hnbwyh on 2019/10/11.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "ViewLifeCycleVC.h"
#import "ViewLifeCycle.h"

@interface ViewLifeCycleVC ()

@end

@implementation ViewLifeCycleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    ViewLifeCycle *v = [ViewLifeCycle new];
    [v setFrame:CGRectMake(100, 100, 200, 200)];
    v.backgroundColor = [UIColor redColor];
    NSLog(@"\n ====== 添加 ====== \n");
    [self.view addSubview:v];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"\n ====== 移除 ====== \n");
        [v removeFromSuperview];
    });
}

@end
