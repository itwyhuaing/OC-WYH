//
//  NSFileManager+JXFileManager.m
//  SafetyProject
//
//  Created by hnbwyh on 2019/5/9.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "NSFileManager+JXFileManager.h"
#import <objc/runtime.h>

@implementation NSFileManager (JXFileManager)

+(void)load {
    NSLog(@"\n categary - load \n");
    SEL sysSEL = @selector(fileExistsAtPath:);
    Method sysMethod = class_getInstanceMethod([self class], sysSEL);
    IMP sysIMP = method_getImplementation(sysMethod);
    
    SEL cusSEL = @selector(jx_fileExistsAtPath:);
    Method cusMethod = class_getInstanceMethod([self class], cusSEL);
    IMP cusIMP = method_getImplementation(cusMethod);
    
//    BOOL didAddMethod = class_addMethod([self class], sysSEL, cusIMP, method_getTypeEncoding(cusMethod));
//    if (didAddMethod) {
//        class_replaceMethod([self class], cusSEL, sysIMP, method_getTypeEncoding(sysMethod));
//    }else {
//        method_exchangeImplementations(sysMethod, cusMethod);
//    }
}

- (BOOL)jx_fileExistsAtPath:(NSString *)path {
    NSLog(@"\n jx_file \n");
    return TRUE;
}

@end
