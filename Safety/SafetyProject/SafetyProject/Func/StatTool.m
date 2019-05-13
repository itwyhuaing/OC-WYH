//
//  StatTool.m
//  SafetyProject
//
//  Created by hnbwyh on 2019/5/9.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "StatTool.h"
#import <sys/stat.h>
#import <dlfcn.h>

@implementation StatTool

+(instancetype)defaultInstance {
    static StatTool *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[StatTool alloc] init];
    });
    return instance;
}

// 亲测已越狱设备读取数据为 "NULL"
- (void)test {
    char *env = getenv("DYLD_INSERT_LIBRARIES");
    NSLog(@"\n 测试点:\n %s \n",env);
}

- (void)test2 {
    
//    // 使用stat系列函数检测Cydia等工具
//    struct stat stat_info;
//    if (0 == stat("/Applications/Cydia.app", &stat_info)) {
//        exit(0);
//    }
//
//    // 你可以看看stat是不是出自系统库，有没有被攻击者换掉：如果结果不是 /usr/lib/system/libsystem_kernel.dylib 的话，那就100%被攻击了。
//    // 如果 libsystem_kernel.dylib 都是被攻击者替换掉的……
//    int ret;
//    Dl_info dylib_info;
//    int (*func_stat)(const char *, struct stat *) = stat;
//    if ((ret = dladdr(func_stat, &dylib_info))) {
//        NSString *str = [NSString stringWithFormat:@"%s",dylib_info.dli_fname];
//        if (![str isEqualToString:@"/usr/lib/system/libsystem_kernel.dylib"]) {
//            exit(0);
//        }
//    }
//
//    //通常情况下，会包含越狱机的输出结果会包含字符串： Library/MobileSubstrate/MobileSubstrate.dylib 。
//    uint32_t count = _dyld_image_count();
//    for (uint32_t i = 0 ; i < count; ++i) {
//        NSString *name = [[NSString alloc]initWithUTF8String:_dyld_get_image_name(i)];
//        if ([name containsString:@"Library/MobileSubstrate/MobileSubstrate.dylib"]) {
//            exit(0);
//        }
//    }
//
//    //未越狱设备返回结果是null。
//    char *env = getenv("DYLD_INSERT_LIBRARIES");
//    if(env){
//        exit(0);
//    }
    
}

@end
