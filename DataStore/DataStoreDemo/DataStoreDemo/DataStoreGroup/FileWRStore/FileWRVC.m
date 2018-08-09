//
//  FileWRVC.m
//  LXYHOCFunctionsDemo
//
//  Created by hnbwyh on 17/6/8.
//  Copyright © 2017年 lachesismh. All rights reserved.
//

#import "FileWRVC.h"
#import "JXFileOperator.h"

@interface FileWRVC ()

@end

@implementation FileWRVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.displayLabel.text = @"可查看 NSFileManager 使用";
    
}

-(void)rightNavBtnEvent:(UIButton *)btn{
    NSString            *testString        = @"平凡的世界8 My heart will go on";
    NSArray             *testArr           = @[testString,@[@"11",@88,@{@"k1":@99}]];
    NSDictionary        *testDic           = @{
                                               @"k1":testString,
                                               @"k2":testArr,
                                               @"k3":@{@"k33":@[@33]}
                                               };
    
    // 存
    BOOL rlt1 = [JXFileOperator saveDataInfo:testString forKey:@"testString"];
    BOOL rlt2 = [JXFileOperator saveDataInfo:testArr forKey:@"testArr"];
    BOOL rlt3 = [JXFileOperator saveDataInfo:testDic forKey:@"testDic"];
    
    // 取
    id str = [JXFileOperator getDataInfo:[NSString class] forKey:@"testString"];
    id arr = [JXFileOperator getDataInfo:[NSArray class] forKey:@"testArr"];
    id dic = [JXFileOperator getDataInfo:[NSDictionary class] forKey:@"testDic"];
    
    NSLog(@"\n %@ \n %@ \n %@ \n",str,arr,dic);
    
}


@end
