//
//  NSDictionary+JXCategary.m
//  RuntimeProDemo
//
//  Created by hnbwyh on 2018/4/26.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "NSDictionary+JXCategary.h"
#import <objc/runtime.h>

@implementation NSDictionary (JXCategary)

#pragma mark - 分类重写原有类的方法

+(void)load{

    SEL sysSEL = @selector(setValue:forKey:);
    Method sysMethod = class_getClassMethod([self class], sysSEL);
    
    SEL customSEL = @selector(jxSetValue:forKey:);
    Method customMethod = class_getClassMethod([self class], customSEL);
    
    method_exchangeImplementations(sysMethod, customMethod);
    
}

- (void)jxSetValue:(id)value forKey:(NSString *)key{
    if (value) {
        [self setValue:value forKey:key];
    }
}

#pragma mark - 分类方式增加方法

-(id)jxValueWithKey:(NSString *)key targetCls:(Class)cls{
    id tmp = [self valueForKey:key];
    if (tmp == nil || ![tmp isKindOfClass:cls]) {
        tmp = [cls new];
    }
    return tmp;
}

@end
