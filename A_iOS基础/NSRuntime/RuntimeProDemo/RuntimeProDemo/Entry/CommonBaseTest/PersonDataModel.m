//
//  PersonDataModel.m
//  RuntimeProDemo
//
//  Created by hnbwyh on 2018/1/30.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "PersonDataModel.h"


@implementation PersonDataModel

#pragma mark ------ 测试方法

+ (void)testClsMethod11{
    NSLog(@" %s ",__FUNCTION__);
}

+ (NSString *)testClsMethod12{
    NSLog(@" %s ",__FUNCTION__);
    return @"testClsMethod12";
}

- (void)testInstanceMethod21{
    NSLog(@" %s ",__FUNCTION__);
}

- (NSString *)testInstanceMethod22{
    NSLog(@" %s ",__FUNCTION__);
    return @"testInstanceMethod22";
}


#pragma mark ------ 归档解档

// 归档
- (void)encodeWithCoder:(NSCoder *)coder
{
    unsigned int count = 0;
    objc_property_t *propertys = class_copyPropertyList([self class], &count);
    for (NSInteger i = 0; i < count; i ++) {
        objc_property_t property = propertys[i];
        const char *propertyName = property_getName(property);
        NSString *key = [NSString stringWithUTF8String:propertyName];
        NSString *value = [self valueForKey:key];
        NSLog(@" \n \n encodeWithCoder \n \n \n key:%@ - value:%@ \n ",key,value);
        [coder encodeObject:value forKey:key];
    }
    
}


// 解档
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        unsigned int count = 0;
        objc_property_t *propertys = class_copyPropertyList([self class], &count);
        for (NSInteger i = 0; i < count; i ++) {
            objc_property_t property = propertys[i];
            const char *propertyName = property_getName(property);
            NSString *key = [NSString stringWithUTF8String:propertyName];
            NSString *value = [coder decodeObjectForKey:key];
            NSLog(@" \n \n initWithCoder \n \n \n key:%@ - value:%@ \n ",key,value);
            [self setValue:value forKey:key];
        }
        free(propertys);
    }
    return self;
    
}



@end
