//
//  TestVC1.m
//  GCDProjectDemo
//
//  Created by wangyinghua on 2018/8/25.
//  Copyright © 2018年 ZhiXing. All rights reserved.
//

#import "TestVC1.h"

@interface TestVC1 ()

@end

@implementation TestVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self testNetReq];
}

// 针对同一个网络请求，不断请求直到其请求成功为止;请求失败，假设第 x 次才可以成功
- (void)testNetReq{
    __block BOOL isGoOn = TRUE;
    NSInteger cou = 6;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    NSInteger idx = 0;
    while (isGoOn) {
        idx ++;
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        // 对网络请求的模拟
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSLog(@"请求 - 执行次数:%ld",idx);
                if (idx >= cou) {
                    // 请求成功
                    isGoOn = FALSE;
                    //                dispatch_release(semaphore);
                }else{
                    isGoOn = TRUE;
                    dispatch_semaphore_signal(semaphore);
                }
            });
        }
        
        NSLog(@"测试");
        
    }

/**
 2018-10-22 23:24:19.102468+0800 GCDProjectDemo[2454:162260] libMobileGestalt MobileGestalt.c:890: MGIsDeviceOneOfType is not supported on this platform.
 2018-10-22 23:24:22.059858+0800 GCDProjectDemo[2454:162260] 测试
 2018-10-22 23:24:25.059971+0800 GCDProjectDemo[2454:162295] 请求 - 执行次数:1
 2018-10-22 23:24:25.060342+0800 GCDProjectDemo[2454:162260] 测试
 2018-10-22 23:24:27.554910+0800 GCDProjectDemo[2454:162295] XPC connection interrupted
 2018-10-22 23:24:28.239137+0800 GCDProjectDemo[2454:162295] 请求 - 执行次数:2
 2018-10-22 23:24:28.239481+0800 GCDProjectDemo[2454:162260] 测试
 2018-10-22 23:24:31.239786+0800 GCDProjectDemo[2454:162295] 请求 - 执行次数:3
 2018-10-22 23:24:31.240102+0800 GCDProjectDemo[2454:162260] 测试
 2018-10-22 23:24:34.240242+0800 GCDProjectDemo[2454:162295] 请求 - 执行次数:4
 2018-10-22 23:24:34.240445+0800 GCDProjectDemo[2454:162260] 测试
 2018-10-22 23:24:37.240750+0800 GCDProjectDemo[2454:162295] 请求 - 执行次数:5
 2018-10-22 23:24:37.240927+0800 GCDProjectDemo[2454:162260] 测试
 2018-10-22 23:24:40.457850+0800 GCDProjectDemo[2454:162295] 请求 - 执行次数:6
 */
    
}


// 异步高性能操作同一个数组
- (void)test1{
    dispatch_queue_t        queue       = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_semaphore_t    semaphore   = dispatch_semaphore_create(1);
    NSMutableArray *arr = [NSMutableArray new];
    NSLog(@"\n 测试-start \n");
    for (NSInteger cou = 0; cou < 9; cou ++) {
        dispatch_async(queue, ^{
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            [arr addObject:[NSNumber numberWithInteger:cou]];
            dispatch_semaphore_signal(semaphore);
            //            dispatch_release(semaphore);
            NSLog(@"\n 测试-ing:%@ \n",[NSThread currentThread]);
        });
    }
    NSLog(@"\n 测试-end \n");
    
/** 打印结果
 2018-10-22 23:00:04.646207+0800 GCDProjectDemo[2189:131598]
 测试-start
 
 2018-10-22 23:00:04.646463+0800 GCDProjectDemo[2189:131598]
 测试-end
 
 2018-10-22 23:00:04.646571+0800 GCDProjectDemo[2189:131885]
 测试-ing:<NSThread: 0x600000521c40>{number = 3, name = (null)}
 
 2018-10-22 23:00:04.646604+0800 GCDProjectDemo[2189:131642]
 测试-ing:<NSThread: 0x600000521940>{number = 4, name = (null)}
 
 2018-10-22 23:00:04.646622+0800 GCDProjectDemo[2189:131643]
 测试-ing:<NSThread: 0x600000522840>{number = 5, name = (null)}
 
 2018-10-22 23:00:04.646657+0800 GCDProjectDemo[2189:131889]
 测试-ing:<NSThread: 0x600000522880>{number = 6, name = (null)}
 
 2018-10-22 23:00:04.647005+0800 GCDProjectDemo[2189:131885]
 测试-ing:<NSThread: 0x600000521c40>{number = 3, name = (null)}
 
 2018-10-22 23:00:04.647083+0800 GCDProjectDemo[2189:131642]
 测试-ing:<NSThread: 0x600000521940>{number = 4, name = (null)}
 
 2018-10-22 23:00:04.647104+0800 GCDProjectDemo[2189:131890]
 测试-ing:<NSThread: 0x600000522a80>{number = 7, name = (null)}
 
 2018-10-22 23:00:04.647177+0800 GCDProjectDemo[2189:131643]
 测试-ing:<NSThread: 0x600000522840>{number = 5, name = (null)}
 
 2018-10-22 23:00:04.647203+0800 GCDProjectDemo[2189:131889]
 测试-ing:<NSThread: 0x600000522880>{number = 6, name = (null)}
 
 */
    
}


@end
