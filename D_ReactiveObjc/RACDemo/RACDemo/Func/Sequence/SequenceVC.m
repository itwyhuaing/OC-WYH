//
//  SequenceVC.m
//  RACDemo
//
//  Created by hnbwyh on 2019/5/7.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "SequenceVC.h"

@interface SequenceVC ()

@end

@implementation SequenceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass(self.class);
    [self replace_arr];
}

// 遍历数组
- (void)test_arr {
    NSArray *arr = @[@"t1",@"t2",@"t3",@"t4",@"t5"];
    [arr.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"\n 数组内容:%@\n",x);
    }];
}

// 遍历字典
- (void)test_dic {
    NSDictionary *dict = @{@"k1":@"v1",@"k2":@"v2",@"k3":@"v3",@"k4":@"v4",@"k5":@"v5"};
    [dict.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        RACTupleUnpack(NSString *key,NSString *value) = x;
        NSLog(@"\n 字典内容: \n key = %@,value = %@\n",key,value);
    }];
    
    [dict.rac_keySequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"\n 字典内容-keySequence:%@\n",x);
    }];
    
    [dict.rac_valueSequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"\n 字典内容-valueSequence:%@\n",x);
    }];
}

// 数组内容替换
- (void)replace_arr {
    NSArray *arr    = @[@"t1",@"t2",@"t3",@"t4",@"t5"];
    NSLog(@"\n测试数组arr内容: \n%@\n",arr);
    NSArray *newArr = [[arr.rac_sequence map:^id _Nullable(id  _Nullable value) {
        NSLog(@"\n 数组内容 :%@ \n",value);
        return @"TestData";
    }] array];
    NSLog(@"\n测试数组newArr内容: \n%@\n",newArr);
    NSArray *nArr = [[arr.rac_sequence mapReplace:@"TestDataPoint"] array];
    NSLog(@"\n测试数组nArr内容: \n%@\n",nArr);
}

@end
