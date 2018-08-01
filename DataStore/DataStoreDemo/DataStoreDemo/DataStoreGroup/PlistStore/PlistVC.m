//
//  PlistVC.m
//  LXYHOCFunctionsDemo
//
//  Created by hnbwyh on 17/6/8.
//  Copyright © 2017年 lachesismh. All rights reserved.
//

#import "PlistVC.h"

@interface PlistVC ()

@end

@implementation PlistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

- (void)rightNavBtnEvent:(UIButton *)btn{

    NSString *filePath = [JXFileOperator filePathForFileName:@"test.plist"];
    NSString *testString = @"testString";
    NSArray *arr = @[@"name",@"age"];
    NSDictionary *dic = @{@"key1":@"value1",@"key2":arr};
    
    // 写入 - 依次覆盖
    BOOL isStrW = [testString writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    BOOL isArrW = [arr writeToFile:filePath atomically:YES];
    BOOL isDicW = [dic writeToFile:filePath atomically:YES];
    
    // 读取 - 最终写入的数据是什么类型就用什么类型接收读取到的数据
    NSDictionary *rDic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSLog(@" 读取到的数据 ：%@",rDic);
    
}


-(void)dealloc{
    NSLog(@" %s ",__FUNCTION__);
}

@end
