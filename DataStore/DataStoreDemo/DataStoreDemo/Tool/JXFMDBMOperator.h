//
//  JXFMDBMOperator.h
//  DataStoreDemo
//
//  Created by hnbwyh on 2016/7/20.
//  Copyright © 2016年 hainbwyh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"


@interface JXDataModelParser : NSObject


/**
 打印开启状态 ：TRUE - 打印 ，FALSE - 关闭
 */
@property (nonatomic,assign) BOOL logStatus;
- (void)printLogMsg:(NSString *)msg;

/**
 保存插入数据操作所解析出的 values 值
 */
@property (nonatomic,strong) NSMutableArray                 *modelValues;

/**
 解析数据模型的属性结构，并组装生成相应表的 SQLite 语句

 @param modelCls 待处理的数据的数据类型
 @return 相应的 SQLite 语句
 */
- (NSString *)sqlForTableKeyWithModelCls:(Class)modelCls;


/**
 解析数据，组装生成相应的插入数据的 SQLite 语句

 @param model 带插入数据
 @return 相应的 SQLite 语句
 */
- (NSString *)sqlForInsertDataIntoTableWithModel:(id)model;


/**
 数据查询结果配置数据

 @param model 待赋值的数据模型实例对象
 @param rltSet 待解析的 FMDB 查询结果
 */
- (void)configValuesForModel:(id)model rltSet:(FMResultSet *)rltSet;



@end

@interface JXFMDBMOperator : NSObject

/**
  单例

 @return 单例对象
 */
+ (instancetype)sharedInstance;

/**
 打开打印日志
 */
- (void)openLog;


/**
 删除数据库

 @param dbName 数据库名称
 @return 操作状态 ：TRUE - 成功 、FALSE - 失败
 */
- (BOOL)deleteDataBaseWithdbName:(NSString *)dbName;


/**
 删除数据表

 @param modelCls 待处理的数据的数据类型
 @return 操作状态 ：TRUE - 成功 、FALSE - 失败
 */
- (BOOL)deleteDataTableWithModelCls:(Class)modelCls;

/**
 创建数据库

 @param dbName 数据库名称
 @return 操作状态 ：TRUE - 成功 、FALSE - 失败
 */
- (BOOL)createDataBaseWithdbName:(NSString *)dbName;


/**
 创建表

 @param modelCls 待处理的数据的数据类型
 @return 操作状态 ：TRUE - 成功 、FALSE - 失败
 */
-(BOOL)createTableWithModelCls:(Class)modelCls;


/**
 插入数据

 @param model 带插入的数据
 @return 操作状态 ：TRUE - 成功 、FALSE - 失败
 */
- (BOOL)insertDataModel:(id)model;


/**
 读取数据库数据 - 默认全部升序排列

 @param modelCls 待处理的数据的数据类型
 @param querySql 查询语句 例如：1单个条件> name='wyh'    2 and 或 or 条件> name='wyh' and age>18      3 空> 为空时意味着不设置查询条件即查询全部数据
 @param orderKey 结果排序关键字即数据模型属性
 @return 读取数据结果，以相应模型的数组形式给出
 */
- (NSArray *)queryDataForModelCls:(Class)modelCls querySql:(NSString *)querySql orderKey:(NSString *)orderKey;


/**
 依据给定的查重字段筛选数据库 - 默认全部升序排列 - 调试未通过

 @param modelCls 待处理的数据的数据类型
 @param distinctKey 给定的查重字段
 @param orderKey 结果排序关键字即数据模型属性
 @return 查重之后的数据结果，以相应模型的数组形式给出
 */
//- (NSArray *)distinctDataForModelCls:(Class)modelCls distinctKey:(NSString *)distinctKey orderKey:(NSString *)orderKey;


/**
 删除数据表数据

 @param modelCls 待处理的数据的数据类型
 @param deleteSql 删除语句 例如： name='wyh'  2> age=18  age<18  age>=18  3> name='wyh' and age>=18 or mark>90
 @return 操作状态 ：TRUE - 成功 、FALSE - 失败
 */
- (BOOL)deleteDataFromTableWithModelCls:(Class)modelCls deleteSql:(NSString *)deleteSql;


/**
 给指定数据表增加字段 :在项目版本迭代过程中，会有增加字段的需求 。简述 1> 数据模型增加相应属性 2>插入数据之前调用该方法

 @param modelCls 待处理的数据的数据类型
 @param addKeySql 新增数据表字段语句 例如：1> name text 2> age integer 3> testObj blob
 @return 操作状态 ：TRUE - 成功 、FALSE - 失败
 */
- (BOOL)addKeyForDataTableWithModelCls:(Class)modelCls addKeySql:(NSString *)addKeySql;

/**
 更新指定数据表中指定数据 ：updateValue - 暂不支持数组、字典等对象

 @param modelCls 待处理的数据的数据类型
 @param updateKey 待更新的字段
 @param updateValue 待更新的值
 @param locationKey 定位待更新数据的字段
 @param locationValue 定位待更新数据的值
 @return 操作状态 ：TRUE - 成功 、FALSE - 失败
 */
- (BOOL)updateTableDataWithModelCls:(Class)modelCls
                          updateKey:(NSString *)updateKey
                        updateValue:(id)updateValue
                        locationKey:(NSString *)locationKey
                      locationValue:(id)locationValue;

/**
 用于快速测试
 */
- (void)testMethod:(id)modelCls;

@end
