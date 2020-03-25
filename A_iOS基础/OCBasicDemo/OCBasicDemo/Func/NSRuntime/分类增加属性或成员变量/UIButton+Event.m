//
//  UIButton+Event.m
//  OCBasicDemo
//
//  Created by hnbwyh on 2019/11/13.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "UIButton+Event.h"
#import <objc/runtime.h>

static char UIButtonCustomIntervalKey;

@implementation UIButton (Event)

-(NSTimeInterval)customInterval {
    return [objc_getAssociatedObject(self, &UIButtonCustomIntervalKey) doubleValue];
}

-(void)setCustomInterval:(NSTimeInterval)customInterval {
    objc_setAssociatedObject(self, &UIButtonCustomIntervalKey, @(customInterval), OBJC_ASSOCIATION_ASSIGN);
}

@end
