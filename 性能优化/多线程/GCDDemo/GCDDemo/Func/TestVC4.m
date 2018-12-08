//
//  TestVC4.m
//  GCDProjectDemo
//
//  Created by wangyinghua on 2018/8/25.
//  Copyright © 2018年 ZhiXing. All rights reserved.
//

#import "TestVC4.h"

@interface TestVC4 ()

@end

@implementation TestVC4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

#pragma mark - group - notify

- (void)queueGroupNotify{
    dispatch_queue_t queue = dispatch_queue_create("testQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        NSLog(@" 任务 1 ");
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@" 任务 2 ");
    });
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@" 任务全部结束之后 ");
    });
}

#pragma mark - group - wait

- (void)queueGroupWait{
    /**
     long rlt = dispatch_group_wait(group, DISPATCH_TIME_NOW);
     long rlt2 = dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
     
     dispatch_group_wait 函数有返回值，相当于将当前线程是否阻止继续执行下面代码。
     参数为 DISPATCH_TIME_FOREVER 的意思是一直等待知道组队列任务全部结束才返回，也即才允许继续执行下面代码，返回值 rlt2 恒为 0 ；DISPATCH_TIME_NOW意思是不等待，继续执行代码 。
     */
    dispatch_queue_t queue = dispatch_queue_create("testQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue2 = dispatch_queue_create("testQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        NSLog(@" 任务 1 ");
    });
    
    dispatch_group_async(group, queue2, ^{
        NSLog(@" 任务 2 ");
    });
    
    long rlt = dispatch_group_wait(group, DISPATCH_TIME_NOW);
    
    
    if (rlt == 0) {
        NSLog(@" 组队列任务全部结束 ");
    } else {
        NSLog(@" 组队列任务全部未结束 ");
    }
    
}


@end
