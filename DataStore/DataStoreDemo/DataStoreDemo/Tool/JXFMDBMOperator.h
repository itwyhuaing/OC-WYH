//
//  JXFMDBMOperator.h
//  DataStoreDemo
//
//  Created by hnbwyh on 2018/7/20.
//  Copyright © 2018年 hainbwyh. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface JXDataModelParser : NSObject


/**
 解析数据模型的属性结构，并组装生成相应表的 SQLite 语句

 @param modelCls 传入数据模型类名
 @return 相应的 SQLite 语句
 */
- (NSString *)sqlForTableKeyWithModelCls:(Class)modelCls;

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

 @param fileName 数据库名称
 @return 操作状态 ：TRUE - 成功 、FALSE - 失败
 */
- (BOOL)deleteDataBaseWithFileName:(NSString *)fileName;


/**
 创建数据库

 @param fileName 数据库名称
 @return 操作状态 ：TRUE - 成功 、FALSE - 失败
 */
- (BOOL)createDataBaseWithFileName:(NSString *)fileName;


/**
 创建表

 @param modelCls 数据表名称
 @return 操作状态 ：TRUE - 成功 、FALSE - 失败
 */
-(BOOL)createTableWithModelCls:(Class)modelCls;

/**
 用于快速测试
 */
- (void)testMethod:(id)modelCls;

@end
