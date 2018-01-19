//
//  FirstVC.m
//  NSRunLoopProject
//
//  Created by hnbwyh on 2018/1/18.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "FirstVC.h"
#import "YHThread.h"

@interface FirstVC ()

@property (nonatomic,strong) YHThread *subThread;

@property (nonatomic,strong) NSTimer *subTimer;

@end

@implementation FirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSDictionary *info = @{
                           @"k1":@"v1",
                           @"k2":@"v2"
                           };
    
     self.subThread = [[YHThread alloc] initWithTarget:self selector:@selector(subThreadFun:) object:info];
     [self.subThread start];
    
    /*
    YHThread *t = [[YHThread alloc] initWithTarget:self selector:@selector(subThreadFun:) object:info];
    [t start];
    */
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self performSelector:@selector(func:) onThread:self.subThread withObject:@"数据测试" waitUntilDone:TRUE];
}

- (void)subThreadFun:(NSDictionary *)dict{
    
        NSLog(@" 11 %@ - %@ ",[NSThread currentThread],dict);
        //两种方式保活线程
        //[NSTimer scheduledTimerWithTimeInterval:6.0 target:self selector:@selector(test:) userInfo:dict repeats:TRUE];
        [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
        NSLog(@" 22 %@ - %@ ",[NSThread currentThread],dict);
    
}

- (void)test:(NSDictionary *)info{
    NSLog(@" %@ - %@ ",[NSThread currentThread],info);
}

- (void)func:(NSString *)str{
    NSLog(@" %@ - %@ ",[NSThread currentThread],str);
}

@end
