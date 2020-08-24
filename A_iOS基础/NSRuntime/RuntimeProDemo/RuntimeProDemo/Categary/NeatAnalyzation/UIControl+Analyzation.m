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
    SEL sySEL          = @selector(sendAction:to:forEvent:);
    SEL customSEL      = @selector(analyzation_sendAction:to:forEvent:);
    
    Method sysMethod   = class_getInstanceMethod(self, sySEL);
    Method customMethod= class_getInstanceMethod(self, customSEL);
    
    //IMP sysIMP         = method_getImplementation(sysMethod);
    IMP customIMP      = method_getImplementation(customMethod);
    
    BOOL isDidAdd   = class_addMethod(self, sySEL, customIMP, method_getTypeEncoding(customMethod));
    if (isDidAdd) {
        class_replaceMethod(self, sySEL, customIMP, method_getTypeEncoding(customMethod));
    }else {
        method_exchangeImplementations(sysMethod, customMethod);
    }
}

-(void)analyzation_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    
    if (self.custom_acceptEventTime <= 0.0) {
        self.custom_acceptEventTime = NSDate.date.timeIntervalSince1970;
    }
    NSTimeInterval t = NSDate.date.timeIntervalSince1970;
    NSLog(@"\n\n %f - %f \n\n",self.custom_acceptEventTime,t);
    BOOL needSendAction = (t - self.custom_acceptEventTime >= 0.01);
    
    

    // 两次点击的时间间隔小于设定的时间间隔时，才执行响应事件
    NSLog(@"\n\n 拦截analyzation_sendAction : %f \n\n",t - self.custom_acceptEventTime);
    if (needSendAction) {
        [self analyzation_sendAction:action to:target forEvent:event];
        NSLog(@"\n\n 拦截analyzation_sendAction:%@ \n\n",self);
        [XpathParser xpathForView:self];
        self.custom_acceptEventTime = 0.0;
    }
}

- (NSTimeInterval )custom_acceptEventTime{

    return [objc_getAssociatedObject(self, "UIControl_acceptEventTime") doubleValue];
}

- (void)setCustom_acceptEventTime:(NSTimeInterval)custom_acceptEventTime{

    objc_setAssociatedObject(self, "UIControl_acceptEventTime", @(custom_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}



-(NSTimeInterval)acceptEventInterval {
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}

-(void)setAcceptEventInterval:(NSTimeInterval)acceptEventInterval {
    objc_setAssociatedObject(self, _cmd, @(acceptEventInterval), OBJC_ASSOCIATION_RETAIN);
}

@end
