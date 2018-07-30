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
    self.displayLabel.text = @" 1> FMDB简单操作分析  \n \n \n2> 点击启动按钮,删除旧数据库，创建新数据库 \n \n \n3> 观察沙盒路径文件变化";
    [[JXFMDBMOperator sharedInstance] openLog];
    // 删除旧库
    [[JXFMDBMOperator sharedInstance] deleteDataBaseWithdbName:NSStringFromClass([self class])];
    // 创建新库
    [[JXFMDBMOperator sharedInstance] createDataBaseWithdbName:NSStringFromClass([self class])];
    // 创建表
    [[JXFMDBMOperator sharedInstance] createTableWithModelCls:[PersonInfo class]];
    // 插入数据
    [self insertData];
}


-(void)rightNavBtnEvent:(UIButton *)btn{
    // 读取数据
    //[self selectData];
    
    // 删除数据表
    //[self deleteDataTable];
    
    //删除数据表数据
    [self deleteData];
    
    [self addKeyForTable];
    
    // 读取数据库中指定数据表数据
    [self queryData];
}

#pragma mark - 插入操作

- (void)insertData{
    // 插入数据
    NSArray *data = [self loadPersonInfoDataSourceWithTotal:8];
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
    [[JXFMDBMOperator sharedInstance] addKeyForDataTableWithModelCls:[PersonInfo class] addKeySql:@"writingName text"];
}

// 更新/修改表数据


#pragma mark - 去重操作

- (void)distinctData{
    // 读取数据 - 查重 - 待定，未完成
    NSArray *rlt = [[JXFMDBMOperator sharedInstance] distinctDataForModelCls:[PersonInfo class] distinctKey:@"name" orderKey:@"age"];
    [self printRltData:rlt];
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
