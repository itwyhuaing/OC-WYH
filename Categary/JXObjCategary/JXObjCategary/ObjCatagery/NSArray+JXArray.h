//
//  NSArray+JXArray.h
//  JXObjCategary
//
//  Created by hnbwyh on 2018/8/9.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (JXArray)


/**
 查重 - 这里需要注意的是，针对数组中元素为自定义对象时无法实现查重功能

 @param orgArray 原始数组
 @return 查重之后的数组
 */
+ (NSArray *)checkRepetitionWithOriginArray:(NSArray *)orgArray;

@end
