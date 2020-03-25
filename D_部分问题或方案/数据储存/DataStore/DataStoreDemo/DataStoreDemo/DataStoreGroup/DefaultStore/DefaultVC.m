
//
//  DefaultVC.m
//  LXYHOCFunctionsDemo
//
//  Created by hnbwyh on 17/6/8.
//  Copyright © 2017年 lachesismh. All rights reserved.
//

#define DEFAULT_KEY_STRING @"DEFAULT_KEY_STRING"
#define DEFAULT_KEY_ARR @"DEFAULT_KEY_ARR"
#define DEFAULT_KEY_DIC @"DEFAULT_KEY_DIC"

#import "DefaultVC.h"

@interface DefaultVC ()

@end

@implementation DefaultVC

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(void)rightNavBtnEvent:(UIButton *)btn{
    
    NSString *testString = @"testString";
    NSArray *arr = @[@"name",@"age"];
    NSDictionary *dic = @{@"key1":@"value1",@"key2":arr};
    
    BOOL isStrW = [JXFileOperator sandBoxSaveInfo:testString forKey:DEFAULT_KEY_STRING];
    BOOL isArrW = [JXFileOperator sandBoxSaveInfo:arr forKey:DEFAULT_KEY_ARR];
    BOOL isDicW = [JXFileOperator sandBoxSaveInfo:dic forKey:DEFAULT_KEY_DIC];

    NSDictionary *dictR = [JXFileOperator sandBoxGetInfo:[NSDictionary class] forKey:DEFAULT_KEY_DIC];
    NSLog(@" 读取到的数据 ：%@",dictR);
    
}


@end
