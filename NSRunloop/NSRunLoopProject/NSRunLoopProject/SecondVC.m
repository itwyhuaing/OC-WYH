//
//  SecondVC.m
//  NSRunLoopProject
//
//  Created by hnbwyh on 2018/1/24.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

/** 常见应用场景之一
 iOS / OS 系统为了提供系统性能，子线程会在任务执行结束之后，自动销毁。但偶尔也会遇到保证一个线程不被销毁的场景，解决方案如下。
 
 1. 子线程创建之后，与之一起被创建的还有一个相应的 NSRunLoop ， 该NSRunLoop在没有源的情况下就会自动退出 NSRunLoop ，当然线程也会销毁。
 2. 所以可以给 NSRunLoop 添加一个输入源，防止 NSRunLoop 退出。
 */

#import "SecondVC.h"

@interface SecondVC ()

@property (nonatomic,strong) NSThread *cusThread;

@end

@implementation SecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _cusThread = [[NSThread alloc] initWithTarget:self selector:@selector(entrySubThread:) object:nil];
    [_cusThread start];
    
}

#pragma mark --- 保证线程不销毁
- (void)entrySubThread:(NSThread *)thread{
    NSLog(@"%s - %@",__FUNCTION__,[NSThread currentThread]);
    [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run];
}


#pragma mark --- 测试线程依旧存活

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self performSelector:@selector(excudeInSubThread) onThread:_cusThread withObject:nil waitUntilDone:TRUE modes:@[NSDefaultRunLoopMode]];
}

- (void)excudeInSubThread{
    NSLog(@"%s - %@",__FUNCTION__,[NSThread currentThread]);
}

@end
