//
//  TestVC3.m
//  GCDProjectDemo
//
//  Created by wangyinghua on 2018/8/25.
//  Copyright © 2018年 ZhiXing. All rights reserved.
//

#import "TestVC3.h"

@interface TestVC3 ()

@end

@implementation TestVC3

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

#pragma mark -

- (void)time{
    /**
     dispatch_time(<#dispatch_time_t when#>, <#int64_t delta#>);
     xnull * NSEC_PER_SEC 乘积得到单位为好微妙的数值。 "ull" 是 C 语言的数值字面量，是显式表明类型时使用的字符串 ：unsigned long long 。如果 NSEC_PER_MSEC 则可以以毫秒单位计算。
     */
    // 从现在起 1 秒后的 dispatch_time_t 类型值
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 1ull * NSEC_PER_SEC);
    
    // 从现在起 150 毫秒后的 dispatch_time_t 类型值
    dispatch_time_t mtime = dispatch_time(DISPATCH_TIME_NOW, 150ull * NSEC_PER_MSEC);
    
}

@end
