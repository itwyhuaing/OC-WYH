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

@interface JXSQLiteVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView            *table;
@property (nonatomic,strong) NSMutableArray         *listData;
@property (nonatomic,strong) NSMutableArray         *methodArr;

@end

@implementation JXSQLiteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.listData addObjectsFromArray:@[@"增新数据",
                                         @"删除表",@"删除数据",
                                         @"改-新增表字段",
                                         @"改-修改已存数据(简单的字符串类型)",@"改-修改已存数据(数组、字典等类型)",@"改-修改已存数据(替换方式)",
                                         @"查"]];
    [self.methodArr addObjectsFromArray:@[@"insertDataWithCount",
                                          @"deleteDataTable",@"deleteData",
                                          @"addKeyForTable",
                                          @"updateTableData",@"updateTableData2",@"updateTableData3",
                                          @"queryData"]];
    [self.view addSubview:self.table];
    
    
    [[JXFMDBMOperator sharedInstance] openLog];
    // 删除旧库
    [[JXFMDBMOperator sharedInstance] deleteDataBaseWithdbName:NSStringFromClass([self class])];
    // 创建新库
    [[JXFMDBMOperator sharedInstance] createDataBaseWithdbName:NSStringFromClass([self class])];
    // 创建表
    [[JXFMDBMOperator sharedInstance] createTableWithModelCls:[PersonInfo class]];
}


-(void)rightNavBtnEvent:(UIButton *)btn{
    //self.displayLabel.text = @" 1> FMDB简单操作分析及应用中添加运行时技术  \n \n \n2> 点击启动按钮,删除旧数据库，创建新数据库 \n \n \n3> 观察沙盒路径文件变化";
}

#pragma mark --- 增(插入操作)

- (void)insertDataWithCount:(NSInteger)count{
    // 插入数据
    NSArray *data = [self loadPersonInfoDataSourceWithTotal:count];
    for (PersonInfo *f in data) {
        [[JXFMDBMOperator sharedInstance] insertDataModel:f];
    }
}

- (void)insertDataWithCount{
    [self insertDataWithCount:8];
}


#pragma mark --- 删

#pragma mark 删除表操作
- (void)deleteDataTable{
    [[JXFMDBMOperator sharedInstance] deleteDataTableWithModelCls:[PersonInfo class]];
}

#pragma mark 删除数据表数据
- (void)deleteData{
    //[[JXFMDBMOperator sharedInstance] deleteDataFromTableWithModelCls:[PersonInfo class] deleteSql:@"name='testName'"];
    
    //[[JXFMDBMOperator sharedInstance] deleteDataFromTableWithModelCls:[PersonInfo class] deleteSql:@"age=26"];
    
    //[[JXFMDBMOperator sharedInstance] deleteDataFromTableWithModelCls:[PersonInfo class] deleteSql:@"age>=26"];
    
    //[[JXFMDBMOperator sharedInstance] deleteDataFromTableWithModelCls:[PersonInfo class] deleteSql:@"age<=26 and name='testName'"];
    
    [[JXFMDBMOperator sharedInstance] deleteDataFromTableWithModelCls:[PersonInfo class] deleteSql:@"age<=26 and name='testName' or ageTest=5"];
}


#pragma mark --- 更新/修改表操作

#pragma mark 新增表字段
- (void)addKeyForTable{
    /** 版本迭代中数据模型字段增加或删除
     1. 属性增加
     2. 数据表字段增加
     */
    [[JXFMDBMOperator sharedInstance] addKeyForDataTableWithModelCls:[PersonInfo class] addKeySql:@"addStr text"];
    [[JXFMDBMOperator sharedInstance] addKeyForDataTableWithModelCls:[PersonInfo class] addKeySql:@"addArr blob"];
    [[JXFMDBMOperator sharedInstance] addKeyForDataTableWithModelCls:[PersonInfo class] addKeySql:@"addDic blob"];
    [[JXFMDBMOperator sharedInstance] addKeyForDataTableWithModelCls:[PersonInfo class] addKeySql:@"addFloat f"];
}

#pragma mark 修改已存数据
- (void)updateTableData{
    // 更新 字符串 类型
    [[JXFMDBMOperator sharedInstance] updateTableDataWithModelCls:[PersonInfo class]
                                                        updateKey:@"name"
                                                      updateValue:@"updateNameRain"
                                                      locationKey:@"age"
                                                    locationValue:@28];
}

- (void)updateTableData2{
    // 更新 数组 类型 - 失败
        NSDictionary *math2 = @{
                               @"math":@"66",
                               @"subID":@"88"
                               };
        NSDictionary *english2 = @{
                                  @"subName":@"99",
                                  @"subID":@"00"
                                  };
        [[JXFMDBMOperator sharedInstance] updateTableDataWithModelCls:[PersonInfo class]
                                                            updateKey:@"subs"
                                                          updateValue:@[math2,english2]
                                                          locationKey:@"age"
                                                        locationValue:@28];
}

- (void)updateTableData3{
    
    /** 可以考虑的思路
     1. 先取出数据
     2. 重新赋值然后插入(替换)
     */
}

#pragma mark 插入操作、新增字段

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


#pragma mark --- 查询操作

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


#pragma mark --- 去重操作

- (void)distinctData{
    // 读取数据 - 查重 - 待定，未完成
//    NSArray *rlt = [[JXFMDBMOperator sharedInstance] distinctDataForModelCls:[PersonInfo class] distinctKey:@"name" orderKey:@"age"];
//    [self printRltData:rlt];
}

#pragma mark --- 加载数据

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

#pragma mark --- test rlt print

- (void)printRltData:(NSArray *)rlt{
    for (PersonInfo *rf in rlt) {
        NSLog(@"\n \n name:%@ \n age:%ld \n 数组subs:%@ \n 字典classRoom:%@ \n mark:%f \n son%@ - son.name %@  \n ageTest:%ld \n markTest:%f \n boolTest :%i\n \n ",rf.name,rf.age,rf.subs[0],rf.classRoom,rf.mark,rf.son,rf.son.name,rf.ageTest,rf.markTest,rf.boolTest);
    }
}


#pragma mark ------ UITableViewDelegate,UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YHBaseTableCommanCellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YHBaseTableCommanCellID"];
    }
    cell.textLabel.text = self.listData[indexPath.row];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.title = self.listData[indexPath.row];
    SEL selector = NSSelectorFromString(self.methodArr[indexPath.row]);
    if ([self respondsToSelector:selector]) {
        [self performSelector:selector withObject:nil];
    }
}

#pragma mark ------ lazy load

-(UITableView *)table{
    if (!_table) {
        CGRect rect = CGRectZero;
        rect.size = self.view.frame.size;
        rect.size.height = CGRectGetHeight(self.view.frame)/2.0;
        _table = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
    }
    return _table;
}

-(NSMutableArray *)listData{
    if (!_listData) {
        _listData = [[NSMutableArray alloc] init];
    }
    return _listData;
}

-(NSMutableArray *)methodArr{
    if (!_methodArr) {
        _methodArr = [NSMutableArray new];
    }
    return _methodArr;
}

@end
