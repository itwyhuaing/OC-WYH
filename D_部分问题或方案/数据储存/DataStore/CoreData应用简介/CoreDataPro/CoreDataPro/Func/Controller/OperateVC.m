//
//  OperateVC.m
//  CoreDataPro
//
//  Created by hnbwyh on 2018/8/7.
//  Copyright © 2018年 TongXing. All rights reserved.
//

#import "OperateVC.h"
#import "DataOperator.h"

@interface OperateVC ()

@property (nonatomic,strong) DataOperator *operator;

@end

@implementation OperateVC

#pragma mark ------ life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.operator loadDataSource];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = [NSString stringWithFormat:@"%@",self.operation];
}

#pragma mark ------ 操作



#pragma mark ------ lazy load

-(DataOperator *)operator{
    if (!_operator) {
        _operator = [[DataOperator alloc] init];
    }
    return _operator;
}

@end
