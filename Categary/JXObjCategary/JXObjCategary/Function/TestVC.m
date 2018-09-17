//
//  TestVC.m
//  JXObjCategary
//
//  Created by hnbwyh on 2018/8/9.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "TestVC.h"
#import "Data1Model.h"

@interface TestVC ()

@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self testCommonObj];
    
    //[self textCustomObj];
    
   
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [self testJXView];
}


#pragma mark ------ testCommonObj

- (void)testJXView{
    UIView *v = [UIView cardStyleView];
    [v setFrame:CGRectMake(30, 100, 100, 100)];
    [self.view addSubview:v];
    
    self.view.backgroundColor = [UIColor grayColor];
}


- (void)testCommonObj{
    NSMutableArray *arr1 = [NSMutableArray new];
    [arr1 addObject:@[[NSNumber numberWithInteger:299]]];
    for (NSInteger cou = 0; cou < 300; cou ++) {
        if (cou % 2 == 0) {
            NSDictionary *dic = @{
                                  @"k1":[NSNumber numberWithInteger:cou],
                                  @"k2":@"字典"
                                  };
            [arr1 addObject:dic];
        }else{
            [arr1 addObject:@[[NSNumber numberWithInteger:cou]]];
        }
    }
    [arr1 addObject:@{
                      @"k1":[NSNumber numberWithInteger:2],
                      @"k2":@"字典"
                      }];
    
    
    NSArray *rlt = [NSArray checkRepetitionWithOriginArray:arr1];
    
    NSLog(@" %ld - %ld ",arr1.count,rlt.count);
}

#pragma mark ------ textCustomObj

- (void)textCustomObj{
    NSMutableArray *arr1 = [NSMutableArray new];
    for (NSInteger cou = 0; cou < 300; cou ++) {
        Data1Model *f = [Data1Model new];
        f.cntDetail = [NSString stringWithFormat:@"%ld测试",cou];
        [arr1 addObject:f];
    }
    
    Data1Model *ft = [Data1Model new];
    ft.cntDetail = [NSString stringWithFormat:@"%d测试",2];
    [arr1 addObject:ft];
    
    
    NSArray *rlt = [NSArray checkRepetitionWithOriginArray:arr1];
    
    NSLog(@" %ld - %ld ",arr1.count,rlt.count);
}

@end
