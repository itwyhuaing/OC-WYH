//
//  FirstVC.m
//  NSRunLoopProject
//
//  Created by hnbwyh on 2018/1/18.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//
/** 常见应用场景之一
 UI 操作过程中定时器停止，最常见于 UIScrollView 滚动过程中
 
 解决方案：将定时器所在的 NSRunLoop 模式，新增 UITrackingRunLoopMode 。

 [[NSRunLoop currentRunLoop] addTimer:globalTimer forMode:NSRunLoopCommonModes];
 或
 [[NSRunLoop currentRunLoop] addTimer:globalTimer forMode:UITrackingRunLoopMode];
 
 */
#import "FirstVC.h"
#import "YHThread.h"

@interface FirstVC () <UIScrollViewDelegate>
{
    UILabel *displayLabel;
    NSTimer *globalTimer;
    NSInteger totalTime;
}
@end

@implementation FirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"\n 测试当前RunLoopMode 1: %@ \n",[NSRunLoop currentRunLoop]);
    
    self.view.backgroundColor = [UIColor whiteColor];
    CGRect rect = CGRectZero;
    rect.size.width = kSCREEN_W;
    rect.size.height = kSCREEN_H;
    UIScrollView *sv = [[UIScrollView alloc] initWithFrame:rect];
    sv.delegate = self;
    sv.contentSize = CGSizeMake(kSCREEN_W, kSCREEN_H * 300.0);
    
    
    rect.size.height = 20.0;
    rect.origin.y = 0.0;        //  kSCREEN_H / 2.0 - rect.size.height;
    UILabel *l = [[UILabel alloc] initWithFrame:rect];
    l.textColor = [UIColor redColor];
    l.textAlignment = NSTextAlignmentCenter;
    l.font = [UIFont systemFontOfSize:13.0];
    l.backgroundColor = [UIColor grayColor];
    l.text = @"等待启动定时器";
    displayLabel = l;
    [self.view addSubview:sv];
    [self.view addSubview:l];
    
    totalTime = 90;
    globalTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateDisplay:) userInfo:nil repeats:TRUE];
//    [[NSRunLoop currentRunLoop] addTimer:globalTimer forMode:NSRunLoopCommonModes];
    [[NSRunLoop currentRunLoop] addTimer:globalTimer forMode:UITrackingRunLoopMode];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"\n 测试当前RunLoopMode 2: %@ \n",[NSRunLoop currentRunLoop]);
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"\n 测试当前RunLoopMode 3: %@ \n",[NSRunLoop currentRunLoop]);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"\n 测试当前RunLoopMode 4: %@ \n",[NSRunLoop currentRunLoop]);
    });
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = FALSE;
}


-(void)dealloc {
    NSLog(@"\n 销毁 \n");
    [self stopTimer];
}

- (void)updateDisplay:(NSTimer *)t{
    if (totalTime >= 0) {
        displayLabel.text = [NSString stringWithFormat:@"%ld",totalTime];
        totalTime --;
    }else{
        [self stopTimer];
    }
    
}

- (void)stopTimer {
    if (globalTimer) {
        [globalTimer invalidate];
        globalTimer = nil;
    }
}

@end
