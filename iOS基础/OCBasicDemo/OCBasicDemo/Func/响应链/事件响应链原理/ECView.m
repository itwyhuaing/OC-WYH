//
//  ECView.m
//  OCBasicDemo
//
//  Created by hnbwyh on 2019/10/31.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "ECView.h"

@implementation ECView



-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL rlt = CGRectContainsPoint(self.bounds, point);
    NSLog(@"\n\n %s ===> %d \n\n",__FUNCTION__,rlt);
    return rlt;
}

@end
