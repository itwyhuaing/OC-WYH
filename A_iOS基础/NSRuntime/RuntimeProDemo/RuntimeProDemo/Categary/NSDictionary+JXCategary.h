//
//  NSDictionary+JXCategary.h
//  RuntimeProDemo
//
//  Created by hnbwyh on 2018/4/26.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JXCategary)

/**
 依据 Key 及 指定 Class 解析字典
 场景：后台返回的数据结构可能会发生改变，以防发生 crash
 */
- (id)jxValueWithKey:(NSString *)key targetCls:(Class)cls;

@end
