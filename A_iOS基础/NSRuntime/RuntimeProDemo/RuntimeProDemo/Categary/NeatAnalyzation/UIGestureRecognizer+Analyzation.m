//
//  UIGestureRecognizer+Analyzation.m
//  hinabian
//
//  Created by hnbwyh on 2020/8/14.
//  Copyright © 2020 深圳市海那边科技有限公司. All rights reserved.
//

#import "UIGestureRecognizer+Analyzation.h"

@implementation UIGestureRecognizer (Analyzation)

+ (void)load {
    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Method originMethod = class_getInstanceMethod([self class], @selector(setDelegate:));
//        Method newMethod = class_getInstanceMethod([self class], @selector(analyzation_setDelegate:));
//        method_exchangeImplementations(originMethod, newMethod);
//    });
    
}


- (void)analyzation_setDelegate:(id<UIGestureRecognizerDelegate>)delegate {
    
    SEL originalSEL = @selector(gestureRecognizerShouldBegin:);
    SEL newSEL = @selector(analyzation_gestureRecognizerShouldBegin:);
    Hook_Method([delegate class], originalSEL, [self class], newSEL, originalSEL);
    
    
//    SEL originalSEL2 = @selector(gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:);
//    SEL newSEL2 = @selector(analyzation_gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:);
//    Hook_Method([delegate class], originalSEL2, [self class], newSEL2, originalSEL2);
    
    [self analyzation_setDelegate:delegate];
    
}

#pragma mark - delegate

//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//    return TRUE;
//}

- (BOOL)analyzation_gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    BOOL rlt = TRUE;
    if ([@"UITapGestureRecognizer" isEqualToString:NSStringFromClass(gestureRecognizer.class)]) {
        NSLog(@"\n\n hooktest-analyzation_gesture -1 : \n %@ \n 手势: %@ \n",self,gestureRecognizer);
        //[XpathParser xpathForObj:self gesture:gestureRecognizer];
    }
    
//    else if ([self respondsToSelector:@selector(analyzation_gestureRecognizerShouldBegin:)]){
//        NSLog(@"\n\n hooktest-analyzation_gesture -20 : \n %@ \n 手势: %@ \n",self,gestureRecognizer);
//        rlt = [self analyzation_gestureRecognizerShouldBegin:gestureRecognizer];
//    }else if ([self respondsToSelector:@selector(gestureRecognizerShouldBegin:)]){
//        NSLog(@"\n\n hooktest-analyzation_gesture -21 : \n %@ \n 手势: %@ \n",self,gestureRecognizer);
//        //rlt = [self gestureRecognizerShouldBegin:gestureRecognizer];
//    }else {
//        NSLog(@"\n\n hooktest-analyzation_gesture -3 : \n %@ \n 手势: %@ \n",self,gestureRecognizer);
//        rlt = TRUE;
//    }
    
    return rlt;
}

//
//- (BOOL)analyzation_gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    BOOL rlt = FALSE;
//
//    DLog(@"\n 数据测试 : \n %@ \n\n",gestureRecognizer);
//
//    //rlt = [self analyzation_gestureRecognizer:gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer];
//    return rlt;
//}


@end
