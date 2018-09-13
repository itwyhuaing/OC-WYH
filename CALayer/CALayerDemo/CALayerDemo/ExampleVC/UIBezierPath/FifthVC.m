//
//  FifthVC.m
//  CALayerDemo
//
//  Created by hnbwyh on 2018/9/13.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "FifthVC.h"

@interface FifthVC ()

@end

@implementation FifthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = FALSE;
    self.title = NSStringFromClass(self.class);
    
    CGPoint p1 = CGPointMake(20, 300);
    CGPoint p2 = CGPointMake(50, 180);
    CGPoint p3 = CGPointMake(80, 260);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:p1];
    [path addLineToPoint:p2];
    [path addLineToPoint:p3];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = [[UIColor blackColor] CGColor]; //[[[UIColor blackColor] colorWithAlphaComponent:0.1] CGColor];
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    shapeLayer.lineWidth = 1;
    [self.view.layer addSublayer:shapeLayer];
    
}

@end
