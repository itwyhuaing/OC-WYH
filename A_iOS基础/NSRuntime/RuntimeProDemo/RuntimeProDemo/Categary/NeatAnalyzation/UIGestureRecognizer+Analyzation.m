//
//  UIGestureRecognizer+Analyzation.m
//  hinabian
//
//  Created by hnbwyh on 2020/8/14.
//  Copyright © 2020 深圳市海那边科技有限公司. All rights reserved.
//

#import "UIGestureRecognizer+Analyzation.h"


@implementation UIGestureRecognizer (Analyzation)

static void Hook_Method(Class originalClass, SEL originalSel, Class replacedClass, SEL replacedSel, SEL noneSel) {
    Method originalMethod = class_getInstanceMethod(originalClass, originalSel);
    Method replacedMethod = class_getInstanceMethod(replacedClass, replacedSel);
    if (!originalMethod) {
        Method noneMethod = class_getInstanceMethod(replacedClass, noneSel);
        BOOL addNoneMethod = class_addMethod(originalClass, originalSel, method_getImplementation(noneMethod), method_getTypeEncoding(noneMethod));
        if (addNoneMethod) {
            //NSLog(@"******** 没有实现 (%@) 方法，手动添加成功！！", NSStringFromSelector(originalSel));
        }
        return;
    }

    BOOL addMethod = class_addMethod(originalClass, replacedSel, method_getImplementation(replacedMethod), method_getTypeEncoding(replacedMethod));
    if (addMethod) {
        //NSLog(@"******** 实现了 (%@) 方法并成功 Hook 为 --> (%@)", NSStringFromSelector(originalSel), NSStringFromSelector(replacedSel));
        Method newMethod = class_getInstanceMethod(originalClass, replacedSel);
        method_exchangeImplementations(originalMethod, newMethod);
    } else {
        //NSLog(@"******** 已替换过，避免多次替换 --> (%@)",NSStringFromClass(originalClass));
    }
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originMethod = class_getInstanceMethod([self class], @selector(setDelegate:));
        Method newMethod = class_getInstanceMethod([self class], @selector(analyzation_setDelegate:));
        method_exchangeImplementations(originMethod, newMethod);
    });
    
//    Method originMethod = class_getInstanceMethod([self class], @selector(setDelegate:));
//    Method newMethod = class_getInstanceMethod([self class], @selector(analyzation_setDelegate:));
//    method_exchangeImplementations(originMethod, newMethod);
    
    
//    SEL originalSEL = @selector(gestureRecognizerShouldBegin:);
//    SEL newSEL = @selector(analyzation_gestureRecognizerShouldBegin:);
//    Hook_Method(self, originalSEL, [self class], newSEL, originalSEL);
    
}


- (void)analyzation_setDelegate:(id<UIGestureRecognizerDelegate>)delegate {
    
    //NSLog(@"\n %s \n %@ \n",__FUNCTION__,delegate);
    
    SEL originalSEL = @selector(gestureRecognizerShouldBegin:);
    SEL newSEL = @selector(analyzation_gestureRecognizerShouldBegin:);
    Hook_Method([delegate class], originalSEL, [self class], newSEL, originalSEL);
    [self analyzation_setDelegate:delegate];
}

#pragma mark - delegate

- (BOOL)analyzation_gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    NSLog(@"\n\n 拦截analyzation_gesture:%@ \n\n",self);
    [XpathParser xpathForView:gestureRecognizer.view];
    return TRUE;//[gestureRecognizer.view analyzation_gestureRecognizerShouldBegin:gestureRecognizer];;//
}

@end
