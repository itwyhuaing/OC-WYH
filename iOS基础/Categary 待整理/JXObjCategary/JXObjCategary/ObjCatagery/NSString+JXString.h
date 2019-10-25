//
//  NSString+JXString.h
//  JXObjCategary
//
//  Created by hnbwyh on 2018/8/7.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JXString)

+ (NSString *)stringWithData:(NSData *)data;


/**
 字典 转 Json字符串

 @param dictionary 待转化字典
 @return json 字符串
 */
+ (NSString *)stringWithDictionary:(NSDictionary *)dictionary;

@end
