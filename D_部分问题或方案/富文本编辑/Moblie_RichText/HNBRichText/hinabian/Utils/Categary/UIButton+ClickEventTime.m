//
//  UIButton+ClickEventTime.m
//  hinabian
//
//  Created by hnbwyh on 16/9/18.
//  Copyright © 2016年 &#20313;&#22362;. All rights reserved.
//

#import "UIButton+ClickEventTime.h"
#import <objc/runtime.h>

@implementation UIButton (ClickEventTime)

#pragma mark ----- 拦截系统方法

+(void)load{
    
    SEL sysSEL = @selector(sendAction:to:forEvent:);
    Method systemMethod = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    
    SEL customSEL = @selector(custom_sendAction:to:forEvent:);
    Method customMethod = class_getInstanceMethod(self, @selector(custom_sendAction:to:forEvent:));
    
    // cls：被添加方法的类  name：被添加方法方法名  imp：被添加方法的实现函数  types：被添加方法的实现函数的返回值类型和参数类型的字符串
    BOOL didAddMethod = class_addMethod(self, sysSEL, method_getImplementation(customMethod), method_getTypeEncoding(customMethod));
    if (didAddMethod) {
        class_replaceMethod(self, customSEL, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
    }else{
        method_exchangeImplementations(systemMethod, customMethod);
    }
    
}


#pragma mark ----- 用于替换系统方法的自定义方法

- (void)custom_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    
    // 是否小于设定的时间间隔
    BOOL needSendAction = (NSDate.date.timeIntervalSince1970 - self.custom_acceptEventTime >= self.custom_acceptEventInterval);
    
    // 更新上一次点击时间戳
    if (self.custom_acceptEventInterval > 0) {
        self.custom_acceptEventTime = NSDate.date.timeIntervalSince1970;
    }
    
    // 两次点击的时间间隔小于设定的时间间隔时，才执行响应事件
    if (needSendAction) {
        [self custom_sendAction:action to:target forEvent:event];
        //NSLog(@"111 %s ",__FUNCTION__);
    }
    //NSLog(@"222 %s ",__FUNCTION__);
}

- (NSTimeInterval )custom_acceptEventTime{
    
    return [objc_getAssociatedObject(self, "UIControl_acceptEventTime") doubleValue];
}

- (void)setCustom_acceptEventTime:(NSTimeInterval)custom_acceptEventTime{
    
    objc_setAssociatedObject(self, "UIControl_acceptEventTime", @(custom_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}


#pragma mark ------ 关联

- (NSTimeInterval )custom_acceptEventInterval{
    
    return [objc_getAssociatedObject(self, "UIControl_acceptEventInterval") doubleValue];
}

- (void)setCustom_acceptEventInterval:(NSTimeInterval)custom_acceptEventInterval{
    
    objc_setAssociatedObject(self, "UIControl_acceptEventInterval", @(custom_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
