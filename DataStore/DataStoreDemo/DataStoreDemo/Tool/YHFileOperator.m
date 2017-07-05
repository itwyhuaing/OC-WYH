//
//  YHFileOperator.m
//  LXYHOCFunctionsDemo
//
//  Created by hnbwyh on 17/6/8.
//  Copyright © 2017年 lachesismh. All rights reserved.
//

#import "YHFileOperator.h"

@implementation YHFileOperator

+ (NSString *)filePathForFileName:(NSString *)fileName{

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [paths firstObject];
    filePath = [filePath stringByAppendingPathComponent:fileName];
    return filePath;
    
}

+(BOOL)defaultSaveInfo:(id)info forKey:(NSString *)key{
    NSUserDefaults *usrDefault = [NSUserDefaults standardUserDefaults];
    [usrDefault setObject:info forKey:key];
    return [usrDefault synchronize];
}

/**
 isSubclassOfClass :参数为类 - 参数类为其子类或本身
 注意区分：
 isMemberOfClass   ：参数为实例对象 - 参数所属类为其本身
 isKindOfClass     ：参数为实例对   - 参数所属类为其子类或本身
 */
+(id)defaultGetInfoCls:(Class)cls forKey:(NSString *)key{
    NSUserDefaults *usrDefault = [NSUserDefaults standardUserDefaults];
    if ([cls isSubclassOfClass:[NSString class]]) {
        NSLog(@" --NSString-- ");
        return [usrDefault stringForKey:key];
    }else if ([cls isSubclassOfClass:[NSArray class]]){
        NSLog(@" --NSArray-- ");
        return [usrDefault arrayForKey:key];
    }else if ([cls isSubclassOfClass:[NSDictionary class]]){
        NSLog(@" --NSDictionary-- ");
        return [usrDefault dictionaryForKey:key];
    }else{
        NSLog(@" --else-- ");
        return [usrDefault objectForKey:key];
    }
}

@end
