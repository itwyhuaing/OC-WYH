//
//  OperationTestVC2.m
//  MultiThreadsDemo
//
//  Created by hnbwyh on 2020/3/18.
//  Copyright © 2020 JiXia. All rights reserved.
//

#import "OperationTestVC2.h"

@interface OperationTestVC2 ()

@end

@implementation OperationTestVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self func_backMainQueue];
}

- (void)func_backMainQueue {
    // 子线程
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{
        for (NSInteger cou = 0; cou < 6; cou ++) {
            [NSThread sleepForTimeInterval:2.0];
            NSLog(@"\n 子线程 \n %@ \n 第 %ld 次执行 \n",[NSThread currentThread],cou);
        }
        
        // 主线程
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            for (NSInteger cou = 0; cou < 6; cou ++) {
                [NSThread sleepForTimeInterval:2.0];
                NSLog(@"\n 主线程 \n %@ \n 第 %ld 次执行 \n",[NSThread currentThread],cou);
            }
        }];
        
    }];
}

@end
