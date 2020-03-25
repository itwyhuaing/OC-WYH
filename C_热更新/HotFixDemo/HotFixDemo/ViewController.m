//
//  ViewController.m
//  HotFixDemo
//
//  Created by hnbwyh on 2018/3/12.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "ViewController.h"
#import "MightyCrash.h"
#import <objc/runtime.h>
#import "Aspects.h"
#import "SecondVC.h"
#import "Felix.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionBefore usingBlock:^(id aspcInfo){
//        NSLog(@" viewDidLoad - aspcInfo : %@",aspcInfo);
//    } error:NULL];
    
    
    [Felix fixIt];
    NSString *fixScriptString = @" \
    fixInstanceMethodReplace('MightyCrash', 'divideUsingDenominator:', function(instance, originInvocation, originArguments){ \
    if (originArguments[0] == 0) { \
    console.log('zero goes here'); \
    } else { \
    runInvocation(originInvocation); \
    } \
    }); \
    \
    ";
    [Felix evalString:fixScriptString];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor greenColor];
    NSLog(@" %s ",__FUNCTION__);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    SecondVC *vc = [[SecondVC alloc] init];
    [self.navigationController pushViewController:vc animated:TRUE];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        MightyCrash *t = [[MightyCrash alloc] init];
        float r = [t divideUsingDenominator:0];
        NSLog(@" 数据测试: %f ",r);
        
    });
}

@end
