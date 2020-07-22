//
//  BaseController.m
//  SafetyDemo
//
//  Created by hnbwyh on 2020/7/22.
//  Copyright © 2020 JiXia. All rights reserved.
//

#import "BaseController.h"

@interface BaseController ()

@end

@implementation BaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass(self.class);
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

@end
