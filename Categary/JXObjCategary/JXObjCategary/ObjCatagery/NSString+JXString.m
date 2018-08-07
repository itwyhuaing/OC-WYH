//
//  NSString+JXString.m
//  JXObjCategary
//
//  Created by hnbwyh on 2018/8/7.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "NSString+JXString.h"

@implementation NSString (JXString)

+(NSString *)stringWithData:(NSData *)data{
    NSString *rlt;
    rlt = data ? [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] : nil;
    return rlt;
}

+(NSString *)stringWithDictionary:(NSDictionary *)dictionary{
    NSString *rlt;
    NSData *data = dictionary ? [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil] : nil;
    rlt = data ? [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] : nil;
    return rlt;
}

@end
