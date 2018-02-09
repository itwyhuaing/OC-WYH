//
//  FourthVC.m
//  CALayerDemo
//
//  Created by hnbwyh on 2018/2/8.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "FourthVC.h"

@interface FourthVC ()
{
    CGPoint arcCenter;
}
@end

@implementation FourthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self makeUpCoordinate];
    [self arcPath];
    
    
}

- (void)makeUpCoordinate{
    arcCenter = self.view.center;
    CGRect rect = CGRectMake(0, 0, 3, 3);
    UILabel *l = [[UILabel alloc] initWithFrame:rect];
    l.backgroundColor = [UIColor blackColor];
    [l setCenter:arcCenter];
    
    rect.size.width = self.view.bounds.size.width;
    rect.size.height = 1.0;
    UILabel *xl = [[UILabel alloc] initWithFrame:rect];
    xl.backgroundColor = [UIColor redColor];
    [xl setCenter:arcCenter];
    
    rect.size.height = self.view.bounds.size.height;
    rect.size.width = 1.0;
    UILabel *yl = [[UILabel alloc] initWithFrame:rect];
    yl.backgroundColor = [UIColor redColor];
    [yl setCenter:arcCenter];
    
    [self.view addSubview:l];
    [self.view addSubview:xl];
    [self.view addSubview:yl];
    
}

// - (void)moveToPoint:(CGPoint)point;
// - (void)addArcWithCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise;
// - (void)closePath;
- (void)arcPath{
    //
    
    CGFloat r = 100.0;
    CGFloat sPI = 1.2 * M_PI;
    CGFloat ePI = 1.8 * M_PI;
    
    // path
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:arcCenter
                    radius:r
                startAngle:sPI
                  endAngle:ePI
                 clockwise:YES];
    //[path closePath];
    
    // layer
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.strokeColor = UIColor.blueColor.CGColor;
    layer.fillColor = UIColor.clearColor.CGColor;
    [self.view.layer addSublayer:layer];
}

@end
