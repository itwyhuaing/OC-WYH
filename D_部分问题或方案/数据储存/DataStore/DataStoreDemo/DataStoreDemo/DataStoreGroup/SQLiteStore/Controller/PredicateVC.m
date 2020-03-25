//
//  PredicateVC.m
//  DataStoreDemo
//
//  Created by hnbwyh on 2018/7/26.
//  Copyright © 2018年 hainbwyh. All rights reserved.
//

#import "PredicateVC.h"
#import "PredicateTestModel.h"

@interface PredicateVC ()
{
    CFAbsoluteTime start;
    CFAbsoluteTime endTest;
}
@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation PredicateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.displayLabel.text = @" 1> 点击启动按钮 \n \n \n 2> 测试 NSPredicate 方式的数据查询等操作";
}

-(void)rightNavBtnEvent:(UIButton *)btn{
    self.displayLabel.hidden = FALSE;
    // 加载 888888 条数据方式 1
    //[self loadDataSimplely]; // 耗时大约 5.06 s
    // 加载 888888 条数据方式 2
    [self loadDataSource]; // 耗时大约 1.02 s
    
    // 延时操作 - 查询
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        endTest = CFAbsoluteTimeGetCurrent();
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
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    NSPredicate *p1 = [NSPredicate predicateWithFormat:format];
    NSArray *rlt1 = [self.dataSource filteredArrayUsingPredicate:p1];
    CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();
    
    if (rlt1.count > 0) {
        for (PredicateTestModel *f in rlt1) {
            NSLog(@"\n\n查询结果:\nname:%@-age:%ld-modelID:%@\n\n",f.name,f.age,f.modelID);
        }
    } else {
            NSLog(@"\n\n查询结果:未找到\n\n");
    }
    
    // 展示结果指标
    self.displayLabel.text = [NSString stringWithFormat:@"1> 共计%ld条数据 \n 2> 操作耗时:%f (秒 s)\n\n\n",self.dataSource.count,end-start];
    return rlt1;
}

#pragma mark - 加载数据
- (void)loadDataSimplely{
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    for (NSInteger cou = 0; cou < 888888; cou ++) {
        PredicateTestModel *f = [PredicateTestModel modelWithName:[NSString stringWithFormat:@"name%ld",cou+1]
                                                              age:cou+1
                                                              fid:[NSString stringWithFormat:@"%ld",cou+1]];
        [self.dataSource addObject:f];
        self.displayLabel.text = [NSString stringWithFormat:@"已加载%ld条数据",self.dataSource.count];
    }
    CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();
    self.displayLabel.text = [NSString stringWithFormat:@"加载%ld条数据耗时:%f",self.dataSource.count,end-start];
}



- (void)loadDataSource{
    
    NSInteger perCount = 111111;
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("TestQueue", DISPATCH_QUEUE_CONCURRENT);
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    __block NSMutableArray *arr1 = [NSMutableArray new];
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
       NSLog(@"\n ------ 线程%@开始 ------ \n",[NSThread currentThread]);
        for (NSInteger cou = 0; cou < perCount; cou ++) {
            
            if (cou < 8) {
                PredicateTestModel *f = [PredicateTestModel modelWithName:[NSString stringWithFormat:@"namte%ld",cou+1]
                                                                      age:cou+1
                                                                      fid:[NSString stringWithFormat:@"%ld",cou+1]];
                [arr1 addObject:f];
            }else{
                PredicateTestModel *f = [PredicateTestModel modelWithName:[NSString stringWithFormat:@"name%ld",cou+1]
                                                                      age:cou+1
                                                                      fid:[NSString stringWithFormat:@"%ld",cou+1]];
                [arr1 addObject:f];
            }
        }
        NSLog(@"\n ------ 线程%@结束,数据个数:%ld ------ \n",[NSThread currentThread],arr1.count);
        dispatch_group_leave(group);
    });
    
    __block NSMutableArray *arr2 = [NSMutableArray new];
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        NSLog(@"\n ------ 线程%@开始 ------ \n",[NSThread currentThread]);
        for (NSInteger cou = perCount; cou < perCount * 2; cou ++) {
            PredicateTestModel *f = [PredicateTestModel modelWithName:[NSString stringWithFormat:@"name%ld",cou+1]
                                                                  age:cou+1
                                                                  fid:[NSString stringWithFormat:@"%ld",cou+1]];
            [arr2 addObject:f];
        }
        NSLog(@"\n ------ 线程%@结束,数据个数:%ld ------ \n",[NSThread currentThread],arr1.count);
        dispatch_group_leave(group);
    });
    
    __block NSMutableArray *arr3 = [NSMutableArray new];
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        NSLog(@"\n ------ 线程%@开始 ------ \n",[NSThread currentThread]);
        for (NSInteger cou = perCount * 2; cou < perCount * 3; cou ++) {
            PredicateTestModel *f = [PredicateTestModel modelWithName:[NSString stringWithFormat:@"name%ld",cou+1]
                                                                  age:cou+1
                                                                  fid:[NSString stringWithFormat:@"%ld",cou+1]];
            [arr3 addObject:f];
        }
        NSLog(@"\n ------ 线程%@结束,数据个数:%ld ------ \n",[NSThread currentThread],arr1.count);
        dispatch_group_leave(group);
    });
    
    __block NSMutableArray *arr4 = [NSMutableArray new];
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        NSLog(@"\n ------ 线程%@开始 ------ \n",[NSThread currentThread]);
        for (NSInteger cou = perCount * 3; cou < perCount * 4; cou ++) {
            PredicateTestModel *f = [PredicateTestModel modelWithName:[NSString stringWithFormat:@"name%ld",cou+1]
                                                                  age:cou+1
                                                                  fid:[NSString stringWithFormat:@"%ld",cou+1]];
            [arr4 addObject:f];
        }
        NSLog(@"\n ------ 线程%@结束,数据个数:%ld ------ \n",[NSThread currentThread],arr1.count);
        dispatch_group_leave(group);
    });
    
    __block NSMutableArray *arr5 = [NSMutableArray new];
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        NSLog(@"\n ------ 线程%@开始 ------ \n",[NSThread currentThread]);
        for (NSInteger cou = perCount * 4; cou < perCount * 5; cou ++) {
            PredicateTestModel *f = [PredicateTestModel modelWithName:[NSString stringWithFormat:@"name%ld",cou+1]
                                                                  age:cou+1
                                                                  fid:[NSString stringWithFormat:@"%ld",cou+1]];
            [arr5 addObject:f];
        }
        NSLog(@"\n ------ 线程%@结束,数据个数:%ld ------ \n",[NSThread currentThread],arr1.count);
        dispatch_group_leave(group);
    });
    
    __block NSMutableArray *arr6 = [NSMutableArray new];
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        NSLog(@"\n ------ 线程%@开始 ------ \n",[NSThread currentThread]);
        for (NSInteger cou = perCount * 5; cou < perCount * 6; cou ++) {
            PredicateTestModel *f = [PredicateTestModel modelWithName:[NSString stringWithFormat:@"name%ld",cou+1]
                                                                  age:cou+1
                                                                  fid:[NSString stringWithFormat:@"%ld",cou+1]];
            [arr6 addObject:f];
        }
        NSLog(@"\n ------ 线程%@结束,数据个数:%ld ------ \n",[NSThread currentThread],arr1.count);
        dispatch_group_leave(group);
    });
    
    __block NSMutableArray *arr7 = [NSMutableArray new];
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        NSLog(@"\n ------ 线程%@开始 ------ \n",[NSThread currentThread]);
        for (NSInteger cou = perCount * 6; cou < perCount * 7; cou ++) {
            PredicateTestModel *f = [PredicateTestModel modelWithName:[NSString stringWithFormat:@"name%ld",cou+1]
                                                                  age:cou+1
                                                                  fid:[NSString stringWithFormat:@"%ld",cou+1]];
            [arr7 addObject:f];
        }
        NSLog(@"\n ------ 线程%@结束,数据个数:%ld ------ \n",[NSThread currentThread],arr1.count);
        dispatch_group_leave(group);
    });
    
    __block NSMutableArray *arr8 = [NSMutableArray new];
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        NSLog(@"\n ------ 线程%@开始 ------ \n",[NSThread currentThread]);
        for (NSInteger cou = perCount * 7; cou < perCount * 8; cou ++) {
            PredicateTestModel *f = [PredicateTestModel modelWithName:[NSString stringWithFormat:@"name%ld",cou+1]
                                                                  age:cou+1
                                                                  fid:[NSString stringWithFormat:@"%ld",cou+1]];
            [arr8 addObject:f];
        }
        NSLog(@"\n ------ 线程%@结束,数据个数:%ld ------ \n",[NSThread currentThread],arr1.count);
        dispatch_group_leave(group);
    });
    
    dispatch_group_notify(group, queue, ^{
       
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [self.dataSource addObjectsFromArray:arr1];
            [self.dataSource addObjectsFromArray:arr2];
            [self.dataSource addObjectsFromArray:arr3];
            [self.dataSource addObjectsFromArray:arr4];
            [self.dataSource addObjectsFromArray:arr5];
            [self.dataSource addObjectsFromArray:arr6];
            [self.dataSource addObjectsFromArray:arr7];
            [self.dataSource addObjectsFromArray:arr8];
            CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();
            self.displayLabel.text = [NSString stringWithFormat:@"加载%ld条数据耗时:%f",self.dataSource.count,end-start];
            NSLog(@"\n\n ====== 线程%@,数据个数:%ld，耗时%f ====== \n\n",[NSThread currentThread],self.dataSource.count,end-start);
            
        });
        
    });
}

#pragma mark - lazy load
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

@end
