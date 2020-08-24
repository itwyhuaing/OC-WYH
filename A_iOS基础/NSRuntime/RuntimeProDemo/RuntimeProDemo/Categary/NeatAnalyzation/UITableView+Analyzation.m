//
//  UITableView+Analyzation.m
//  hinabian
//
//  Created by hnbwyh on 2020/8/14.
//  Copyright © 2020 深圳市海那边科技有限公司. All rights reserved.
//

#import "UITableView+Analyzation.h"


static void Hook_Method(Class originalClass, SEL originalSel, Class replacedClass, SEL replacedSel, SEL noneSel) {
    Method originalMethod = class_getInstanceMethod(originalClass, originalSel);
    Method replacedMethod = class_getInstanceMethod(replacedClass, replacedSel);
    if (!originalMethod) {
        Method noneMethod = class_getInstanceMethod(replacedClass, noneSel);
        BOOL addNoneMethod = class_addMethod(originalClass, originalSel, method_getImplementation(noneMethod), method_getTypeEncoding(noneMethod));
        if (addNoneMethod) {
            //NSLog(@"******** HookUITableView 没有实现 (%@) 方法，手动添加成功！！", NSStringFromSelector(originalSel));
        }else {
            //NSLog(@"******** HookUITableView - else ");
        }
        return;
    }else {
        //NSLog(@"******** HookUITableView - else ");
    }

    BOOL addMethod = class_addMethod(originalClass, replacedSel, method_getImplementation(replacedMethod), method_getTypeEncoding(replacedMethod));
    if (addMethod) {
        //NSLog(@"******** HookUITableView 实现了 (%@) 方法并成功 Hook 为 --> (%@)", NSStringFromSelector(originalSel), NSStringFromSelector(replacedSel));
        Method newMethod = class_getInstanceMethod(originalClass, replacedSel);
        method_exchangeImplementations(originalMethod, newMethod);
    } else {
        //NSLog(@"******** HookUITableView 已替换过，避免多次替换 --> (%@)",NSStringFromClass(originalClass));
    }
}


@implementation UITableView (Analyzation)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originMethod = class_getInstanceMethod([self class], @selector(setDelegate:));
        Method newMethod = class_getInstanceMethod([self class], @selector(analyzation_setDelegate:));
        method_exchangeImplementations(originMethod, newMethod);
    });
    
//    SEL sySEL          = @selector(setDelegate:);
//    SEL customSEL      = @selector(analyzation_setDelegate:);
//
//    Method sysMethod   = class_getInstanceMethod(self, sySEL);
//    Method customMethod= class_getInstanceMethod(self, customSEL);
//
//    //IMP sysIMP         = method_getImplementation(sysMethod);
//    IMP customIMP      = method_getImplementation(customMethod);
//
//    BOOL isDidAdd   = class_addMethod(self, sySEL, customIMP, method_getTypeEncoding(customMethod));
//    if (isDidAdd) {
//        NSLog(@"******** HookUITableView 实现了 (%@) 方法并成功 Hook 为 --> (%@)", NSStringFromSelector(sySEL), NSStringFromSelector(customSEL));
//        method_exchangeImplementations(sysMethod, customMethod);//class_replaceMethod(self, sySEL, customIMP, method_getTypeEncoding(customMethod));
//    }else {
//        NSLog(@"******** HookUITableView 已替换过，避免多次替换 --> (%@)",NSStringFromSelector(customSEL));
//    }
    
}

- (void)analyzation_setDelegate:(id<UITableViewDelegate>)delegate {

    //NSLog(@"******** HookUITableView -  analyzation_setDelegate: %@ ",delegate);
    SEL originalSEL = @selector(tableView:didSelectRowAtIndexPath:);
    SEL newSEL = @selector(analyzation_tableView:didSelectRowAtIndexPath:);

    Hook_Method([delegate class], originalSEL, [self class], newSEL, originalSEL);
    
    
//    SEL sySEL          = @selector(tableView:didSelectRowAtIndexPath:);
//    SEL customSEL      = @selector(analyzation_tableView:didSelectRowAtIndexPath:);
//
//    Method sysMethod   = class_getInstanceMethod([delegate class], sySEL);
//    Method customMethod= class_getInstanceMethod([delegate class], customSEL);
//
//    //IMP sysIMP         = method_getImplementation(sysMethod);
//    IMP customIMP      = method_getImplementation(customMethod);
//    NSLog(@"******** HookUITableView 设置代理 --> (%@)",NSStringFromClass(delegate.class));
//    BOOL isDidAdd   = class_addMethod([delegate class], sySEL, customIMP, method_getTypeEncoding(customMethod));
//    if (isDidAdd) {
//        NSLog(@"******** HookUITableView 实现了 (%@) 方法并成功 Hook 为 --> (%@)", NSStringFromSelector(sySEL), NSStringFromSelector(customSEL));
//        method_exchangeImplementations(sysMethod, customMethod);;//class_replaceMethod([delegate class], sySEL, customIMP, method_getTypeEncoding(customMethod));
//    }else {
//        NSLog(@"******** HookUITableView 已替换过，避免多次替换 --> (%@)",NSStringFromSelector(customSEL));
//    }
    
    
    
    [self analyzation_setDelegate:delegate];
}

#pragma mark - exchangeMethod

// 代理没有实现方法, 添加实现
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@" \n\n 代理没有实现方法, 添加实现 \n\n");
//}

// 代理实现了方法, 进行
- (void)analyzation_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"\n\n 拦截analyzation_tableView:%@ \n\n",self);
    [self analyzation_tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [XpathParser xpathForView:cell];
    
}

@end
