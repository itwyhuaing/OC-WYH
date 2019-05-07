//
//  TestVC.m
//  RACDemo
//
//  Created by hnbwyh on 2019/5/6.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "TestVC.h"

@interface TestVC ()

@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass(self.class);
    [self test_commonApply];
}

- (void)test_commonApply {
    
    // 1. 创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // 2. 发送信号
        [subscriber sendNext:@1];
        
        // 4. 取消订阅
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"\n disposableWithBlock \n");
        }];
        return nil;
    }];
    
    // 3. 订阅信号
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"\n 订阅:\n %@ \n",x);
    }];
    
}


- (void)test_bindSignal {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@1];
        [subscriber sendNext:@2];
        [subscriber sendNext:@3];
        [subscriber sendNext:@4];
        [subscriber sendNext:@5];
        [subscriber sendCompleted];
        return nil;
    }];
    RACSignal *bindSignal = [signal bind:^RACSignalBindBlock _Nonnull{
        return ^(NSNumber *value,BOOL *stop) {
            value = @(value.integerValue * value.integerValue);
            return [RACSignal return:value];
        };
    }];
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"\n signal:\n%@\n",x);
    }];
    [bindSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"\n bindSignal:\n%@\n",x);
    }];
}

- (void)test_bindSignal2 {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@1];
        [subscriber sendNext:@2];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"\n disposableWithBlock \n");
        }];
    }];
    RACSignal *bindSignal = [signal bind:^RACSignalBindBlock _Nonnull{
        return ^(NSNumber *value,BOOL *stop) {
            NSNumber *returnValue = @(value.integerValue * value.integerValue);
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                for (NSInteger i = 0; i < value.integerValue; i ++) {
                    [subscriber sendNext:returnValue];
                }
                return nil;
            }];
        };
    }];
//    [bindSignal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"\n bindSignal:\n%@\n",x);
//    }];
    [bindSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"\n bindSignal:\n%@\n",x);
    } error:^(NSError * _Nullable error) {
        NSLog(@"\n bindSignal-error:\n%@\n",error);
    } completed:^{
        NSLog(@"\n bindSignal-completed\n");
    }];
    
}




@end
