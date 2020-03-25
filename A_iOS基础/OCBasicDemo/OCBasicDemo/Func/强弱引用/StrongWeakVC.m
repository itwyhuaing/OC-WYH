//
//  StrongWeakVC.m
//  OCBasicDemo
//
//  Created by hnbwyh on 2020/3/16.
//  Copyright © 2020 JiXia. All rights reserved.
//

#import "StrongWeakVC.h"
#import "SWObj.h"

@interface StrongWeakVC ()

@property (nonatomic,weak)      SWObj *weakObj;

@property (nonatomic,strong)    SWObj *strongObj;

@end

@implementation StrongWeakVC

- (void)viewDidLoad {
    [super viewDidLoad];
    SWObj *tmp      = [[SWObj alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.weakObj    = tmp;
    self.weakObj.name = @"weakObj";
    [self.view addSubview:self.weakObj];
    _strongObj = [[SWObj alloc] initWithFrame:CGRectMake(100, 300, 100, 100)];
    _strongObj.name = @"strongObj";
    [self.view addSubview:_strongObj];
    
    self.weakObj.backgroundColor = [UIColor redColor];
    
    _strongObj.backgroundColor = [UIColor orangeColor];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    /** （文字比较晦涩，运行代码观察结果简单直接）
     对于被弱引用的 weakObj ，weakObj 的内存计数器数值并没有 +1 操作，当被从父视图移除之后便会被销毁
     对于被强应用的 strongObj , strongObj 的内存计数器数值 +1，当被从父视图移除之后仍旧被 StrongWeakVC 实例所拥有，直至 StrongWeakVC 实例被销毁时才一同销毁。
     */
    [_weakObj removeFromSuperview];
    [_strongObj removeFromSuperview];
}

-(void)dealloc {
    NSLog(@" \n \n  %s 已销毁,此时weakObj:%@ \n strongObj:%@ \n \n",__FUNCTION__,_weakObj,_strongObj);
}

@end
