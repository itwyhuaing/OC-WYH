//
//  ThreadLockVC.m
//  MultiThreadsDemo
//
//  Created by hnbwyh on 2020/3/19.
//  Copyright © 2020 JiXia. All rights reserved.
//

#import "ThreadLockVC.h"

@interface ThreadLockVC ()

@property (nonatomic,assign) NSUInteger remanentAirTickets;

@property (nonatomic,strong) NSLock     *theLock;

@end

@implementation ThreadLockVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.remanentAirTickets = 3;
    self.theLock            = [NSLock new];
}

- (void)beijing:(NSInteger)cou {
    __weak typeof(self)weakSelf = self;
    NSOperationQueue *queue         = [NSOperationQueue new];
    NSBlockOperation *operation     = [NSBlockOperation blockOperationWithBlock:^{
        [weakSelf sale:@"BJ" idx:cou];
    }];
    [queue addOperation:operation];
}

- (void)shenzhen:(NSInteger)cou {
    __weak typeof(self)weakSelf = self;
    NSOperationQueue *queue         = [NSOperationQueue new];
    NSBlockOperation *operation     = [NSBlockOperation blockOperationWithBlock:^{
        [weakSelf sale:@"SZ" idx:cou];
    }];
    [queue addOperation:operation];
}

- (void)sale:(NSString *)location idx:(NSInteger)idx{
        [self.theLock lock];
        if (self.remanentAirTickets > 0) {
            self.remanentAirTickets --;
            // 查询等耗时操作
            [NSThread sleepForTimeInterval:2.0];
            NSLog(@"\n 查询%ld - %@出票 \n 线程: %@ \n",idx,location,[NSThread currentThread]);
        }else {
            // 查询等耗时操作
            [NSThread sleepForTimeInterval:2.0];
            NSLog(@"\n 查询%ld - %@无票 \n 线程: %@ \n",idx,location,[NSThread currentThread]);
        }
        [self.theLock unlock];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    for (NSInteger cou = 0; cou < 3; cou ++) {
        [self beijing:cou];
    }
    
    for (NSInteger cou = 0; cou < 3; cou ++) {
        [self shenzhen:cou];
    }
    
}

@end
