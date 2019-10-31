//
//  EAView.m
//  OCBasicDemo
//
//  Created by hnbwyh on 2019/10/31.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "EAView.h"

@implementation EAView

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL rlt = CGRectContainsPoint(self.bounds, point);
    NSLog(@"\n\n %s ===> %d \n\n",__FUNCTION__,rlt);
    return rlt;
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
     NSLog(@"\n\n %s \n\n",__FUNCTION__);
    UIView *rlt = nil;
    if (self.userInteractionEnabled == FALSE) {
        rlt = nil;
    }else if (self.hidden == TRUE){
        rlt = nil;
    }else if (self.alpha <= 0.01){
        rlt = nil;
    }
//    else if ([self pointInside:point withEvent:event] == FALSE){
//        rlt = nil;
//    }
    else{
        NSInteger count = self.subviews.count;
        for (NSInteger cou = 0; cou < count; cou ++) {
            UIView *childView = self.subviews[cou];
            CGPoint cp = [self convertPoint:point toView:childView];
            if ([childView pointInside:cp withEvent:event]) {
                rlt = childView;
            }
        }
    }
    return rlt;
}

@end
