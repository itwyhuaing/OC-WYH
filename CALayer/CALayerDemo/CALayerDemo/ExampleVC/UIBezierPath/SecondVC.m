//
//  SecondVC.m
//  CALayerDemo
//
//  Created by hnbwyh on 2018/2/8.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "SecondVC.h"

@interface SecondVC ()
{
    CGPoint startPoint;
    CGPoint controlPoint;
    CGPoint endPoint;
}
@end

@implementation SecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self makeUpPoint];         // 制定坐标位置
    [self pathStraightLine];    // 依据点绘制直线线条
    [self path2];
    
}

- (void)makeUpPoint{
    startPoint = CGPointZero;
    controlPoint = CGPointZero;
    endPoint = CGPointZero;
    startPoint.x = 30.0;
    startPoint.y = self.view.center.y;
    endPoint.x = [UIScreen mainScreen].bounds.size.width - startPoint.x;
    endPoint.y = startPoint.y;
    controlPoint.x = (endPoint.x - startPoint.x) / 2.0 + startPoint.x;
    controlPoint.y = startPoint.y - 120.0;
    [self addLabelWithCenterPoint:startPoint];
    [self addLabelWithCenterPoint:controlPoint];
    [self addLabelWithCenterPoint:endPoint];
    
}

- (void)addLabelWithCenterPoint:(CGPoint)p{
    CGRect rect = CGRectMake(0, 0, 5.0, 5.0);
    UILabel *l = [[UILabel alloc] initWithFrame:rect];
    [l setCenter:p];
    l.backgroundColor = [UIColor redColor];
    [self.view addSubview:l];
}

// - (void)moveToPoint:(CGPoint)point;
//  - (void)addLineToPoint:(CGPoint)point;
// - (void)closePath;
- (void)pathStraightLine{
    // path
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    [path addLineToPoint:controlPoint];
    [path addLineToPoint:endPoint];
    [path closePath]; // [path addLineToPoint:startPoint]; 在这里两种方式均可实现闭环线条
    
    // layer
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.strokeColor = UIColor.greenColor.CGColor;
    layer.fillColor = UIColor.clearColor.CGColor;
    [self.view.layer addSublayer:layer];
    
}

// - (void)moveToPoint:(CGPoint)point;
// - (void)addQuadCurveToPoint:(CGPoint)endPoint controlPoint:(CGPoint)controlPoint;
// - (void)closePath;
- (void)path2{
    // path
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    [path addQuadCurveToPoint:endPoint controlPoint:controlPoint];
    [path closePath];
    
    // layer
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.strokeColor = UIColor.cyanColor.CGColor;
    layer.fillColor = UIColor.clearColor.CGColor;
    [self.view.layer addSublayer:layer];
    
}

@end
