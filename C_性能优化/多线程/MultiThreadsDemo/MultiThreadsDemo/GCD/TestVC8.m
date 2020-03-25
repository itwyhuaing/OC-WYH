//
//  TestVC8.m
//  GCDDemo
//
//  Created by wangyinghua on 2018/12/8.
//  Copyright © 2018年 JiXia. All rights reserved.
//

#import "TestVC8.h"

@interface TestVC8 ()

@end

@implementation TestVC8

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     当追加大量处理到 Dispatch Queue 时，再追加的过程中，有时希望不执行已追加的处理，在这种情况下只要挂起 Queue 即可，挂起之后的任务不会再执行；需要执行时再恢复，便可接着执行未执行的任务。
     
     dispatch_suspend(<#dispatch_object_t  _Nonnull object#>)
    
     dispatch_resume(<#dispatch_object_t  _Nonnull object#>)
     
     */
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

@end
