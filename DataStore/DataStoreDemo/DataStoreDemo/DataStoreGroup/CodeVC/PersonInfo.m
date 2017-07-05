//
//  PersonInfo.m
//  LXYHOCFunctionsDemo
//
//  Created by wangyinghua on 2017/6/8.
//  Copyright © 2017年 lachesismh. All rights reserved.
//

#import "PersonInfo.h"
#import <objc/runtime.h>

@interface PersonInfo ()<NSCoding>

@end

@implementation PersonInfo

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
        const char *type = ivar_getTypeEncoding(ivar);
        NSString *keyNameString = [NSString stringWithCString:keyName encoding:NSUTF8StringEncoding];
        id value = [self valueForKey:keyNameString];
        [aCoder encodeObject:value forKey:keyNameString];
    }
    free(ivars);
}

@end
