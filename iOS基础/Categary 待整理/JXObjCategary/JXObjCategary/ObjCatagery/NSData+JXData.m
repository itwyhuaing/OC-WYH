//
//  NSData+JXData.m
//  JXObjCategary
//
//  Created by hnbwyh on 2018/8/7.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "NSData+JXData.h"

@implementation NSData (JXData)

+(NSData *)dataWithString:(NSString *)string{
    NSData *rlt;
    rlt = string ? [string dataUsingEncoding:NSUTF8StringEncoding] : nil;
    return rlt;
}

+(NSData *)dataWithDictionary:(NSDictionary *)dictionary{
    NSData *rlt;
    rlt = dictionary ? [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil] : nil;
    return rlt;
}

@end
