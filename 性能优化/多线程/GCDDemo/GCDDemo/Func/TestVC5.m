//
//  TestVC5.m
//  GCDProjectDemo
//
//  Created by wangyinghua on 2018/8/25.
//  Copyright © 2018年 ZhiXing. All rights reserved.
//

#import "TestVC5.h"

@interface TestVC5 ()

@end

@implementation TestVC5

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

// 一些这种方式可能导致数据读写错误甚至应用异常退出
- (void)wrongCode{
    dispatch_queue_t queue = dispatch_queue_create("testQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
       // 数据读操作 1
    });
    dispatch_async(queue, ^{
        // 数据读操作 2
    });
    dispatch_async(queue, ^{
        // 数据写操作
    });
    dispatch_async(queue, ^{
        // 数据读操作 3
    });
    dispatch_async(queue, ^{
        // 数据读操作 4
    });
    dispatch_async(queue, ^{
        // 数据读操作 5
    });
}

- (void)rightCode{
    dispatch_queue_t queue = dispatch_queue_create("testQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        // 数据读操作 1
    });
    dispatch_async(queue, ^{
        // 数据读操作 2
    });
    // ====================== 该优化方式不仅避免了数据竞争冒险，而且在该操作之后的读取均为最新数据
    dispatch_barrier_async(queue, ^{
        // 数据写操作
    });
    // ======================
    dispatch_async(queue, ^{
        // 数据读操作 3
    });
    dispatch_async(queue, ^{
        // 数据读操作 4
    });
    dispatch_async(queue, ^{
        // 数据读操作 5
    });
}


@end
