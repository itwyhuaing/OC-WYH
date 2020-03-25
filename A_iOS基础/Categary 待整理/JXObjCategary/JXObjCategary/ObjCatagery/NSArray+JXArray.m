//
//  NSArray+JXArray.m
//  JXObjCategary
//
//  Created by hnbwyh on 2018/8/9.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "NSArray+JXArray.h"

@implementation NSArray (JXArray)

+ (NSArray *)checkRepetitionWithOriginArray:(NSArray *)orgArray{
    NSMutableArray *rlt = [NSMutableArray new];
    if (orgArray) {
        for (id item in orgArray) {
            if (![rlt containsObject:item]) {
                [rlt addObject:item];
            }
        }
    }
    return [NSArray arrayWithArray:rlt];
}

@end
