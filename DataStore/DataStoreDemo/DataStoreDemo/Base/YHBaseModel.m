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
            id value = [aDecoder decodeObjectForKey:keyNameString];
            [self setValue:value forKey:keyNameString];
        }
        free(ivars);
    }
    return self;
}


-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (NSInteger index = 0; index < count; index ++) {
        Ivar ivar = ivars[index];
        const char *keyName = ivar_getName(ivar);
        //const char *type = ivar_getTypeEncoding(ivar);
        NSString *keyNameString = [NSString stringWithCString:keyName encoding:NSUTF8StringEncoding];
        id value = [self valueForKey:keyNameString];
        [aCoder encodeObject:value forKey:keyNameString];
    }
    free(ivars);
}

@end
