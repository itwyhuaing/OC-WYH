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
 ---------------------------------------------------------- runtime 解析出 type
 key :_name
 type:@"NSString"
 
 key :_boolTest
 type:B
 
 key :_age
 type:q
 
 key :_ageTest
 type:Q
 
 key :_intTest
 type:i
 
 key :_floatTest
 type:f
 
 key :_mark
 type:d
 
 key :_markTest
 type:d
 
 key :_subs
 type:@"NSArray"
 
 key :_classRoom
 type:@"NSDictionary"
 
 key :_son
 type:@"Son"
 
 key :_name
 type:@"NSString"
 
 ---------------------------------------------------------- OC 类型 与 sqlite 中类型间的映射
 
 NSString
 - text
 
 NSInteger
 - integer
 
 CGFloat
 - real
 
 NSArray/NSDictionary
 -
 
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
        NSString *sqlKey = [keyNameString substringFromIndex:1];
        [rltSql appendString:[NSString stringWithFormat:@" %@ %@",sqlKey,[self sqlMapWithType:typeString]]];
        NSLog(@"\n \n key :%@ \n type:%@ \n sqlKey :%@ \n \n",keyNameString,typeString,sqlKey);
    }
    [rltSql appendString:@");"];
    NSLog(@"\n\n rltSql :%@\n\n",rltSql);
    return rltSql;
}

- (NSString *)sqlMapWithType:(NSString *)type{
    NSString *rlt = @"blob";
    if ([type rangeOfString:@"NSString"].location != NSNotFound) {
        rlt = @"text";
    }else if ([type isEqualToString:@"B"] || [type isEqualToString:@"i"]
              || [type isEqualToString:@"q"] || [type isEqualToString:@"Q"]) {
        rlt = @"integer";
    }else if ([type isEqualToString:@"f"] || [type isEqualToString:@"d"]) {
        rlt = @"real";
    }
    return rlt;
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

- (BOOL)createDataBaseWithFileName:(NSString *)fileName{
    BOOL rlt = TRUE;
    NSString *filePath = [self filePathWithFileName:fileName];
    _dataBase = [[FMDatabase alloc] initWithPath:filePath];
    rlt = [_dataBase open] ? TRUE : FALSE;
    rlt ? [self printLogMsg:[NSString stringWithFormat:@"数据库新建成功并打开，地址：%@",filePath]] : [self printLogMsg:[NSString stringWithFormat:@"数据库新建失败，地址：%@",filePath]];
    return rlt;
}

#pragma mark - 建表
-(BOOL)createTableWithModelCls:(Class)modelCls{
    NSString *sql = [NSString stringWithFormat:@"create table if not exists %@ (customId integer primary key autoincrement,%@)",NSStringFromClass(modelCls),[self.modelParser sqlForTableKeyWithModelCls:modelCls]];
    BOOL rlt = [_dataBase executeUpdate:sql];
    rlt ? [self printLogMsg:[NSString stringWithFormat:@"表%@创建成功",NSStringFromClass(modelCls)]] : [self printLogMsg:[NSString stringWithFormat:@"表%@创建失败",NSStringFromClass(modelCls)]];
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

- (void)testMethod:(id)modelCls{
    [self createTableWithModelCls:modelCls];
}

@end
