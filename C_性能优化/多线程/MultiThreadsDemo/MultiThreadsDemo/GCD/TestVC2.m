//
//  TestVC2.m
//  GCDProjectDemo
//
//  Created by wangyinghua on 2018/8/25.
//  Copyright © 2018年 ZhiXing. All rights reserved.
//

#import "TestVC2.h"

@interface TestVC2 ()

@end

@implementation TestVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

#pragma mark - 队列创建 / 获取

- (void)queueBriefInfo{
    
    /**
     dispatch_queue_create(const char * _Nullable label, <#dispatch_queue_attr_t  _Nullable attr#>)
     
     dispatch_get_global_queue(<#long identifier#>, <#unsigned long flags#>)
     
     */
    
    // Serail Dispatch Quue
    dispatch_queue_t squeue = dispatch_queue_create("SerailDispatchQueue", NULL);
    
    // Concurrent Dispatch Quue
    dispatch_queue_t cqueue = dispatch_queue_create("ConcurrentDispatchQueue", DISPATCH_QUEUE_CONCURRENT);
    
    // Main Queue - Serail Dispatch Quue
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    // Global Queue - Concurrent Dispatch Quue
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    
    /**
     
      dispatch_async 异步方式添加任务到队列
     
      dispatch_sync  同步方式添加任务到队列
     
     */
    dispatch_async(squeue, ^{
        NSLog(@" 异步方式 - 添加任务到同步队列中 ");
    });
    
    dispatch_sync(squeue, ^{
        NSLog(@" 同步方式 - 添加任务到同步队列中 ");
    });
    
}


#pragma mark - 队列优先级变更、队列合并

- (void)modifyAndMerge{
    // 将 squeue 队列优先级修改为 后台模式 （注意：系统生成的主队列与全局队列不可修改）
    dispatch_queue_t squeue = dispatch_queue_create("SerailDispatchQueue", NULL);
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_set_target_queue(squeue, globalQueue);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

@end
