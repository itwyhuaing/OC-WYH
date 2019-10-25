//
//  NSData+JXData.h
//  JXObjCategary
//
//  Created by hnbwyh on 2018/8/7.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (JXData)

+ (NSData *)dataWithString:(NSString *)string;

+ (NSData *)dataWithDictionary:(NSDictionary *)dictionary;

@end
