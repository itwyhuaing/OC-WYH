//
//  OperateVC.m
//  DataStoreDemo
//
//  Created by hnbwyh on 2018/8/10.
//  Copyright © 2018年 hainbwyh. All rights reserved.
//

#import "OperateVC.h"


@interface OperateVC ()

@end

@implementation OperateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = [NSString stringWithFormat:@"%@",self.operation];
}


@end
