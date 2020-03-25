//
//  OperationTest1VC.m
//  MultiThreadsDemo
//
//  Created by hnbwyh on 2020/3/17.
//  Copyright © 2020 JiXia. All rights reserved.
//

#import "OperationTest1VC.h"

@interface OperationTest1VC ()

@end

@implementation OperationTest1VC

- (void)viewDidLoad {
    [super viewDidLoad];
   
     // block 操作
     NSLog(@"\n \n \n \n \n \n");
     [self func_block];
     NSLog(@"\n \n \n \n \n \n");
    // selector 操作
     [self func_selector];
     NSLog(@"\n \n \n \n \n \n");
    // block 操作,额外添加操作
     [self func_execution];
}

#pragma mark ------ NSBlockOperation：block 方式封装操作

//NSBlockOperation
- (void)func_block {
    __weak typeof(self) weakSelf = self;
    NSOperationQueue *queue = [NSOperationQueue mainQueue];//[[NSOperationQueue alloc] init];
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
       [weakSelf close0];
    }];
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
       [weakSelf show1];
    }];

    // 先将上一个弹框关闭再将下一个弹框展开
    [operation2 addDependency:operation1];

    // addOperation 该操作不仅添加操作、也将各自之间的关系添加进来
//    [queue addOperation:operation1];
//    [queue addOperation:operation2];
    
    [operation1 start];
}

- (void)close0 {
    NSLog(@"\n close0 :\n %@ \n",[NSThread currentThread]);
}

- (void)show1{
    NSLog(@"\n show1 :\n %@ \n",[NSThread currentThread]);
}

#pragma mark ------ NSInvocationOperation ：selector

// NSInvocationOperation
- (void)func_selector {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSInvocationOperation *operation1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(closeF:) object:@{@"close":@"关闭上一个"}];
    NSInvocationOperation *operation2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(showS:) object:@{@"show":@"展示当前最新弹框"}];
    
    // 先将上一个弹框关闭再将下一个弹框展开
    [operation2 addDependency:operation1];
    
    // addOperation 该操作不仅添加操作、也将各自之间的关系添加进来
//    [queue addOperation:operation1];
//    [queue addOperation:operation2];
    
    [operation1 start];
}

- (void)closeF:(NSDictionary *)dic {
    NSLog(@"\n closeF ： \n %@ \n %@ \n",dic,[NSThread currentThread]);
}

- (void)showS:(NSDictionary *)dic {
    NSLog(@"\n showS ： \n %@ \n %@ \n",dic,[NSThread currentThread]);
}

#pragma mark ------ addExecutionBlock：

- (void)func_execution {
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"\n \n func_execution - operation1 : \n %@ \n",[NSThread currentThread]);
        sleep(6.0);
    }];
    
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"\n \n func_execution - operation2 : \n %@ \n",[NSThread currentThread]);
    }];
    
    [operation1 addExecutionBlock:^{
        NSLog(@"\n \n func_execution - addExecutionBlock - operation1 : \n %@ \n",[NSThread currentThread]);
    }];
    
    [operation2 addExecutionBlock:^{
        NSLog(@"\n \n func_execution - addExecutionBlock - operation2 : \n %@ \n",[NSThread currentThread]);
    }];
    
    // 添加依赖关系
    [operation2 addDependency:operation1];
    
    // 开辟子线程
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation1];
    [queue addOperation:operation2];
    
}

// 操作结束之后
- (void)func_completion {
    
}

@end
