//
//  JXSafety.m
//  SafetyProject
//
//  Created by hnbwyh on 2019/5/9.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "JXSafety.h"
#import <UIKit/UIKit.h>
#import "NSFileManager+JXFileManager.h"

@implementation JXSafety

+(instancetype)defaultInstance {
    static JXSafety *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[JXSafety alloc] init];
    });
    return instance;
}

// fileExistsAtPath 可能被 hook
- (BOOL)detectionSystem {
    BOOL rlt = TRUE;
    NSString *cydiaPath         = @"/Applications/Cydia.app";
    NSString *aptPath           = @"/private/var/lib/apt/";
    NSString *applications      = @"/User/Applications/";
    NSString *mobile            = @"/Library/MobileSubstrate/MobileSubstrate.dylib";
    NSString *sd                = @"/etc/apt";
    
    NSString *sshd              = @"/usr/sbin/sshd";
    NSString *bash              = @"/bin/bash";
    if ([[NSFileManager defaultManager] fileExistsAtPath:cydiaPath]) {
        NSLog(@"\n cydiaPath \n");
        rlt = FALSE;
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:aptPath]) {
        NSLog(@"\n aptPath \n");
        rlt = FALSE;
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:applications]) {
        NSLog(@"\n applications \n");
        rlt = FALSE;
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:mobile]) {
        NSLog(@"\n mobile \n");
        rlt = FALSE;
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:bash]) {
        NSLog(@"\n bash \n");
        rlt = FALSE;
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:sshd]) {
        NSLog(@"\n sshd \n");
        rlt = FALSE;
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:sd]) {
        NSLog(@"\n sd \n");
        rlt = FALSE;
    }
    return rlt;
}

// URL Scheme 可能被修改
- (BOOL)detectionSysytemSafety {
    BOOL rlt = TRUE;
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://"]]) {
        NSLog(@"The device is jail broken!");
        rlt = FALSE;
    }
    return rlt;
}

// 亲测无法读取数据
- (BOOL)detectionSystemSafaty3 {
    BOOL rlt = TRUE;
    NSString *rootPath = @"/User/Applications/";
    if ([[NSFileManager defaultManager] fileExistsAtPath:rootPath]) {
        NSArray *applist = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:rootPath error:nil];
        if (applist && applist.count > 0) {
            NSLog(@"\n applist:\n %@ \n",applist);
            rlt = FALSE;
        }
    }
    return rlt;
}

@end
