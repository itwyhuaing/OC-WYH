//
//  UIButton+JXButton.m
//  JXObjCategary
//
//  Created by hnbwyh on 2018/7/16.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "UIButton+JXButton.h"
#import <objc/runtime.h>

static char kAcceptEventCustomInterval;
static char KUIControlAcceptEventTime;


@implementation UIButton (JXButton)

#pragma mark ------ 拦截系统方法

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


#pragma mark ------ 用于替换系统方法的自定义方法

- (void)custom_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    
    // 是否小于设定的时间间隔
    BOOL needSendAction = (NSDate.date.timeIntervalSince1970 - self.custom_acceptEventTime >= self.acceptEventCustomInterval);
    
    // 更新上一次点击时间戳
    if (self.acceptEventCustomInterval > 0) {
        self.custom_acceptEventTime = NSDate.date.timeIntervalSince1970;
    }
    
    // 两次点击的时间间隔小于设定的时间间隔时，才执行响应事件
    if (needSendAction) {
        [self custom_sendAction:action to:target forEvent:event];
    }
}

- (NSTimeInterval )custom_acceptEventTime {
    return [objc_getAssociatedObject(self, &KUIControlAcceptEventTime) doubleValue];
}

- (void)setCustom_acceptEventTime:(NSTimeInterval)custom_acceptEventTime {
    objc_setAssociatedObject(self, &KUIControlAcceptEventTime, @(custom_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark ------ 添加属性设置

- (NSTimeInterval)acceptEventCustomInterval{
    return [objc_getAssociatedObject(self, &kAcceptEventCustomInterval) doubleValue];
}

-(void)setAcceptEventCustomInterval:(NSTimeInterval)acceptEventCustomInterval{
    objc_setAssociatedObject(self, &kAcceptEventCustomInterval, @(acceptEventCustomInterval), OBJC_ASSOCIATION_ASSIGN);
}

@end
