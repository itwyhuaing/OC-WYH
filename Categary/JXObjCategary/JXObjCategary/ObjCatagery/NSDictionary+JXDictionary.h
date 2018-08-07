//
//  NSDictionary+JXDictionary.h
//  JXObjCategary
//
//  Created by hnbwyh on 2018/8/7.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JXDictionary)

+ (NSDictionary *)dictionaryWithData:(NSData *)data;


/**
 Json字符串 转字典

 @param string 待转化的Json字符串
 @return 转化结果
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)string;

@end
