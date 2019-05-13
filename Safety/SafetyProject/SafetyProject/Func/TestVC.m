//
//  TestVC.m
//  SafetyProject
//
//  Created by hnbwyh on 2019/5/9.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "TestVC.h"
#import "JXSafety.h"
#import "StatTool.h"

@interface TestVC ()

@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass(self.class);
    [self test];
}

- (void)test {
    
    [[JXSafety defaultInstance] detectionSystem];
    
    [[JXSafety defaultInstance] detectionSystemSafaty3];
    
    [[StatTool defaultInstance] test];
    
}

@end
