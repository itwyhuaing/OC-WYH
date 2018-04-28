//
//  CategaryVC.m
//  RuntimeProDemo
//
//  Created by hnbwyh on 2018/4/26.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "CategaryVC.h"
#import "NSDictionary+JXCategary.h"

@interface CategaryVC ()

@end

@implementation CategaryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"CategaryVC";
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSDictionary *data = @{@"data":@{
                                   @"arr":@{},
                                   @"str":@[],
                                   @"dic":@"68"
                                   }};
    NSDictionary *dictx = [data jxValueWithKey:@"data" targetCls:[NSDictionary class]];
    NSArray *arr = [dictx jxValueWithKey:@"arr" targetCls:[NSArray class]];
    NSLog(@" \n 解析结果 \n dictx:%@  \n arr:%@ \n",dictx,arr);
    
    NSString *str1 = nil;
    NSArray *arr1 = nil;
    NSDictionary *dict1 = nil;
    
    NSString *str2 = @"str2";
    NSArray *arr2 = @[@"arr2"];
    NSDictionary *dict2 = @{@"key":@"dict2"};
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:str1 forKey:@"str1"];
    [dic setValue:str2 forKey:@"str2"];
    [dic setValue:arr1 forKey:@"arr1"];
    [dic setValue:arr2 forKey:@"arr2"];
    [dic setValue:dict1 forKey:@"dict1"];
    [dic setValue:dict2 forKey:@"dict2"];
    
    
    NSLog(@" \n 组装结果 \n dic:%@ \n",dic);
    
}

@end
