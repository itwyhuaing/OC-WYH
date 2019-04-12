//
//  UIControl+ClickEvent.m
//  Share
//
//  Created by hnbwyh on 16/9/8.
//  Copyright © 2016年 hnbwyh. All rights reserved.
//

#import "UIControl+ClickEvent.h"
#import <objc/runtime.h>


@implementation UIControl (ClickEvent)

#pragma mark ----- 拦截系统方法 - 添加、替换、交换

+(void)load{

    SEL sysSEL = @selector(sendAction:to:forEvent:);
    Method systemMethod = class_getInstanceMethod(self, sysSEL);
    IMP systemIMP = method_getImplementation(systemMethod);
    
    SEL customSEL = @selector(custom_sendAction:to:forEvent:);
    Method customMethod = class_getInstanceMethod(self, customSEL);
    IMP customIMP = method_getImplementation(customMethod);

    BOOL didAddMethod = class_addMethod(self, sysSEL, customIMP, method_getTypeEncoding(customMethod));
    if (didAddMethod) {
        class_replaceMethod(self, customSEL, systemIMP, method_getTypeEncoding(systemMethod));
    }else{
        method_exchangeImplementations(systemMethod, customMethod);
    }

}

#pragma mark ----- 用于替换的系统方法

- (void)custom_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    
    // 如果想要设置统一的间隔时间，可以在此处加上以下几句
    // 值得提醒一下：如果这里设置了统一的时间间隔，会影响UISwitch,如果想统一设置，又不想影响UISwitch，建议将UIControl分类，改成UIButton分类，实现方法是一样的
    // if (self.custom_acceptEventInterval <= 0) {
    //    如果没有自定义时间间隔，则默认为2秒
    //    self.custom_acceptEventInterval = 2;
    // }

    // 是否小于设定的时间间隔
    BOOL needSendAction = (NSDate.date.timeIntervalSince1970 - self.custom_acceptEventTime >= self.custom_acceptEventInterval);
    
    // 更新上一次点击时间戳
    if (self.custom_acceptEventInterval > 0) {
        self.custom_acceptEventTime = NSDate.date.timeIntervalSince1970;
    }
    
    // 两次点击的时间间隔小于设定的时间间隔时，才执行响应事件
    if (needSendAction) {
        [self custom_sendAction:action to:target forEvent:event];
    }
    
}

- (NSTimeInterval )custom_acceptEventTime{

    return [objc_getAssociatedObject(self, "UIControl_acceptEventTime") doubleValue];
}

- (void)setCustom_acceptEventTime:(NSTimeInterval)custom_acceptEventTime{

    objc_setAssociatedObject(self, "UIControl_acceptEventTime", @(custom_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

#pragma mark ------ 添加公有属性

- (NSTimeInterval )custom_acceptEventInterval{

    //return [objc_getAssociatedObject(self, "UIControl_acceptEventInterval") doubleValue];
    
    return [objc_getAssociatedObject(self,_cmd) doubleValue];
    
}

- (void)setCustom_acceptEventInterval:(NSTimeInterval)custom_acceptEventInterval{

    //objc_setAssociatedObject(self, "UIControl_acceptEventInterval", @(custom_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, @selector(custom_acceptEventInterval), [NSString stringWithFormat:@"%f",custom_acceptEventInterval], OBJC_ASSOCIATION_ASSIGN);
    
}

- (NSString *)testProperty{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setTestProperty:(NSString *)testProperty{
    objc_setAssociatedObject(self, @selector(testProperty), testProperty, OBJC_ASSOCIATION_COPY);
}


static char MethodKey;
-(NSString *)method{
    return objc_getAssociatedObject(self, &MethodKey);
}

-(void)setMethod:(NSString *)method{
    objc_setAssociatedObject(self, &MethodKey, method, OBJC_ASSOCIATION_COPY);
}

@end
