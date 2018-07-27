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
}


-(void)rightNavBtnEvent:(UIButton *)btn{
    
    // 插入数据
    NSArray *data = [self loadPersonInfoDataSource];
    for (PersonInfo *f in data) {
        [[JXFMDBMOperator sharedInstance] insertDataModel:f];
    }
    
    // 读取数据 - 无筛选条件，查询全部数据
    //NSArray *rlt =  [[JXFMDBMOperator sharedInstance] queryDataForModelCls:[PersonInfo class] querySql:nil orderKey:@"age"];
    
    // 读取数据 - 单个条件
    //NSArray *rlt =  [[JXFMDBMOperator sharedInstance] queryDataForModelCls:[PersonInfo class] querySql:@"name='wyh'" orderKey:@"age"];
    
    // 读取数据 - 多个条件 and
    //NSArray *rlt =  [[JXFMDBMOperator sharedInstance] queryDataForModelCls:[PersonInfo class] querySql:@"name='wyh' and age=26" orderKey:@"age"];
    
    // 读取数据 - 多个条件 or
    NSArray *rlt =  [[JXFMDBMOperator sharedInstance] queryDataForModelCls:[PersonInfo class] querySql:@"name='testName' or age=26" orderKey:@"age"];
    
    for (PersonInfo *rf in rlt) {
        NSLog(@"\n \n name:%@ \n age:%ld \n 数组subs:%@ \n 字典classRoom:%@ \n mark:%f \n son%@ - son.name %@  \n ageTest:%ld \n markTest:%f \n boolTest :%i\n \n ",rf.name,rf.age,rf.subs[0],rf.classRoom,rf.mark,rf.son,rf.son.name,rf.ageTest,rf.markTest,rf.boolTest);
    }
    // 查询数据
    
    
    
    
    
}

- (NSArray *)loadPersonInfoDataSource{
    NSMutableArray *dataSource = [NSMutableArray new];
    for (NSInteger cou = 0; cou < 8; cou ++) {
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

- (PersonInfo *)createModel{
    PersonInfo *f = [PersonInfo new];
    NSDictionary *math = @{
                           @"subName":@"Math",
                           @"subID":@"S_150"
                           };
    NSDictionary *english = @{
                              @"subName":@"English",
                              @"subID":@"E_150"
                              };
    f.name      = @"wyh";
    f.age       = 18;
    f.mark      = 88.69;
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
    f.ageTest = 68;
    f.markTest = 68.68;
    f.boolTest = TRUE;
    return f;
}

@end
