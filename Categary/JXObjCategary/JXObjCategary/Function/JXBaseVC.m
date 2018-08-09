//
//  JXBaseVC.m
//  JXObjCategary
//
//  Created by hnbwyh on 2018/8/9.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "JXBaseVC.h"

@interface JXBaseVC ()

@end

@implementation JXBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass(self.class);
}

@end
