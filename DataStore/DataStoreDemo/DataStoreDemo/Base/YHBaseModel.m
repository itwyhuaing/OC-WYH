//
//  YHBaseModel.m
//  DataStoreDemo
//
//  Created by hnbwyh on 2018/7/19.
//  Copyright © 2018年 hainbwyh. All rights reserved.
//

#import "YHBaseModel.h"
#import <objc/runtime.h>

@interface YHBaseModel () <NSCoding>

@end

@implementation YHBaseModel

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([self class], &count);
        for (NSInteger index = 0; index < count; index ++) {
            Ivar ivar = ivars[index];
            const char *keyName = ivar_getName(ivar);
            NSString *keyNameString = [NSString stringWithCString:keyName encoding:NSUTF8StringEncoding];
            //NSLog(@"\n initWithCoder:%@ \n",keyNameString);
            id value = [aDecoder decodeObjectForKey:keyNameString];
            [self setValue:value forKey:keyNameString];
        }
        free(ivars);
    }
    return self;
}


-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    unsigned int count = 0;
    // 1. runtime 技术获取实例变量列表
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (NSInteger index = 0; index < count; index ++) {
        Ivar ivar = ivars[index];
        // 2. 遍历获取变量 “名字” ，并转换成 OC 对象 --- 相应的类型同样可取
        const char *keyName = ivar_getName(ivar);
        const char *type = ivar_getTypeEncoding(ivar);
        NSString *typeString = [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
        NSString *keyNameString = [NSString stringWithCString:keyName encoding:NSUTF8StringEncoding];
        NSLog(@"\n \n key :%@ \n type:%@\n \n",keyNameString,typeString);
        // 3. KVC 技术获取 value
        id value = [self valueForKey:keyNameString];
        // 4. 归档
        [aCoder encodeObject:value forKey:keyNameString];
    }
    // 5. 对 C 语言(不具备ARC功能)部分涉及 Copy 操作的部分注意内存释放问题
    free(ivars);
}

@end
