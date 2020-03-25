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
    [self.view addSubview:self.cntV];
    self.sw               = [UIScreen mainScreen].bounds.size.width;
    self.sh               = [UIScreen mainScreen].bounds.size.height;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass(self.class);
}

-(UIScrollView *)cntV{
    if (!_cntV) {
        _cntV                   = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    }
    return _cntV;
}

@end
