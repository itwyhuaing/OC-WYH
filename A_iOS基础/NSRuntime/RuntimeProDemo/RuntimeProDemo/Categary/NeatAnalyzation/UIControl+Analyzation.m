//
//  UIControl+Analyzation.m
//  hinabian
//
//  Created by hnbwyh on 2020/8/13.
//  Copyright © 2020 深圳市海那边科技有限公司. All rights reserved.
//

#import "UIControl+Analyzation.h"

@implementation UIControl (Analyzation)

+(void)load {
//    SEL sySEL          = @selector(sendAction:to:forEvent:);
//    SEL customSEL      = @selector(analyzation_sendAction:to:forEvent:);
//    Class cls          = [self class];
//    //Hook_func([self class],sySEL,customSEL);
//    Method sysMethod   = class_getInstanceMethod(cls, sySEL);
//    Method customMethod= class_getInstanceMethod(cls, customSEL);
//    
//    IMP customIMP      = method_getImplementation(customMethod);
//    
//    BOOL isDidAdd   = class_addMethod(cls, sySEL, customIMP, method_getTypeEncoding(customMethod));
//    if (isDidAdd) {
//        class_replaceMethod(cls, sySEL, customIMP, method_getTypeEncoding(customMethod));
//    }else {
//        method_exchangeImplementations(sysMethod, customMethod);
//    }
}

-(void)analyzation_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    [self analyzation_sendAction:action to:target forEvent:event];
    NSLog(@"\n\nhooktest-analyzation_sendAction:%@ \n\n",self);
    [XpathParser xpathForObj:self analyzationType:AnalyzationUIControlType];
}

@end
