//
//  TestVC6.m
//  GCDProjectDemo
//
//  Created by wangyinghua on 2018/8/25.
//  Copyright © 2018年 ZhiXing. All rights reserved.
//

#import "TestVC6.h"

@interface TestVC6 ()

@end

@implementation TestVC6

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self sampleExample];
    
    [self applyExample];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)sampleExample{
    /**
     dispatch_apply 函数按指定的次数将指定的 Block 追加到指定的 Dispatch Queue 中，并等待全部处理执行结束。这里有类似 Dipatch Group 的用法 。
     */
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_apply(12, queue, ^(size_t index) {
        // 注意这里也不一定按照顺序遍历 ， 以下代码在遍历对象数组的应用中可提高效率
        NSLog(@" index = %ld \n ",index);
    });
    NSLog(@" done ");
}


- (void)applyExample{
    
    NSArray *arr = @[@"1obj",@"2obj",@"3obj",@"4obj",
                     @"5obj",@"6obj",@"7obj",@"8obj",
                     @"9obj",@"10obj"];
    
    // 1. 创建异步队列
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 2. 批量添加任务（这里以模拟遍历数组为例）
    dispatch_async(globalQueue, ^{
        
        dispatch_apply([arr count], globalQueue, ^(size_t index) {
            NSLog(@" thread = %@ index = %ld , obj = %@ \n",[NSThread currentThread],index,[arr objectAtIndex:index]);
        });
        
        // 3. 所有任务处理之后回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@" done ");
        });
    });
    
}

@end
