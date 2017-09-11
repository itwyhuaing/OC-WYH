//
//  ViewController.m
//  YHCALayerProject
//
//  Created by hnbwyh on 17/1/12.
//  Copyright © 2017年 hnbwyh. All rights reserved.
//

#import "ViewController.h"
#import "NewFunctionVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.navigationController pushViewController:[[NewFunctionVC alloc] init] animated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    CABasicAnimation *startAni = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    startAni.fromValue = @0.5f;
    startAni.toValue = @0.f;
    startAni.duration = 3.f;
    startAni.removedOnCompletion = NO;
    startAni.repeatCount = FLT_MAX;
    startAni.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *endAni =[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    endAni.fromValue = @0.5f;
    endAni.toValue = @1.f;
    endAni.duration = 3.f;
    endAni.removedOnCompletion = NO;
    endAni.repeatCount = FLT_MAX;
    startAni.fillMode = kCAFillModeForwards;
    
    CAShapeLayer *slayer = [CAShapeLayer layer];
    slayer.bounds = CGRectMake(0, 0, 50, 50);
    slayer.backgroundColor = [UIColor greenColor].CGColor;
    slayer.position = CGPointMake(50, 50);
    slayer.anchorPoint = CGPointMake(0, 0);
    [slayer addAnimation:startAni forKey:nil];
    [slayer addAnimation:endAni forKey:nil];
    slayer.strokeColor = [UIColor redColor].CGColor;
    slayer.fillColor = [UIColor yellowColor].CGColor;
    
//    [self.view.layer addSublayer:slayer];
    
    
    
//    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"position"];
//    ani.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
//    ani.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 300)];
//    ani.fillMode = kCAFillModeForwards;
//    ani.removedOnCompletion = NO;
//    ani.duration = 8.f;
//    
//    CAShapeLayer *slayer = [CAShapeLayer layer];
//    slayer.bounds = CGRectMake(0, 0, 50, 50);
//    slayer.backgroundColor = [UIColor greenColor].CGColor;
//    slayer.position = CGPointMake(50, 50);
//    slayer.anchorPoint = CGPointMake(0, 0);
////    [slayer addAnimation:ani forKey:@"position"];
//    [self.view.layer addSublayer:slayer];
    
}

#pragma mark ------  镂空效果

- (void)drawNewFunctions{

    self.view.backgroundColor = [UIColor greenColor];
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(20, 20, [UIScreen mainScreen].bounds.size.width-40, [UIScreen mainScreen].bounds.size.height - 40)];
    v.backgroundColor = [UIColor grayColor];
    v.alpha = 0.6;
    [self.view addSubview:v];
    
    UIBezierPath *p = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-40, [UIScreen mainScreen].bounds.size.height - 40) cornerRadius:15];
    
    [p appendPath:[UIBezierPath bezierPathWithArcCenter:v.center
                                                 radius:30
                                             startAngle:0
                                               endAngle:M_PI / 2
                                              clockwise:NO]];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [UIColor blueColor].CGColor;
    shapeLayer.path = p.CGPath;
    shapeLayer.backgroundColor = [UIColor redColor].CGColor;
    
    v.layer.mask = shapeLayer;
    
}


@end
