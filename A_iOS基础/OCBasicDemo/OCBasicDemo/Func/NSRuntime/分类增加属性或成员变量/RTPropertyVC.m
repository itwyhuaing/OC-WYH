//
//  RTPropertyVC.m
//  OCBasicDemo
//
//  Created by hnbwyh on 2019/11/13.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "RTPropertyVC.h"
#import "UIButton+Event.h"

@interface RTPropertyVC ()

@end

@implementation RTPropertyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.customInterval = 3.0;
}

@end
