//
//  NSPredicateVC.m
//  JXOCAPIDemo
//
//  Created by hnbwyh on 2018/11/21.
//  Copyright © 2018年 JiXia. All rights reserved.
//

#import "NSPredicateVC.h"
#import "PredicateTestModel.h"

@interface NSPredicateVC ()
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation NSPredicateVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleForString];
}

#pragma mark ------ 检索数组中的 字符串

-(void)handleForString{
    // 包含
    NSArray *array = [[NSArray alloc]initWithObjects:@"beijing",@"shanghai",@"guangzou",@"wuhan", nil];
    NSString *string = @"ang";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",string];
    NSLog(@"\n\n%@\n\n",[array filteredArrayUsingPredicate:pred]);
    
    // 判断字符串首字母是否为字母
    NSString *regex = @"[A-Za-z]+";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    NSLog(@"\n\n%d\n\n",[predicate evaluateWithObject:@"g0907865"]);
    NSLog(@"\n\n%d\n\n",[predicate evaluateWithObject:@"8jihunbn"]);
}

#pragma mark ------ 检索数组中的 数据模型

-(void)handleForDataModel{

    [self loadDataSimplely];
    
    // 延时操作 - 查询
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       
        // 等于
        [self fiflterWithFormat:@"modelID='8888'"];
        NSLog(@"\n 等于 --------------------------------------\n");
        
        // 等于 && 大于、小于
        [self fiflterWithFormat:@"modelID='5' && age<8"];
        [self fiflterWithFormat:@"age=8 || age<8"];
        NSLog(@"\n 等于 && 大于、小于 --------------------------------------\n");
        
        // in(包含)
        [self fiflterWithFormat:@"name IN {'name111','name222','name333'} || age IN {1,2,3}"];
        NSLog(@"\n in(包含) --------------------------------------\n");
        
        // 匹配 开头 检索
        [self fiflterWithFormat:@"name BEGINSWITH 'name22222'"];
        NSLog(@"\n 匹配 开头 检索 --------------------------------------\n");
        
        // 匹配 结尾 检索
        [self fiflterWithFormat:@"name ENDSWITH '222228'"];
        NSLog(@"\n 匹配 结尾 检索 --------------------------------------\n");
        
        // 包含 检索
        [self fiflterWithFormat:@"name CONTAINS 'e22222'"];
        NSLog(@"\n 包含 检索 --------------------------------------\n");
        
        // 匹配 任意 检索 - name 中只要有 t 、name 中第n个字符被限定
        [self fiflterWithFormat:@"name like '*t*'"];
        NSLog(@"\n name 中只要有 t --------------------------------------\n");
        [self fiflterWithFormat:@"name like '*te*'"];
        NSLog(@"\n name 中只要有 te --------------------------------------\n");
        
        [self fiflterWithFormat:@"name like '???te2'"];
        NSLog(@"\n name 中第n个字符被限定 --------------------------------------\n");
        
    });
    
}

#pragma mark - 操作

// 等于、且(&&)、或(||)
- (NSArray *)fiflterWithFormat:(NSString *)format{
    // 查询
    NSPredicate *p1 = [NSPredicate predicateWithFormat:format];
    NSArray *rlt1 = [self.dataSource filteredArrayUsingPredicate:p1];
    
    if (rlt1.count > 0) {
        for (PredicateTestModel *f in rlt1) {
            NSLog(@"\n\n查询结果:\nname:%@-age:%ld-modelID:%@\n\n",f.name,f.age,f.modelID);
        }
    } else {
        NSLog(@"\n\n查询结果:未找到\n\n");
    }
    
    return rlt1;
}

#pragma mark - 加载数据
- (void)loadDataSimplely{
    for (NSInteger cou = 0; cou < 100; cou ++) {
        PredicateTestModel *f = [PredicateTestModel modelWithName:[NSString stringWithFormat:@"name%ld",cou+1]
                                                              age:cou+1
                                                              fid:[NSString stringWithFormat:@"%ld",cou+1]];
        [self.dataSource addObject:f];
        
    }
}


#pragma mark - lazy load
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}


@end
