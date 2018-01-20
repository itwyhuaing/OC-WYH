//
//  ViewController.m
//  NSRunLoopProject
//
//  Created by hnbwyh on 2018/1/16.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSRunLoop *curRunLoop = [NSRunLoop currentRunLoop];
    NSRunLoop *mainRunLoop = [NSRunLoop mainRunLoop];
    
    CFRunLoopRef curR = CFRunLoopGetCurrent();
    CFRunLoopRef mainR = CFRunLoopGetMain();
    
    
    /**<5 个类>*/
    //CFRunLoopRef
    //CFRunLoopMode
    //CFRunLoopObserverRef
    //CFRunLoopSourceRef
    //CFRunLoopTimerRef
    
    /**<5 种模式>*/
    //NSDefaultRunLoopMode
    //UITrackingRunLoopMode
    
    NSLog(@"");
    
}

@end
