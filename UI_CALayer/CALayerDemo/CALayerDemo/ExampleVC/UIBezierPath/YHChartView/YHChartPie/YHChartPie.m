//
//  YHChartPie.m
//  YHFunctionsTest
//
//  Created by wyh on 15/12/24.
//  Copyright © 2015年 lachesismh. All rights reserved.
//

#import "YHChartPie.h"

@implementation YHChartPie

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
    }
    return self;
}




-(void)strokeChartPie0{

    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGFloat radius = CGRectGetWidth(self.bounds)/4.0;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                        radius:radius
                                                    startAngle:-M_PI_2
                                                      endAngle:M_PI_2 * 3
                                                     clockwise:YES];
    circleLayer.path        = path.CGPath;
    circleLayer.fillColor   = [UIColor clearColor].CGColor;
    circleLayer.strokeColor = [UIColor redColor].CGColor;
    circleLayer.strokeStart = 0;
    circleLayer.strokeEnd   = 0.5;
    circleLayer.lineWidth   = CGRectGetWidth(self.bounds)/2.0;
    [self.layer addSublayer:circleLayer];
    
    
    CGFloat R = CGRectGetWidth(self.bounds) / 2.0;
    CGFloat r = R / 2.0;
    CGFloat QPre = circleLayer.strokeStart * M_PI * 2;
    CGFloat QEnd = circleLayer.strokeEnd * M_PI * 2;
    CGFloat Q = QEnd - QPre;
    CGFloat QD = QPre + Q / 2.0;
    CGFloat Qx = 0;
    CGFloat Qy = 0;
    if (QD > 0 && QD <= M_PI_2) { // x+ y-
        
        Qx = center.x + r * sin(Q/2.0);
        Qy = center.y - r * cos(Q/2.0);
        
    }else if (QD > M_PI_2 && QD <= M_PI){
        
        Qx = center.x + r * sin(Q/2.0);
        Qy = center.y + r * cos(Q/2.0);
        
    }else if (QD > M_PI && QD < M_PI_2 * 3){
        
        Qx = center.x - r * sin(Q/2.0);
        Qy = center.y + r * cos(Q/2.0);
        
    }else{
        
        Qx = center.x - r * sin(Q/2.0);
        Qy = center.y - r * cos(Q/2.0);
        
    }

    
    CGPoint lablePoint = CGPointMake(Qx, Qy);
    
    UILabel *lable = [self createLableWithFrame:lablePoint];
    lable.text = @"50%";
}

-(void)strokeChartPie1{
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGFloat radius = CGRectGetWidth(self.bounds)/4.0;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                        radius:radius
                                                    startAngle:-M_PI_2
                                                      endAngle:M_PI_2 * 3
                                                     clockwise:YES];
    circleLayer.path        = path.CGPath;
    circleLayer.fillColor   = [UIColor clearColor].CGColor;
    circleLayer.strokeColor = [UIColor greenColor].CGColor;
    circleLayer.strokeStart = 0.5;
    circleLayer.strokeEnd   = 0.8;
    circleLayer.lineWidth   = CGRectGetWidth(self.bounds)/2.0;
    [self.layer addSublayer:circleLayer];
 
    
    CGFloat R = CGRectGetWidth(self.bounds) / 2.0;
    CGFloat r = R / 2.0;
    CGFloat QPre = circleLayer.strokeStart * M_PI * 2;
    CGFloat QEnd = circleLayer.strokeEnd * M_PI * 2;
    CGFloat Q = QEnd - QPre;
    CGFloat QD = QPre + Q / 2.0;
    CGFloat Qx = 0;
    CGFloat Qy = 0;
    if (QD > 0 && QD <= M_PI_2) { // x+ y-
        
        Qx = center.x + r * sin(Q/2.0);
        Qy = center.y - r * cos(Q/2.0);
        
    }else if (QD > M_PI_2 && QD <= M_PI){
        
        Qx = center.x + r * sin(Q/2.0);
        Qy = center.y + r * cos(Q/2.0);
        
    }else if (QD > M_PI && QD < M_PI_2 * 3){
        
        Qx = center.x - r * sin(Q/2.0);
        Qy = center.y + r * cos(Q/2.0);
        
    }else{
        
        Qx = center.x - r * sin(Q/2.0);
        Qy = center.y - r * cos(Q/2.0);
        
    }
    
    CGPoint lablePoint = CGPointMake(Qx, Qy);
    
    UILabel *lable = [self createLableWithFrame:lablePoint];
    lable.text = @"30%";
    
    
}


-(void)strokeChartPie2{
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGFloat radius = CGRectGetWidth(self.bounds)/4.0;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                        radius:radius
                                                    startAngle:-M_PI_2
                                                      endAngle:M_PI_2 * 3
                                                     clockwise:YES];
    circleLayer.path        = path.CGPath;
    circleLayer.fillColor   = [UIColor clearColor].CGColor;
    circleLayer.strokeColor = [UIColor blueColor].CGColor;
    circleLayer.strokeStart = 0.8;
    circleLayer.strokeEnd   = 1.0;
    circleLayer.lineWidth   = CGRectGetWidth(self.bounds)/2.0;
    [self.layer addSublayer:circleLayer];
    
    
    CGFloat R = CGRectGetWidth(self.bounds) / 2.0;
    CGFloat r = R / 2.0;
    CGFloat QPre = circleLayer.strokeStart * M_PI * 2;
    CGFloat QEnd = circleLayer.strokeEnd * M_PI * 2;
    CGFloat Q = QEnd - QPre;
    CGFloat QD = QPre + Q / 2.0;
    CGFloat Qx = 0;
    CGFloat Qy = 0;
    if (QD > 0 && QD <= M_PI_2) { // x+ y-
        
        Qx = center.x + r * sin(Q/2.0);
        Qy = center.y - r * cos(Q/2.0);
        
    }else if (QD > M_PI_2 && QD <= M_PI){
        
        Qx = center.x + r * sin(Q/2.0);
        Qy = center.y + r * cos(Q/2.0);
        
    }else if (QD > M_PI && QD < M_PI_2 * 3){
        
        Qx = center.x - r * sin(Q/2.0);
        Qy = center.y + r * cos(Q/2.0);
        
    }else{
        
        Qx = center.x - r * sin(Q/2.0);
        Qy = center.y - r * cos(Q/2.0);
        
    }
    
    CGPoint lablePoint = CGPointMake(Qx, Qy);
    
    UILabel *lable = [self createLableWithFrame:lablePoint];
    lable.text = @"20%";
    
}

-(void)strokeChartPieWithStart:(CGFloat)start end:(CGFloat)end{
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGFloat radius = CGRectGetWidth(self.bounds)/4.0;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                        radius:radius
                                                    startAngle:-M_PI_2
                                                      endAngle:M_PI_2 * 3
                                                     clockwise:YES];
    circleLayer.path        = path.CGPath;
    circleLayer.fillColor   = [UIColor clearColor].CGColor;
    circleLayer.strokeColor = [UIColor blueColor].CGColor;
    circleLayer.strokeStart = start;
    circleLayer.strokeEnd   = end;
    circleLayer.lineWidth   = CGRectGetWidth(self.bounds)/2.0;
    [self.layer addSublayer:circleLayer];
    
    
    CGFloat R = CGRectGetWidth(self.bounds) / 2.0;
    CGFloat r = R / 5.0 * 4;
    CGFloat QPre = circleLayer.strokeStart * M_PI * 2;
    CGFloat QEnd = circleLayer.strokeEnd * M_PI * 2;
    CGFloat Q = QEnd - QPre;
    CGFloat QD = QPre + Q / 2.0;
    CGFloat Qx = 0;
    CGFloat Qy = 0;
    if (QD > 0 && QD <= M_PI_2) { // x+ y-
        
        Qx = center.x + r * sin(Q/2.0);
        Qy = center.y - r * cos(Q/2.0);
        
    }else if (QD > M_PI_2 && QD <= M_PI){
        
        Qx = center.x + r * sin(Q/2.0);
        Qy = center.y + r * cos(Q/2.0);
        
    }else if (QD > M_PI && QD < M_PI_2 * 3){
        
        Qx = center.x - r * sin(Q/2.0);
        Qy = center.y + r * cos(Q/2.0);
        
    }else{
        
        Qx = center.x - r * sin(Q/2.0);
        Qy = center.y - r * cos(Q/2.0);
        
    }
    
    CGPoint lablePoint = CGPointMake(Qx, Qy);
    
    UILabel *lable = [self createLableWithFrame:lablePoint];
    lable.text = [NSString stringWithFormat:@"%f0%%",(end - start) * 10];
    
}


#pragma mark - createLableWithFrame

- (UILabel *)createLableWithFrame:(CGPoint)center{

    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    lable.backgroundColor = [UIColor purpleColor];
    lable.textColor = [UIColor blackColor];
    lable.center = center;
    lable.textAlignment = NSTextAlignmentRight;
    lable.numberOfLines = 0;
    [self addSubview:lable];
    return lable;
}

@end
