//
//  JXSQLiteVC.m
//  DataStoreDemo
//
//  Created by hnbwyh on 2018/7/23.
//  Copyright © 2018年 hainbwyh. All rights reserved.
//

#import "JXSQLiteVC.h"
#import "JXFMDBMOperator.h"
#import "PersonInfo.h"

@interface JXSQLiteVC ()

@end

@implementation JXSQLiteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.displayLabel.text = @" 1> FMDB简单操作分析及应用中添加运行时技术  \n \n \n2> 点击启动按钮,删除旧数据库，创建新数据库 \n \n \n3> 观察沙盒路径文件变化";
    [[JXFMDBMOperator sharedInstance] openLog];
    // 删除旧库
    //[[JXFMDBMOperator sharedInstance] deleteDataBaseWithdbName:NSStringFromClass([self class])];
    // 创建新库
    [[JXFMDBMOperator sharedInstance] createDataBaseWithdbName:NSStringFromClass([self class])];
    // 创建表
    [[JXFMDBMOperator sharedInstance] createTableWithModelCls:[PersonInfo class]];
    // 插入数据
    [self insertDataWithCount:8];
}


-(void)rightNavBtnEvent:(UIButton *)btn{
    // 读取数据
    //[self selectData];
    
    // 删除数据表
    //[self deleteDataTable];
    
    //删除数据表数据
    //[self deleteData];
    
    // 数据表新增字段
    //[self addKeyForTable];
    //[self insertDataAfterAdd];
    
    // 更新数据表数据
    [self updateTableData];
    
    // 读取数据库中指定数据表数据
    [self queryData];
}
#pragma mark - 插入操作、新增字段

- (void)insertDataAfterAdd{
//    NSArray *data = [self loadPersonInfoDataSourceWithTotal:1];
//    for (PersonInfo *f in data) {
//        f.addStr    = @"addStr";
//        f.addArr    = @[@"addStr1",@"addStr2"];
//        f.addDic    = @{
//                     @"k1":@"v1",
//                     @"k3":@"v2",
//                     };
//        f.addFloat  = 0.88;
//        [[JXFMDBMOperator sharedInstance] insertDataModel:f];
//    }
}

#pragma mark - 插入操作

- (void)insertDataWithCount:(NSInteger)count{
    // 插入数据
    NSArray *data = [self loadPersonInfoDataSourceWithTotal:count];
    for (PersonInfo *f in data) {
        [[JXFMDBMOperator sharedInstance] insertDataModel:f];
    }
}

#pragma mark - 查询操作

- (void)queryData{
    // 读取数据 - 无筛选条件，查询全部数据
    NSArray *rlt =  [[JXFMDBMOperator sharedInstance] queryDataForModelCls:[PersonInfo class] querySql:nil orderKey:@"age"];
    
    // 读取数据 - 单个条件
    //NSArray *rlt =  [[JXFMDBMOperator sharedInstance] queryDataForModelCls:[PersonInfo class] querySql:@"name='wyh'" orderKey:@"age"];
    
    // 读取数据 - 多个条件 and
    //NSArray *rlt =  [[JXFMDBMOperator sharedInstance] queryDataForModelCls:[PersonInfo class] querySql:@"name='wyh' and age=26" orderKey:@"age"];
    
    // 读取数据 - 多个条件 or
    //NSArray *rlt =  [[JXFMDBMOperator sharedInstance] queryDataForModelCls:[PersonInfo class] querySql:@"name='testName' or age=26" orderKey:@"age"];
    [self printRltData:rlt];
}

#pragma mark - 删除操作

//删除表操作
- (void)deleteDataTable{
    [[JXFMDBMOperator sharedInstance] deleteDataTableWithModelCls:[PersonInfo class]];
}

//删除数据表数据
- (void)deleteData{
    //[[JXFMDBMOperator sharedInstance] deleteDataFromTableWithModelCls:[PersonInfo class] deleteSql:@"name='testName'"];
    
    //[[JXFMDBMOperator sharedInstance] deleteDataFromTableWithModelCls:[PersonInfo class] deleteSql:@"age=26"];
    
    //[[JXFMDBMOperator sharedInstance] deleteDataFromTableWithModelCls:[PersonInfo class] deleteSql:@"age>=26"];
    
    //[[JXFMDBMOperator sharedInstance] deleteDataFromTableWithModelCls:[PersonInfo class] deleteSql:@"age<=26 and name='testName'"];
    
    [[JXFMDBMOperator sharedInstance] deleteDataFromTableWithModelCls:[PersonInfo class] deleteSql:@"age<=26 and name='testName' or ageTest=5"];
}

#pragma mark - 更新/修改表操作

// 新增表字段
- (void)addKeyForTable{
    [[JXFMDBMOperator sharedInstance] addKeyForDataTableWithModelCls:[PersonInfo class] addKeySql:@"addStr text"];
    [[JXFMDBMOperator sharedInstance] addKeyForDataTableWithModelCls:[PersonInfo class] addKeySql:@"addArr blob"];
    [[JXFMDBMOperator sharedInstance] addKeyForDataTableWithModelCls:[PersonInfo class] addKeySql:@"addDic blob"];
    [[JXFMDBMOperator sharedInstance] addKeyForDataTableWithModelCls:[PersonInfo class] addKeySql:@"addFloat f"];
}

// 更新/修改表数据
- (void)updateTableData{
    // 更新 字符串 类型
    [[JXFMDBMOperator sharedInstance] updateTableDataWithModelCls:[PersonInfo class]
                                                        updateKey:@"name"
                                                      updateValue:@"updateNameRain"
                                                      locationKey:@"age"
                                                    locationValue:@28];
    
    // 更新 数组 类型 - 失败
//    NSDictionary *math2 = @{
//                           @"math":@"66",
//                           @"subID":@"88"
//                           };
//    NSDictionary *english2 = @{
//                              @"subName":@"99",
//                              @"subID":@"00"
//                              };
//    [[JXFMDBMOperator sharedInstance] updateTableDataWithModelCls:[PersonInfo class]
//                                                        updateKey:@"subs"
//                                                      updateValue:@[math2,english2]
//                                                      locationKey:@"age"
//                                                    locationValue:@28];
    
}

#pragma mark - 去重操作

- (void)distinctData{
    // 读取数据 - 查重 - 待定，未完成
//    NSArray *rlt = [[JXFMDBMOperator sharedInstance] distinctDataForModelCls:[PersonInfo class] distinctKey:@"name" orderKey:@"age"];
//    [self printRltData:rlt];
}

#pragma mark - 加载数据

- (NSArray *)loadPersonInfoDataSourceWithTotal:(NSInteger)total{
    NSMutableArray *dataSource = [NSMutableArray new];
    for (NSInteger cou = 0; cou < total; cou ++) {
        PersonInfo *f = [PersonInfo new];
        NSDictionary *math = @{
                               @"subName":@"Math",
                               @"subID":@"S_150"
                               };
        NSDictionary *english = @{
                                  @"subName":@"English",
                                  @"subID":@"E_150"
                                  };
        f.name      = cou < 3 ? @"testName" : @"wyh";
        f.age       = cou+21;
        f.mark      = cou + 1 + 0.68;
        f.subs      = @[math,english];
        f.classRoom = @{
                        @"grade1":@"room100",
                        @"grade2":@"room200",
                        @"grade3":@"room300"
                        };
        
        // 带测试数据类型
        Son *s = [Son new];
        s.name = @"SonName";
        f.son  = s;
        f.ageTest = cou+1;
        f.markTest = 68.68;
        f.boolTest = TRUE;
        [dataSource addObject:f];
    }
    return dataSource;
}

#pragma mark - test rlt print

- (void)printRltData:(NSArray *)rlt{
    for (PersonInfo *rf in rlt) {
        NSLog(@"\n \n name:%@ \n age:%ld \n 数组subs:%@ \n 字典classRoom:%@ \n mark:%f \n son%@ - son.name %@  \n ageTest:%ld \n markTest:%f \n boolTest :%i\n \n ",rf.name,rf.age,rf.subs[0],rf.classRoom,rf.mark,rf.son,rf.son.name,rf.ageTest,rf.markTest,rf.boolTest);
    }
}

@end
