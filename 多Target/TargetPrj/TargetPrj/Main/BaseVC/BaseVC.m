//
//  BaseVC.m
//  TargetPrj
//
//  Created by hnbwyh on 2019/6/26.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "BaseVC.h"

@interface BaseVC ()

@end

@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //self.title = NSStringFromClass(self.class);
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

@end
