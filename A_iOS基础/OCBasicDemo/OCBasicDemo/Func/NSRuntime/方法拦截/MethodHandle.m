//
//  MethodHandle.m
//  OCBasicDemo
//
//  Created by hnbwyh on 2019/11/13.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "MethodHandle.h"
#import <objc/runtime.h>

@implementation MethodHandle

@end


@implementation RTMethodHandleVC (MethodHandle)

+(void)load {
    [self swizzleViewDidLoad];
    [self swizzleViewWillAppear];
    [self swizzleViewDidAppear];
    [self swizzleViewWillDisAppear];
    [self swizzleViewDidDisAppear];
}

+ (void)swizzleViewDidLoad {
    SEL originalSelector = @selector(viewDidLoad);
    SEL swizzledSelector = @selector(rt_ViewDidLoad);
    [self swizzledSelector:swizzledSelector originSelector:originalSelector];
}

+ (void)swizzleViewWillAppear {
    SEL originalSelector = @selector(viewWillAppear:);
    SEL swizzledSelector = @selector(rt_ViewWillAppear:);
    [self swizzledSelector:swizzledSelector originSelector:originalSelector];
}

+ (void)swizzleViewDidAppear {
    SEL originalSelector = @selector(viewDidAppear:);
    SEL swizzledSelector = @selector(rt_ViewDidAppear:);
    [self swizzledSelector:swizzledSelector originSelector:originalSelector];
}

+ (void)swizzleViewWillDisAppear {
    SEL originalSelector = @selector(viewWillDisappear:);
    SEL swizzledSelector = @selector(rt_ViewWillDisAppear:);
    [self swizzledSelector:swizzledSelector originSelector:originalSelector];
}

+ (void)swizzleViewDidDisAppear {
    SEL originalSelector = @selector(viewDidDisappear:);
    SEL swizzledSelector = @selector(rt_ViewDidDisAppear:);
    [self swizzledSelector:swizzledSelector originSelector:originalSelector];
}

+ (void)swizzledSelector:(SEL)swizzledSelector originSelector:(SEL)originSelector {
    Method originalMethod = class_getInstanceMethod([self class], originSelector);
    Method swizzledMethod = class_getInstanceMethod([self class], swizzledSelector);
    BOOL suc = class_addMethod([self class], originSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (suc) {
        class_replaceMethod([self class], swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)rt_ViewDidLoad {
    [self rt_ViewDidLoad];
    NSLog(@"\n\n %s \n\n",__FUNCTION__);
}

- (void)rt_ViewWillAppear:(BOOL)animated {
    NSLog(@"\n\n %s \n\n",__FUNCTION__);
}

- (void)rt_ViewDidAppear:(BOOL)animated {
    NSLog(@"\n\n %s \n\n",__FUNCTION__);
}

- (void)rt_ViewWillDisAppear:(BOOL)animated {
    NSLog(@"\n\n %s \n\n",__FUNCTION__);
}

- (void)rt_ViewDidDisAppear:(BOOL)animated {
    NSLog(@"\n\n %s \n\n",__FUNCTION__);
}

@end
