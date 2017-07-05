
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
    
    BOOL isStrW = [YHFileOperator defaultSaveInfo:testString forKey:DEFAULT_KEY_STRING];
    BOOL isArrW = [YHFileOperator defaultSaveInfo:arr forKey:DEFAULT_KEY_ARR];
    BOOL isDicW = [YHFileOperator defaultSaveInfo:dic forKey:DEFAULT_KEY_DIC];
    
    NSDictionary *dictR = [YHFileOperator defaultGetInfoCls:[NSDictionary class] forKey:DEFAULT_KEY_DIC];
    NSLog(@" 读取到的数据 ：%@",dictR);
    
}


@end
