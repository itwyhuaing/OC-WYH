//
//  FirstVC.m
//  CALayerDemo
//
//  Created by hnbwyh on 2018/2/8.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "FirstVC.h"

@interface FirstVC ()

@end

@implementation FirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = FALSE;
    
    [self test00];
    [self test01];
//    [self test10];
//    [self test11];
//    [self test12];
//    [self test13];
//    [self test15];
    
}

- (void)test00{
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = CGRectMake(10, 10, 80, 30);
    layer.backgroundColor = [UIColor cyanColor].CGColor;
    [self.view.layer addSublayer:layer];
    
}

- (void)test01{
    CGFloat sw = [UIScreen mainScreen].bounds.size.width;
    CGRect rect = CGRectMake(sw - 10 - 80, 10, 80, 30);
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.fillColor = UIColor.cyanColor.CGColor;
    [self.view.layer addSublayer:layer];
}

// + (instancetype)bezierPathWithRect:(CGRect)rect;
- (void)test10{
    
    CGRect rect = CGRectMake(110, 110, 150, 100);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:50.0];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.fillColor = UIColor.clearColor.CGColor;
    layer.strokeColor = UIColor.redColor.CGColor;
    [self.view.layer addSublayer:layer];
    
}

// + (instancetype)bezierPathWithOvalInRect:(CGRect)rect;
- (void)test11{
    
}

// + (instancetype)bezierPathWithRoundedRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius;
- (void)test12{
    
    CGRect rect = CGRectMake(110, 110, 150, 100);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:50.0];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.fillColor = UIColor.clearColor.CGColor;
    layer.strokeColor = UIColor.redColor.CGColor;
    [self.view.layer addSublayer:layer];
    
}

//  + (instancetype)bezierPathWithRoundedRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;
- (void)test13{
    
}

//  + (instancetype)bezierPathWithArcCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise;
- (void)test15{

}

/*
 + (instancetype)bezierPath;
 */
@end
