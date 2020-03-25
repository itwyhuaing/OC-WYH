//
//  LayerPathVC.m
//  CALayerDemo
//
//  Created by hnbwyh on 2018/3/16.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "LayerPathVC.h"

@interface LayerPathVC ()

@end

@implementation LayerPathVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"LayerPathVC";
    [self example];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor greenColor];
    self.navigationController.navigationBar.translucent = FALSE;
    
}

- (void)example{
    
     CGRect rect = self.view.bounds;
     UIView *tv = [[UIView alloc] initWithFrame:rect];
     tv.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
     [self.view addSubview:tv];
     
     UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    
    //贝塞尔曲线 画一个圆形
    [path appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 68) radius:60.0 startAngle:0 endAngle:2*M_PI clockwise:NO]];
    
    //贝塞尔曲线 画一个方形
    [path appendPath:[[UIBezierPath bezierPathWithRect:CGRectMake(100, 200, 50, 50)] bezierPathByReversingPath]];
    
     CAShapeLayer *shapeLayer = [CAShapeLayer layer];
     shapeLayer.path = path.CGPath;
     
     tv.layer.mask = shapeLayer;
    
    
}

@end
