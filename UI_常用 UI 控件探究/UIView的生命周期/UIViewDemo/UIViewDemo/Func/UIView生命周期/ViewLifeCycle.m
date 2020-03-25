//
//  ViewLifeCycle.m
//  UIViewDemo
//
//  Created by hnbwyh on 2019/10/11.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "ViewLifeCycle.h"

@interface ViewLifeCycle ()

@end

@implementation ViewLifeCycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@" \n init ： %@ \n ",self);
    }
    return self;
}

-(void)willMoveToSuperview:(UIView *)newSuperview {
    NSLog(@" \n willMoveToSuperview ： %@ \n ",newSuperview);
}

-(void)didMoveToSuperview {
    NSLog(@" \n didMoveToSuperview  \n ");
}

-(void)didAddSubview:(UIView *)subview {
    NSLog(@" \n didAddSubview ： %@ \n ",subview);
}

-(void)willMoveToWindow:(UIWindow *)newWindow {
    NSLog(@" \n willMoveToWindow ： %@ \n ",newWindow);
}

-(void)didMoveToWindow {
    NSLog(@" \n didMoveToWindow  \n ");
}

@end
