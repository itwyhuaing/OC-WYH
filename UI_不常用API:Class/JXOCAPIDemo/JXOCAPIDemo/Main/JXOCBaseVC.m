//
//  JXOCBaseVC.m
//  JXOCAPIDemo
//
//  Created by hnbwyh on 2018/11/21.
//  Copyright © 2018年 JiXia. All rights reserved.
//

#import "JXOCBaseVC.h"

@interface JXOCBaseVC ()

@end

@implementation JXOCBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = NSStringFromClass(self.class);
}

@end
