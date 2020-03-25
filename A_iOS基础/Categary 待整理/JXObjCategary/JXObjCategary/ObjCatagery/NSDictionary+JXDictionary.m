//
//  NSDictionary+JXDictionary.m
//  JXObjCategary
//
//  Created by hnbwyh on 2018/8/7.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "NSDictionary+JXDictionary.h"

@implementation NSDictionary (JXDictionary)

+(NSDictionary *)dictionaryWithData:(NSData *)data{
    NSDictionary *rlt;
    rlt = data ? [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil] : nil;
    return rlt;
}

+(NSDictionary *)dictionaryWithJsonString:(NSString *)string{
    NSDictionary *rlt = nil;
    if (string) {
        NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
         rlt = [NSJSONSerialization JSONObjectWithData:jsonData
                                                           options:NSJSONReadingMutableContainers
                                                             error:nil];
        
    }
    return rlt;
}

@end
