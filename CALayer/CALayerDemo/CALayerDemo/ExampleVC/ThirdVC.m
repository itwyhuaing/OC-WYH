//
//  ThirdVC.m
//  CALayerDemo
//
//  Created by hnbwyh on 2018/2/8.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "ThirdVC.h"

@interface ThirdVC ()
{
    CAShapeLayer *globalLayer;
    CGPoint startPoint;
    CGPoint controlPoint;
    CGPoint controlPoint2;
    CGPoint endPoint;
}
@end

@implementation ThirdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addLayer];     // CAShapeLayer
    [self makeUpPoint];  // CGPoint
    [self path3];        // UIBezierPath
}

- (void)addLayer{
    globalLayer = [CAShapeLayer layer];
    globalLayer.strokeColor = UIColor.blueColor.CGColor;
    globalLayer.fillColor = UIColor.clearColor.CGColor;
    [self.view.layer addSublayer:globalLayer];
}

- (void)makeUpPoint{
    startPoint = CGPointZero;
    controlPoint = CGPointZero;
    controlPoint2 = CGPointZero;
    endPoint = CGPointZero;
    startPoint.x = 30.0;
    startPoint.y = self.view.center.y;
    endPoint.x = [UIScreen mainScreen].bounds.size.width - startPoint.x;
    endPoint.y = startPoint.y;
    controlPoint.x = (endPoint.x - startPoint.x) / 2.0 + startPoint.x;
    controlPoint.y = startPoint.y - 120.0;
    controlPoint2.x = controlPoint.x;
    controlPoint2.y = startPoint.y + 120.0;
    [self addLabelWithCenterPoint:startPoint btnMark:EventSourceButtonOneTag];
    [self addLabelWithCenterPoint:controlPoint btnMark:EventSourceButtonTwoTag];
    [self addLabelWithCenterPoint:controlPoint2 btnMark:EventSourceButtonThreeTag];
    [self addLabelWithCenterPoint:endPoint btnMark:EventSourceButtonFourTag];
    
}

- (void)addLabelWithCenterPoint:(CGPoint)p btnMark:(EventSourceButtonTag)tag{
    CGRect rect = CGRectMake(0, 0, 30.0, 30.0);
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor cyanColor];
    [btn setFrame:rect];
    [btn setCenter:p];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(dragBtn:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    btn.tag = tag;
    NSString *btnTitle = @"";
    switch (tag) {
        case EventSourceButtonOneTag:
        {
            btnTitle = @"S";
        }
            break;
        case EventSourceButtonTwoTag:
        {
            btnTitle = @"C1";
        }
            break;
        case EventSourceButtonThreeTag:
        {
            btnTitle = @"C2";
        }
            break;
        case EventSourceButtonFourTag:
        {
            btnTitle = @"E";
        }
            break;
            
        default:
            break;
    }
    [btn setTitle:btnTitle forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
}


// - (void)moveToPoint:(CGPoint)point;
// - (void)addCurveToPoint:(CGPoint)endPoint controlPoint1:(CGPoint)controlPoint1 controlPoint2:(CGPoint)controlPoint2;
// - (void)closePath;
- (void)path3{
    
    // path
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    [path addCurveToPoint:endPoint controlPoint1:controlPoint controlPoint2:controlPoint2];
    
    // layer
    globalLayer.path = path.CGPath;
}

- (void)dragBtn:(UIButton *)btn withEvent:(UIEvent *)ev{
    //NSLog(@" \n \n %s \n \n %ld \n \n %@ \n \n \n",__FUNCTION__,btn.tag,ev);
    btn.center = [[[ev allTouches] anyObject] locationInView:self.view];
    switch (btn.tag) {
        case EventSourceButtonOneTag:
        {
            startPoint = btn.center;
        }
            break;
        case EventSourceButtonTwoTag:
        {
            controlPoint = btn.center;
        }
            break;
        case EventSourceButtonThreeTag:
        {
            controlPoint2 = btn.center;
        }
            break;
        case EventSourceButtonFourTag:
        {
            endPoint = btn.center;
        }
            break;
            
        default:
            break;
    }
    [self path3];
}

- (void)dynamicUpdateCenter{
    
}

@end
