//
//  TimerVC.m
//  RACDemo
//
//  Created by hnbwyh on 2019/5/5.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "TimerVC.h"

@interface TimerVC ()

@end

@implementation TimerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title                = NSStringFromClass(self.class);
    [self test];
}

// 定时器 - 延迟3秒
- (void)test {
    
//    RACSignal *timerSignal = [RACSignal interval:1.0f onScheduler:[RACScheduler mainThreadScheduler]];
//    timerSignal = [timerSignal take:30.0];
//    [timerSignal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"\n x:\n %@ \n",x);
//    } completed:^{
//        NSLog(@"\n 计时完成 \n");
//    }];

//    [[[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        [subscriber sendNext:@"测试数据"];
//        return nil;
//    }] delay:3.0] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"\n %@ \n",x);
//    }];
    
    RACSignal *racNal = [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"测试数据"];
        return nil;
    }] delay:3.0];
    [racNal subscribeNext:^(id  _Nullable x) {
        NSLog(@"\n %@ \n",x);
    }];

}

@end
