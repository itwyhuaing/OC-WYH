# FMDB

## SDK 代码结构与核心类

* 代码结构

![image]()


* 核心类

> FMDatabase : 一个FMDatabase对象就代表一个单独的SQLite数据库，用来执行SQL语句。

>> 常用方法
```
执行更新的SQL语句，字符串里面的"?"，依次用后面的参数替代，必须是对象，不能是int等基本类型
- (BOOL)executeUpdate:(NSString *)sql,... ;

执行更新的SQL语句，可以使用字符串的格式化进行构建SQL语句
- (BOOL)executeUpdateWithFormat:(NSString*)format,... ;

执行更新的SQL语句，字符串中有"?"，依次用arguments的元素替代
- (BOOL)executeUpdate:(NSString*)sql withArgumentsInArray:(NSArray *)arguments;
```


> FMResultSet : 使用FMDatabase执行查询后的结果集。

>> 常用方法
```
查询
- (FMResultSet *)executeQuery:(NSString*)sql, ...
- (FMResultSet *)executeQueryWithFormat:(NSString*)format, ...
- (FMResultSet *)executeQuery:(NSString *)sql withArgumentsInArray:(NSArray *)arguments

FMResultSet获取不同数据格式的方法
获取下一个记录
- (BOOL)next;

获取记录有多少列
- (int)columnCount;

通过列名得到列序号，通过列序号得到列名
- (int)columnIndexForName:(NSString *)columnName;
- (NSString *)columnNameForIndex:(int)columnIdx;

获取存储的整形值
- (int)intForColumn:(NSString *)columnName;
- (int)intForColumnIndex:(int)columnIdx;

获取存储的长整形值
- (long)longForColumn:(NSString *)columnName;
- (long)longForColumnIndex:(int)columnIdx;

获取存储的布尔值
- (BOOL)boolForColumn:(NSString *)columnName;
- (BOOL)boolForColumnIndex:(int)columnIdx;

获取存储的浮点值
- (double)doubleForColumn:(NSString *)columnName;
- (double)doubleForColumnIndex:(int)columnIdx;

获取存储的字符串
- (NSString *)stringForColumn:(NSString *)columnName;
- (NSString *)stringForColumnIndex:(int)columnIdx;

获取存储的日期数据
- (NSDate *)dateForColumn:(NSString *)columnName;
- (NSDate *)dateForColumnIndex:(int)columnIdx;

获取存储的二进制数据
- (NSData *)dataForColumn:(NSString *)columnName;
- (NSData *)dataForColumnIndex:(int)columnIdx;

获取存储的UTF8格式的C语言字符串
- (const unsigned cahr *)UTF8StringForColumnName:(NSString *)columnName;
- (const unsigned cahr *)UTF8StringForColumnIndex:(int)columnIdx;

获取存储的对象，只能是NSNumber、NSString、NSData、NSNull
- (id)objectForColumnName:(NSString *)columnName;
- (id)objectForColumnIndex:(int)columnIdx;
```


> FMDatabaseQueue : 用于在多线程中执行多个查询或更新，它是线程安全的。

```
数据库操作只有多线程
- (void)inDatabase:(void (^)(FMDatabase *db))block;

数据库操作既有多线程又有事务属性 - 推荐
- (void)inTransaction:(void (^)(FMDatabase *db, BOOL *rollback))block;

```
