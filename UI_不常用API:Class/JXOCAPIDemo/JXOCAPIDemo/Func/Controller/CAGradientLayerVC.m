//
//  CAGradientLayerVC.m
//  JXOCAPIDemo
//
//  Created by hnbwyh on 2018/11/22.
//  Copyright © 2018年 JiXia. All rights reserved.
//

#import "CAGradientLayerVC.h"

@interface CAGradientLayerVC ()

@end

@implementation CAGradientLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [self lineStyle];
    
    //[self circleStyle];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)lineStyle{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    CAGradientLayer *gradient   = [CAGradientLayer layer];
    gradient.frame              = v.bounds;
    gradient.startPoint         = CGPointMake(0, 0);
    gradient.endPoint           = CGPointMake(1, 1);
    gradient.locations          = @[@0.3, @0.5, @0.6];
    gradient.colors             = [NSArray arrayWithObjects:
                       (id)[UIColor redColor].CGColor,
                       (id)[UIColor greenColor].CGColor,
                       (id)[UIColor blueColor].CGColor,
                       nil];
    [v.layer addSublayer:gradient];
    [self.view addSubview:v];
}

/**
 1. CALayer 具有绘制能力
 2. CALayer 具有切割能力(layer 的 mask 属性)
 */
- (void)circleStyle{
    //创建圆弧路径
    UIBezierPath * path      = [UIBezierPath bezierPathWithArcCenter:CGPointMake(50, 50) radius:45 startAngle:- 7.0 / 6 * M_PI endAngle:M_PI / 6 clockwise:YES];
    
    //添加圆弧Layer
    //[self.view.layer addSublayer:[self createShapeLayerWithPath:path]];
    
    //配置左色块CAGradientLayer
    CAGradientLayer * leftL  = [self createGradientLayerWithColors:@[(id)[UIColor redColor].CGColor,(id)[UIColor yellowColor].CGColor]];
    leftL.position           = CGPointMake(25, 40);
    
    //配置右色块CAGradientLayer
    CAGradientLayer * rightL = [self createGradientLayerWithColors:@[(id)[UIColor greenColor].CGColor,(id)[UIColor yellowColor].CGColor]];
    rightL.position          = CGPointMake(75, 40);
    
// 1. 将两个色块拼接到同一个layer并添加到self.view
    CALayer * layer          = [CALayer layer];
    layer.bounds             = CGRectMake(0, 0, 100, 80);
    layer.position           = self.view.center;
    [layer addSublayer:leftL];
    [layer addSublayer:rightL];
    [self.view.layer addSublayer:layer];
    
// 2. 创建一个ShapeLayer作为mask
    CAShapeLayer * mask = [self createShapeLayerWithPath:path];
    mask.position       = CGPointMake(50, 40);
    layer.mask          = mask;
    //mask.strokeEnd      = 1;
}

//依照路径创建并返回一个 CAShapeLayer
-(CAShapeLayer *)createShapeLayerWithPath:(UIBezierPath *)path {
    
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.path           = path.CGPath;
    layer.bounds         = CGRectMake(0, 0, 100, 75);
    layer.position       = self.view.center;
    layer.fillColor      = [UIColor clearColor].CGColor;
    layer.strokeColor    = [UIColor colorWithRed:33 / 255.0 green:192 / 255.0 blue:250 / 255.0 alpha:1].CGColor;
    layer.lineCap        = @"round";
    layer.lineWidth      = 10;
    
    return layer;
}

//依照给定的颜色数组创建并返回一个CAGradientLayer
-(CAGradientLayer *)createGradientLayerWithColors:(NSArray *)colors {
    
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors            = colors;
    gradientLayer.locations         = @[@0,@0.8];
    gradientLayer.startPoint        = CGPointMake(0, 1);
    gradientLayer.endPoint          = CGPointMake(0, 0);
    gradientLayer.bounds            = CGRectMake(0, 0, 50, 80);
    
    return gradientLayer;
}

@end
