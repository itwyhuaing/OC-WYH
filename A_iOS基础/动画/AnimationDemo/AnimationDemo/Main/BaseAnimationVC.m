//
//  BaseAnimationVC.m
//  AnimationDemo
//
//  Created by hnbwyh on 2018/8/22.
//  Copyright © 2018年 JiXia. All rights reserved.
//

#import "BaseAnimationVC.h"

@interface BaseAnimationVC ()

@end

@implementation BaseAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = NSStringFromClass(self.class);
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
