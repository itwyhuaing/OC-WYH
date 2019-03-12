//
//  ViewController.m
//  BlockDemo
//
//  Created by hnbwyh on 2019/3/8.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "ViewController.h"
#import "CaculateManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CaculateManager *mgr = [[CaculateManager alloc] init];
    CaculateManager *rlt = mgr.add(20).add(30); // = 50
    
}


@end
