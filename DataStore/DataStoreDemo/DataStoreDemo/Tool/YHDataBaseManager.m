//
//  YHDataBaseManager.m
//  DataBase
//
//  Created by hnbwyh on 17/6/13.
//  Copyright © 2017年 vera. All rights reserved.
//

#import "YHDataBaseManager.h"
#import "FMDB.h"
#import "Movie.h"

@interface YHDataBaseManager ()

@property (nonatomic,strong) FMDatabase *dataBase;

@end

@implementation YHDataBaseManager


#pragma mark ------ private method

+(instancetype)sharedManager{
    
    static YHDataBaseManager *instace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instace = [[YHDataBaseManager alloc] init];
    });
    return instace;
}

- (BOOL)createDataBaseWithFileName:(NSString *)fileName{
    _dataBase = [FMDatabase databaseWithPath:[self filePathWithFileName:fileName]];
    BOOL isOpen = [_dataBase open];
    NSLog(@" 数据库打开状态 isOpen: %d",isOpen);
    if (isOpen) {
        [self createTable];
        return YES;
    }else{
        return  NO;
    }
}

-(BOOL)deleteDataBaseWithFileName:(NSString *)fileName{
    NSString *filePath = [self filePathWithFileName:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager removeItemAtPath:filePath error:nil];
}

-(void)createTable{
    NSString *sql = @"create table if not exists Movie (id integer primary key autoincrement,title text,imgurlstr text)";
    [_dataBase executeUpdate:sql];
}

- (NSString *)filePathWithFileName:(NSString *)fileName{

    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:fileName];
    return filePath;

}

#pragma mark ------ database operate

-(BOOL)insertDataToDatabase:(Movie *)movie{

    NSString *sql = @"insert into Movie (title,imgurlstr) values (?,?)";
    return [_dataBase executeUpdate:sql,movie.name,movie.imageUrlString];
    
}

- (BOOL)deleteDataFromDatabaseWhere:(NSString *)where{
    
    NSString *sql = [NSString stringWithFormat:@"delete from Movie where %@",where];
    return [_dataBase executeUpdate:sql];
    
}

- (BOOL)updateValue:(NSString *)value atKey:(NSString *)key where:(NSString *)where{

    NSString *sql = [NSString stringWithFormat:@"update Movie set %@='%@' where %@",key,value,where];
    NSLog(@" %s - %@",__FUNCTION__,sql);
    return [_dataBase executeUpdate:sql];
    
}

-(NSArray *)selectValue:(NSString *)value atKey:(NSString *)key{
    NSString *sql = [NSString stringWithFormat:@"select %@ from Movie where %@=%@",key,key,value];
    NSMutableArray *rslData = [[NSMutableArray alloc] init];
    FMResultSet *rsl = [_dataBase executeQuery:sql];
    while (rsl.next) {
        Movie *f = [[Movie alloc] init];
        f.name = [rsl stringForColumn:@"title"];
        f.imageUrlString = [rsl stringForColumn:@"imgurlstr"];
        [rslData addObject:f];
    }
    return rslData;
}

-(BOOL)clearDataFromTable:(NSString *)table{
    
    NSString *sql = [NSString stringWithFormat:@"delete from %@",table];
    return [_dataBase executeUpdate:sql];
    
}

- (NSArray *)getAllDataFromDatabase{

    NSString *sql = @"select * from Movie";
    NSMutableArray *rslData = [[NSMutableArray alloc] init];
    FMResultSet *rsl = [_dataBase executeQuery:sql];
    while (rsl.next) {
        Movie *f = [[Movie alloc] init];
        f.name = [rsl stringForColumn:@"title"];
        f.imageUrlString = [rsl stringForColumn:@"imgurlstr"];
        [rslData addObject:f];
    }
    return rslData;
    
}


/*
 
 NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory directory, NSSearchPathDomainMask domainMask, BOOL expandTilde)
 返回值：
    方法用于查找目录，返回指定范围内的指定名称的目录的路径集合。
 参数：
    directory NSSearchPathDirectory类型的enum值，表明我们要搜索的目录名称，比如这里用NSDocumentDirectory表明我们要搜索的是Documents目录。如果我们将其换成NSCachesDirectory就表示我们搜索的是Library/Caches目录。
    domainMask NSSearchPathDomainMask类型的enum值，指定搜索范围，这里的NSUserDomainMask表示搜索的范围限制于当前应用的沙盒目录。还可以写成NSLocalDomainMask（表示/Library）、NSNetworkDomainMask（表示/Network）等。
    expandTilde BOOL值，表示是否展开波浪线~。我们知道在iOS中~的全写形式是/User/userName，该值为YES即表示写成全写形式，为NO就表示直接写成“~”。
 */

@end
