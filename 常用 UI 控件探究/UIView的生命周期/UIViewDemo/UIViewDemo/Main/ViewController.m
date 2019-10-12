//
//  ViewController.m
//  UIViewDemo
//
//  Created by hnbwyh on 2019/10/11.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "ViewController.h"
#import "ViewLifeCycleVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ViewLifeCycleVC *vc = [ViewLifeCycleVC new];
    [self.navigationController pushViewController:vc animated:TRUE];
}


@end
