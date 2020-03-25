//
//  NSArray+Crash.m
//  OptimizedProDemo
//
//  Created by hnbwyh on 2019/3/25.
//  Copyright © 2019 ZhiXingJY. All rights reserved.
//

#import "NSArray+Crash.h"

@implementation NSArray (Crash)

- (id)jx_objectAtIndex:(NSUInteger)index {
    id rlt;
    if (index < self.count) {
        rlt = [self objectAtIndex:index];
    }
    return rlt;
}

@end
