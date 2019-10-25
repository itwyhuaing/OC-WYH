//
//  BaseVC.m
//  OCBasicDemo
//
//  Created by hnbwyh on 2019/10/23.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "BaseVC.h"

@interface BaseVC ()

@end

@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title                = NSStringFromClass(self.class);
}

@end
