//
//  ChainVC.m
//  OCBasicDemo
//
//  Created by hnbwyh on 2019/11/27.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "ChainVC.h"
#import "UILabel+Additions.h"

@interface ChainVC ()

@end

@implementation ChainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *l = UILabel.label(CGRectMake(100, 100, 100, 100))
                        .titleColor([UIColor orangeColor])
                        .bgColor([UIColor redColor]);
    [self.view addSubview:l];
}

@end
