//
//  TestVC.m
//  TableViewDemo
//
//  Created by wangyinghua on 2018/11/17.
//  Copyright © 2018年 TongXin. All rights reserved.
//

#import "TestVC.h"
#import "TestView.h"

@interface TestVC ()

@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    TestView *tv = [[TestView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:tv];
}

@end
