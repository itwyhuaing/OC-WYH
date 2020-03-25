//
//  TestVC.m
//  HotFixDemo
//
//  Created by hnbwyh on 2018/3/12.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "TestVC.h"
#import "Aspects.h"
#import <objc/runtime.h>
#import "SecondVC.h"
#import "ThirdVC.h"

@interface TestVC ()

@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //UIViewController *vc = [[UIViewController alloc] init];
    SecondVC *vc1 = [[SecondVC alloc] init];
    ThirdVC *vc2 = [[ThirdVC alloc] init];
//    [vc1 aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id aspcInfo){
//        
//        NSLog(@" aspcInfo : %@",aspcInfo);
//        
//    } error:NULL];
//    
//    [vc2 aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id aspcInfo){
//        
//        NSLog(@" aspcInfo : %@",aspcInfo);
//        
//    } error:NULL];
//    
    
}

@end
