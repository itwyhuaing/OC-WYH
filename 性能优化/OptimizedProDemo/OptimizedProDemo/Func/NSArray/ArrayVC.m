//
//  ArrayVC.m
//  OptimizedProDemo
//
//  Created by hnbwyh on 2019/3/25.
//  Copyright © 2019 ZhiXingJY. All rights reserved.
//

#import "ArrayVC.h"
#import "NSArray+Crash.h"

@interface ArrayVC ()

@end

@implementation ArrayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor   = [UIColor whiteColor];
    self.title                  = NSStringFromClass(self.class);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSArray *arr = @[@"A1",@"A2",@"A3",
                     @"A4",@"A5",@"A6"];
    
    NSString *A = [arr objectAtIndex:9];
    
    
    
    NSString *B = arr[0];
    
    NSString *AX = [arr jx_objectAtIndex:0];
    
    NSLog(@"");
    
}

@end
