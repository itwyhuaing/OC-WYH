//
//  UIScrollView+Analyzation.m
//  hinabian
//
//  Created by hnbwyh on 2020/8/14.
//  Copyright © 2020 深圳市海那边科技有限公司. All rights reserved.
//

#import "UIScrollView+Analyzation.h"


@implementation UIScrollView (Analyzation)


+(void)load {
//    SEL sySEL          = @selector(scrollViewDidEndDecelerating:);
//    SEL customSEL      = @selector(analyzation_sendAction:to:forEvent:);
//
//    Method sysMethod   = class_getInstanceMethod(self, sySEL);
//    Method customMethod= class_getInstanceMethod(self, customSEL);
//
//    //IMP sysIMP         = method_getImplementation(sysMethod);
//    IMP customIMP      = method_getImplementation(customMethod);
//
//    BOOL isDidAdd   = class_addMethod(self, sySEL, customIMP, method_getTypeEncoding(customMethod));
//    if (isDidAdd) {
//        class_replaceMethod(self, sySEL, customIMP, method_getTypeEncoding(customMethod));
//    }else {
//        method_exchangeImplementations(sysMethod, customMethod);
//    }
}



@end
