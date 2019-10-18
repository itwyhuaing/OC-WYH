//
//  CLBaseVC.m
//  CustomLibProject
//
//  Created by hnbwyh on 2019/10/18.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "CLBaseVC.h"

@interface CLBaseVC ()

@end

@implementation CLBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass(self.class);
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
