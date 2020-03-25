//
//  YHDataBaseManager.h
//  DataBase
//
//  Created by hnbwyh on 17/6/13.
//  Copyright © 2017年 vera. All rights reserved.
//

/*
 使用说明：
 1.调用单例函数
 2.创建数据库与表
 3.第二步返回值为真则可继续单例操作数据库：增 删 改 查 清空
 */

#import <Foundation/Foundation.h>
@class Movie;

@interface YHDataBaseManager : NSObject

/**
 * SQLite 数据库管理单例
 */
+ (instancetype)sharedManager;

/**
 * 建数据库
 */
- (BOOL)createDataBaseWithFileName:(NSString *)fileName;

/**
 * 删数据库
 */
- (BOOL)deleteDataBaseWithFileName:(NSString *)fileName;


/**
 * 建表
 */
//- (void)createTable;

/**
 * 增
 */
- (BOOL)insertDataToDatabase:(Movie *)movie;

/**
 * 删
 */
- (BOOL)deleteDataFromDatabaseWhere:(NSString *)where;

/**
 * 改
 */
- (BOOL)updateValue:(NSString *)value atKey:(NSString *)key where:(NSString *)where;

/**
 * 查
 */
- (NSArray *)selectValue:(NSString *)value atKey:(NSString *)key;

/**
 * 清空
 */
- (BOOL)clearDataFromTable:(NSString *)table;

/**
 * 获取所有的数据
 */
- (NSArray *)getAllDataFromDatabase;

@end
