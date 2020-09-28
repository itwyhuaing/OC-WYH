//
//  UIView+Analyzation.m
//  hinabian
//
//  Created by hnbwyh on 2020/8/20.
//  Copyright © 2020 深圳市海那边科技有限公司. All rights reserved.
//

#import "UIView+Analyzation.h"


@implementation UIView (Analyzation)

+(void)load {
    SEL sySEL          = @selector(hitTest:withEvent:);
    SEL customSEL      = @selector(analyzation_hitTest:withEvent:);
    Class cls          = [self class];
    //Hook_func([self class],sySEL,customSEL);
    Method sysMethod   = class_getInstanceMethod(cls, sySEL);
    Method customMethod= class_getInstanceMethod(cls, customSEL);

    IMP customIMP      = method_getImplementation(customMethod);

    BOOL isDidAdd   = class_addMethod(cls, sySEL, customIMP, method_getTypeEncoding(customMethod));
    if (isDidAdd) {
        class_replaceMethod(cls, sySEL, customIMP, method_getTypeEncoding(customMethod));
    }else {
        method_exchangeImplementations(sysMethod, customMethod);
    }
}

-(UIView *)analyzation_hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *currentview = [self analyzation_hitTest:point withEvent:event];
    DLog(@"\n analyzation_hitTest点击操作2 : \n %ld \n %@ ",event.allTouches.count,event.allTouches);
    if ([NSStringFromClass(self.class) isEqualToString:@"UIWindow"]){
//        DLog(@"\n analyzation_hitTest点击操作2 : \n %@ \n %@ \n ",self,currentview);
//        [XpathParser xpathForObj:currentview analyzationType:AnalyzationUIViewType];
    }
    return currentview;
}

@end
