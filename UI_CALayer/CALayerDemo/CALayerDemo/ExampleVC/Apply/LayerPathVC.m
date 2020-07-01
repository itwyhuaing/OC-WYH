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
     rect.origin.y = 100;
     rect.size.height -= 100.0;
     UIView *tv = [[UIView alloc] initWithFrame:rect];
     tv.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
     [self.view addSubview:tv];
     
     // 修改最上层所显示出来的 UIView 的形态 （UIView 之所以可以显示依赖于 .layer 即 root layer ，详见文档部分说明）
     UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, rect.size.width, rect.size.height)];
     //贝塞尔曲线 画一个圆形
     [path appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(200, 100) radius:60.0 startAngle:0 endAngle:2*M_PI clockwise:NO]];
     //贝塞尔曲线 画一个方形
     [path appendPath:[[UIBezierPath bezierPathWithRect:CGRectMake(100, 300, 120, 120)] bezierPathByReversingPath]];
     CAShapeLayer *shapeLayer = [CAShapeLayer layer];
     shapeLayer.path = path.CGPath;
     
    tv.layer.mask = shapeLayer;
}

@end
