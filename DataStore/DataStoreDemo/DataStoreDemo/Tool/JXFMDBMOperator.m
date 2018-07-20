//
//  JXFMDBMOperator.m
//  DataStoreDemo
//
//  Created by hnbwyh on 2018/7/20.
//  Copyright © 2018年 hainbwyh. All rights reserved.
//

#import "JXFMDBMOperator.h"
#import <objc/runtime.h>
#import "FMDB.h"


@implementation JXDataModelParser

/**
 NSString       - text
 NSInteger      - integer
 CGFloat        - float
 
 */
-(NSString *)sqlForTableKeyWithModelCls:(Class)modelCls{
    NSMutableString *rltSql = [NSMutableString new];
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList(modelCls, &count);
    for (NSInteger index = 0; index < count; index ++) {
        Ivar ivar = ivars[index];
        const char *keyName = ivar_getName(ivar);
        const char *type = ivar_getTypeEncoding(ivar);
        NSString *typeString = [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
        NSString *keyNameString = [NSString stringWithCString:keyName encoding:NSUTF8StringEncoding];
        NSLog(@"\n \n key :%@ \n type:%@\n \n",keyNameString,typeString);
    }
    
    return rltSql;
}

@end


@interface JXFMDBMOperator ()
{
    BOOL isLog;
}
@property (nonatomic,strong) FMDatabase                     *dataBase;

@property (nonatomic,strong) JXDataModelParser              *modelParser;

@end

@implementation JXFMDBMOperator

+(instancetype)sharedInstance{
    static JXFMDBMOperator *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[JXFMDBMOperator alloc] init];
    });
    return instance;
}

- (void)openLog{
    isLog = TRUE;
}

#pragma mark - 删除数据库

- (BOOL)deleteDataBaseWithFileName:(NSString *)fileName{
    BOOL rlt = TRUE;
    NSString *filePath = [self filePathWithFileName:fileName];
    rlt = [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    rlt ? [self printLogMsg:[NSString stringWithFormat:@"数据库删除成功，地址：%@",filePath]] : [self printLogMsg:[NSString stringWithFormat:@"数据库删除失败，地址：%@",filePath]];
    return rlt;
}

#pragma mark - 新建数据库

- (BOOL)createDataBaseWithFileName:(NSString *)fileName modelCls:(Class)modelCls{
    BOOL rlt = TRUE;
    NSString *filePath = [self filePathWithFileName:fileName];
    _dataBase = [[FMDatabase alloc] initWithPath:filePath];
    rlt = [_dataBase open] ? [self createDataBaseWithFileName:filePath modelCls:modelCls] : FALSE;
    rlt ? [self printLogMsg:[NSString stringWithFormat:@"数据库新建成功并打开，地址：%@",filePath]] : [self printLogMsg:[NSString stringWithFormat:@"数据库新建失败，地址：%@",filePath]];
    return rlt;
}

#pragma mark - 打开数据库

#pragma mark ------ private method

#pragma mark - 存储路径
- (NSString *)filePathWithFileName:(NSString *)fileName{
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:fileName];
    [self printLogMsg:[NSString stringWithFormat:@"数据库存储路径：%@",filePath]];
    return filePath;
    
}

#pragma mark - 建表
-(BOOL)createTableWithModelCls:(Class)modelCls{
    /*
     NSString *sql = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement,title text,imgurlstr text)",NSStringFromClass(modelCls)];
     */
    NSString *sql = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement,%@)",NSStringFromClass(modelCls),[self sqlWithTableModelCls:modelCls]];
    return [_dataBase executeUpdate:sql];
}

#pragma mark - 表模型解析

- (NSString *)sqlWithTableModelCls:(Class)modelCls{
    NSString *rltSql = nil;
    
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList(modelCls, &count);
    for (NSInteger index = 0; index < count; index ++) {
        Ivar ivar = ivars[index];
        const char *keyName = ivar_getName(ivar);
        const char *type = ivar_getTypeEncoding(ivar);
        NSString *typeString = [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
        NSString *keyNameString = [NSString stringWithCString:keyName encoding:NSUTF8StringEncoding];
        NSLog(@"\n \n key :%@ \n type:%@\n \n",keyNameString,typeString);
    }
    
    return rltSql;
}

#pragma mark - log
- (void)printLogMsg:(NSString *)msg{
    isLog ? NSLog(@"\n %@ \n",msg) : nil;
}

#pragma mark - lazy load
-(JXDataModelParser *)modelParser{
    if(!_modelParser){
        _modelParser = [[JXDataModelParser alloc] init];
    }
    return _modelParser;
}


@end
