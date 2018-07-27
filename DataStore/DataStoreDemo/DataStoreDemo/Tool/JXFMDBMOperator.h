//
//  JXFMDBMOperator.h
//  DataStoreDemo
//
//  Created by hnbwyh on 2018/7/20.
//  Copyright © 2018年 hainbwyh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"


@interface JXDataModelParser : NSObject


/**
 保存插入数据操作所解析出的 values 值
 */
@property (nonatomic,strong) NSMutableArray                 *modelValues;

/**
 解析数据模型的属性结构，并组装生成相应表的 SQLite 语句

 @param modelCls 传入数据模型类名
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
 创建数据库

 @param dbName 数据库名称
 @return 操作状态 ：TRUE - 成功 、FALSE - 失败
 */
- (BOOL)createDataBaseWithdbName:(NSString *)dbName;


/**
 创建表

 @param modelCls 待存储的数据类型
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

 @param modelCls 待读取的数据的数据类型
 @param querySql 查询语句 例如：1单个条件> name='wyh'    2 and 或 or 条件> name='wyh' and age>18      3 空> 为空时意味着不设置查询条件即查询全部数据
 @param orderKey 结果排序关键字即数据模型属性
 @return 读取数据结果，以相应模型的数组形式给出
 */
- (NSArray *)queryDataForModelCls:(Class)modelCls querySql:(NSString *)querySql orderKey:(NSString *)orderKey;

/**
 用于快速测试
 */
- (void)testMethod:(id)modelCls;

@end
