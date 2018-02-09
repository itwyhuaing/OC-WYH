//
//  YHChartViewController.m
//  YHFunctionsTest
//
//  Created by wyh on 15/12/22.
//  Copyright © 2015年 lachesismh. All rights reserved.
//

#import "YHChartViewController.h"
#import "YHChartLine.h"
#import "YHChartPie.h"

@interface YHChartViewController ()<YHChartLineDelegate>

@property (nonatomic,retain) YHChartLine *chartLineCurve;

@property (nonatomic,retain) YHChartPie *chartPie;

@end

@implementation YHChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"YHChartViewDemo";
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self setUpNav];
    
    //[self chartPieUI];
    
    
    [self chartLineUI];
    
}

#pragma mark - ================================ YHChartLine

- (void)setUpNav{

    CGRect rect = CGRectZero;
    rect.size = CGSizeMake(50, 30);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:rect];
    [btn setTitle:@"curve" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor orangeColor]];
    btn.tag = 10;
    [btn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setFrame:rect];
    [btn1 setTitle:@"set" forState:UIControlStateNormal];
    [btn1 setBackgroundColor:[UIColor orangeColor]];
    btn1.tag = 11;
    [btn1 addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:btn1];
    
    self.navigationItem.rightBarButtonItems = @[item,item1];
}

#pragma mark - ============================================= chartPie

#pragma mark - chartPieUI

- (void)chartPieUI{

    CGRect rect = self.view.bounds;
    rect.size.width = 100;
    rect.size.height = 100;
    rect.origin.x = CGRectGetMidX(self.view.bounds) - rect.size.width / 2.0;
    rect.origin.y = CGRectGetMidY(self.view.bounds);// - rect.size.height / 2.0;
    YHChartPie *chartPie = [[YHChartPie alloc] initWithFrame:rect];
    chartPie.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:chartPie];
    self.chartPie = chartPie;
//    [self.chartPie strokeChartPie0];
//    [self.chartPie strokeChartPie1];
//    [self.chartPie strokeChartPie2];
    
    
    [self.chartPie strokeChartPieWithStart:0 end:0.5];
    [self.chartPie strokeChartPieWithStart:0.5 end:0.6];
    [self.chartPie strokeChartPieWithStart:0.6 end:1];
//    [self.chartPie strokeChartPieWithStart:0.8 end:1];
//    [self.chartPie strokeChartPieWithStart:0 end:0.5];
//    [self.chartPie strokeChartPieWithStart:0 end:0.5];
    
}

#pragma mark - ============================================= chartLine

#pragma mark - chartLineUI

- (void)chartLineUI{
    
    // curve
   YHChartLine *chartLine = [[YHChartLine alloc] initWithFrame:CGRectMake(10, 30, [UIScreen mainScreen].bounds.size.width - 20, [UIScreen mainScreen].bounds.size.height > 280 ? 280 : [UIScreen mainScreen].bounds.size.height) pointsShowStyle:YHChartLinePointsShowCurve delegate:self];
    self.chartLineCurve = chartLine;
    [chartLine showInView:self.view];
    
}


#pragma mark - YHChartLineDelegate

-(NSArray *)chartLineXAxisMarks{
    
//    if (self.chartLineCurve.pointsShowStyle == YHChartLinePointsShowCurve) {
//        
//        return @[@"22/11",@"23/11",@"24/11",@"25/11",@"26/11",@"27/11",@"28/11",@"29/11"];
//        
//    } else {
//        
//        return nil;
//        
//    }

    return @[@"22/11",@"23/11",@"24/11",@"25/11",@"26/11",@"27/11",@"28/11",@"29/11"];
    
}

- (NSArray *)chartLineYAxisMarks{

//    if (self.chartLineCurve.pointsShowStyle == YHChartLinePointsShowCurve) {
//        
//        NSNumber *valueNum0 = [NSNumber numberWithInt:0];
//        NSNumber *valueNum1 = [NSNumber numberWithInt:10];
//        NSNumber *valueNum2 = [NSNumber numberWithInt:20];
//        NSNumber *valueNum3 = [NSNumber numberWithInt:30];
//        NSNumber *valueNum4 = [NSNumber numberWithInt:40];
//        return @[valueNum0,valueNum1,valueNum2,valueNum3,valueNum4];
//        
//    } else {
//        
//        return nil;
//        
//    }

    NSNumber *valueNum0 = [NSNumber numberWithInt:0];
    NSNumber *valueNum1 = [NSNumber numberWithInt:10];
    NSNumber *valueNum2 = [NSNumber numberWithInt:20];
    NSNumber *valueNum3 = [NSNumber numberWithInt:30];
    NSNumber *valueNum4 = [NSNumber numberWithInt:40];
    return @[valueNum0,valueNum1,valueNum2,valueNum3,valueNum4];
    
}

- (NSArray *)chartLineYValuesForPoints{
    
    
    
//    if (self.chartLineCurve.pointsShowStyle == YHChartLinePointsShowCurve) {
//        
//        NSNumber *yValueNum1 = [NSNumber numberWithFloat:3.8];
//        NSNumber *yValueNum2 = [NSNumber numberWithFloat:12.4];
//        NSNumber *yValueNum3 = [NSNumber numberWithFloat:12.6];
//        NSNumber *yValueNum4 = [NSNumber numberWithFloat:5.2];
//        NSNumber *yValueNum5 = [NSNumber numberWithFloat:9.4];
//        NSNumber *yValueNum6 = [NSNumber numberWithFloat:19.1];
//        NSNumber *yValueNum7 = [NSNumber numberWithFloat:21.2];
//        NSNumber *yValueNum8 = [NSNumber numberWithFloat:13.5];
//        
//        //    NSNumber *yValueNum1 = [NSNumber numberWithFloat:5];
//        //    NSNumber *yValueNum2 = [NSNumber numberWithFloat:15];
//        //    NSNumber *yValueNum3 = [NSNumber numberWithFloat:10];
//        //    NSNumber *yValueNum4 = [NSNumber numberWithFloat:15];
//        //    NSNumber *yValueNum5 = [NSNumber numberWithFloat:30];
//        //    NSNumber *yValueNum6 = [NSNumber numberWithFloat:20];
//        //    NSNumber *yValueNum7 = [NSNumber numberWithFloat:40];
//        //    NSNumber *yValueNum8 = [NSNumber numberWithFloat:25];
//        
//        return @[yValueNum1,yValueNum2,yValueNum3,yValueNum4,yValueNum5,yValueNum6,yValueNum7,yValueNum8];
//    } else {
//        
//        return nil;
//    }
    
    NSNumber *yValueNum1 = [NSNumber numberWithFloat:3.8];
    NSNumber *yValueNum2 = [NSNumber numberWithFloat:12.4];
    NSNumber *yValueNum3 = [NSNumber numberWithFloat:12.6];
    NSNumber *yValueNum4 = [NSNumber numberWithFloat:5.2];
    NSNumber *yValueNum5 = [NSNumber numberWithFloat:9.4];
    NSNumber *yValueNum6 = [NSNumber numberWithFloat:19.1];
    NSNumber *yValueNum7 = [NSNumber numberWithFloat:21.2];
    NSNumber *yValueNum8 = [NSNumber numberWithFloat:13.5];
    return @[yValueNum1,yValueNum2,yValueNum3,yValueNum4,yValueNum5,yValueNum6,yValueNum7,yValueNum8];
    
}

#pragma mark - ================================




#pragma mark - ================================

- (void)clickEvent:(UIButton *)sendBtn{

//    switch (sendBtn.tag) {
//        case 10:
//        {
//            self.chartLineSet.hidden = YES;
//        }
//            break;
//        case 11:
//        {
//            self.chartLineSet.hidden = NO;
//        }
//            break;
//        default:
//            break;
//    }

    
}

@end





