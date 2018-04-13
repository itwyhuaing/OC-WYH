//
//  XQFOfflineCacheHandler.m
//  A8TV_IPhone
//
//  Created by ggt on 2017/4/10.
//  Copyright © 2017年 New Sense Networks Technology Co., Ltd.. All rights reserved.
//

#import "XQFOfflineCacheHandler.h"
#import "FMDB.h"
#import "XQFHomeNewsVideoHighlightsModel.h"
#import "XQFPostModel.h"
@interface XQFOfflineCacheHandler ()

@property (nonatomic, copy) NSString *tableName; /**< 表名 */
@property (nonatomic, strong) FMDatabaseQueue *dataBaseQueue; /**< FMDB 线程管理 */

@end

@implementation XQFOfflineCacheHandler

singleton_implementation(XQFOfflineCacheHandler)

- (instancetype)init {
    
    if (self = [super init]) {
        
        [self createdDataBase];
    }
    
    return self;
}

#pragma mark - Pulic
- (void)saveHistoryCacheDataWithModel:(id)model type:(XQFOfflineCacheModelType)type {
    
    self.tableName = @"t_HistoryCache";
    NSString *sqlString = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (newsID TEXT PRIMARY KEY , newsData blob , type INTEGER);", self.tableName];
    NSString *currentTimeString = [self getTimeStamp];
    NSData *data;
    NSString * nid;
    if (type == XQFOfflineCacheModelTypeNewsAndVideos) {
        NewsDataEntity * newsModel = (NewsDataEntity *)model;
        newsModel.historyCacheTime = currentTimeString;
        nid = newsModel.nid;
        NSDictionary * dict = [newsModel dictionaryValue];
        data = [NSKeyedArchiver archivedDataWithRootObject:dict];
    } else if (type == XQFOfflineCacheModelTypePosts) {
        XQFPostModel * postModel = (XQFPostModel *)model;
        postModel.historyCacheTime = currentTimeString;
        nid = [NSString stringWithFormat:@"%@&",postModel.postID];
        NSDictionary * dict = [postModel dictionaryValue];
        data = [NSKeyedArchiver archivedDataWithRootObject:dict];
    } else {
        XQFHomeNewsVideoHighlightsModel * videoModel = (XQFHomeNewsVideoHighlightsModel *)model;
        videoModel.historyCacheTime = currentTimeString;
        nid = videoModel.sGameId;
        NSDictionary * dict = [videoModel modelToDictionary];
        data = [NSKeyedArchiver archivedDataWithRootObject:dict];
    }
    
    [self.dataBaseQueue inDatabase:^(FMDatabase *db) {
        BOOL createdTableResult = [db executeUpdate:sqlString];
        if (createdTableResult) {
            NSString *sqlString = [NSString stringWithFormat:@"insert into %@ ( newsID, newsData, type) values (?, ?, ?)", self.tableName];
            if ([db executeUpdate:sqlString withArgumentsInArray:@[nid, data,@(type)]]) {
                NSLog(@"插入成功");
            }
        }
    }];
    
}
- (void)readHistoryHistoryCacheDataWithComplete:(void (^)(NSArray *array))complete {
    self.tableName = @"t_HistoryCache";
    NSString *sqlString = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (newsID TEXT PRIMARY KEY , newsData blob, type INTEGER);", self.tableName];
    //    获取时间戳
    NSString *currentTimeString = [self getTimeStamp];
    [self.dataBaseQueue inDatabase:^(FMDatabase *db) {
        BOOL createdTableResult = [db executeUpdate:sqlString];
        if (createdTableResult) {
            NSString *sqlString = [NSString stringWithFormat:@"SELECT * FROM %@;", self.tableName];
            FMResultSet *set = [db executeQuery:sqlString];
            NSMutableArray *modelArray = [NSMutableArray array];
            
            while (set.next) {
                int type = [[set objectForColumnName:@"type"] intValue];
                NSData * dictData = [set objectForColumnName:@"newsData"];
                NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:dictData];
                if (type == XQFOfflineCacheModelTypeNewsAndVideos) {
                    NewsDataEntity * cache = [MTLJSONAdapter modelOfClass:[NewsDataEntity class] fromJSONDictionary:dict error:nil];
                    cache.videoDescription = dict[@"videoDescription"];
                    cache.newsfeaturesId = dict[@"newsfeaturesId"];
                    cache.newsfeaturesTitle = dict[@"newsfeaturesTitle"];
                    cache.newsfeaturesDesc = dict[@"newsfeaturesDesc"];
                    cache.newsfeaturesLogoUrl = dict[@"newsfeaturesLogoUrl"];
                    cache.featuresId = dict[@"featuresId"];
                    cache.featuresSubtitle = dict[@"featuresSubtitle"];
                    cache.featuresTitle = dict[@"featuresTitle"];
                    cache.featuresDesc = dict[@"featuresDesc"];
                    cache.featuresLogoUrl = dict[@"featuresLogoUrl"];
                    cache.webURL = dict[@"webURL"];
                    cache.imageURL = dict[@"imageURL"];
                    cache.nid = dict[@"nid"];
                    cache.imagesURL = dict[@"imagesURL"];
                    cache.videoURL = dict[@"videoURL"];
                    cache.photos = dict[@"photos"];
                    
                    if ([currentTimeString isEqualToString:cache.historyCacheTime]) {
                        cache.historyCacheTime = @"今天";
                    }
                    [modelArray insertObject:cache atIndex:0];
                }else if (type == XQFOfflineCacheModelTypePosts) {
                    XQFPostModel * cache = [[XQFPostModel alloc]initWithDictionary:dict];
                    if ([currentTimeString isEqualToString:cache.historyCacheTime]) {
                        cache.historyCacheTime = @"今天";
                    }
                    
                    [modelArray insertObject:cache atIndex:0];
                } else {
                    XQFHomeNewsVideoHighlightsModel * cache = [[XQFHomeNewsVideoHighlightsModel alloc]initWithDictionary:dict type:XQFHomeNewsVideoHighlightsTypeHot];
                    if ([currentTimeString isEqualToString:cache.historyCacheTime]) {
                        cache.historyCacheTime = @"今天";
                    }
                    [modelArray insertObject:cache atIndex:0];
                }
                
            }
            
            if (complete) {
                complete(modelArray);
            }
        }
    }];
}

- (void)deletedHistoryCacheData {
    
    self.tableName = @"t_HistoryCache";
    NSString *sqlString = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (newsID TEXT , newsData blob, type INTEGER);", self.tableName];
    [self.dataBaseQueue inDatabase:^(FMDatabase *db) {
        BOOL createdTableResult = [db executeUpdate:sqlString];
        if (createdTableResult) {
            NSString *sqlString = [NSString stringWithFormat:@"DELETE FROM %@;", self.tableName];
            [db executeUpdate:sqlString];
        }
    }];
}


- (void)saveDataWithDictionary:(NSDictionary *)dict {
    
    // 创建表格
    self.tableName = [self getTableNameWithDictionary:dict];
    NSString *sqlString = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (ID INTEGER PRIMARY KEY AUTOINCREMENT, cacheTitle TEXT, data blob);", self.tableName];
    [self.dataBaseQueue inDatabase:^(FMDatabase *db) {
        BOOL createdTableResult = [db executeUpdate:sqlString];
        if (createdTableResult) {
            NSArray *dictArray = [[dict allValues] firstObject];
            NSString *cacheTitle = [[dict allKeys] firstObject];
            NSString *sqlString = [NSString stringWithFormat:@"insert into %@ (cacheTitle, data) values (?, ?)", self.tableName];
            for (NSDictionary *dict in dictArray) {
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
                if ([db executeUpdate:sqlString withArgumentsInArray:@[cacheTitle, data]]) {
                    NSLog(@" %@表单 插入数据成功",self.tableName);
                }
            }
        }
    }];
}

- (void)readDataWithCacheTitle:(NSString *)cacheTitle complete:(void (^)(NSArray *array))complete {
    
    NSLog(@"isMainThread = %d", [NSThread isMainThread]);
    self.tableName = [self getTableNameWithDictionary:@{cacheTitle : @""}];
    NSString *sqlString = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (ID INTEGER PRIMARY KEY AUTOINCREMENT, cacheTitle TEXT, data blob);", self.tableName];
    [self.dataBaseQueue inDatabase:^(FMDatabase *db) {
        BOOL createdTableResult = [db executeUpdate:sqlString];
        if (createdTableResult) {
            NSString *sqlString = [NSString stringWithFormat:@"SELECT * FROM %@;", self.tableName];
            FMResultSet *set = [db executeQuery:sqlString];
            NSMutableArray *dictArray = [NSMutableArray array];
            while (set.next) {
                NSData *data = [set objectForColumnName:@"data"];
                NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                [dictArray addObject:dict];
            }
            
            if (complete) {
                complete(dictArray);
            }
        }
    }];
}

- (void)deletedDataWithCacheTitle:(NSString *)cacheTitle {
    
    self.tableName = [self getTableNameWithDictionary:@{cacheTitle : @""}];
    NSString *sqlString = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (ID INTEGER PRIMARY KEY AUTOINCREMENT, cacheTitle TEXT, data blob);", self.tableName];
    [self.dataBaseQueue inDatabase:^(FMDatabase *db) {
        BOOL createdTableResult = [db executeUpdate:sqlString];
        if (createdTableResult) {
            NSString *sqlString = [NSString stringWithFormat:@"DELETE FROM %@;", self.tableName];
            [db executeUpdate:sqlString];
        }
    }];
}

//点赞历史
- (void)saveLikedPostWithPostID:(NSString *)postID {
    self.tableName = @"t_likedPost";
    NSString *sqlString = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (ID INTEGER PRIMARY KEY AUTOINCREMENT, postID TEXT);", self.tableName];
    [self.dataBaseQueue inDatabase:^(FMDatabase *db) {
        BOOL createdTableResult = [db executeUpdate:sqlString];
        if (createdTableResult) {
            NSString *sqlString = [NSString stringWithFormat:@"insert into %@ (postID) values ( ?)", self.tableName];
            if ([db executeUpdate:sqlString withArgumentsInArray:@[postID]]) {
                NSLog(@"插入成功");
            }
        }
    }];
}

- (void)readLikedPostWithComplete:(void (^)(NSArray *))complete {
    self.tableName = @"t_likedPost";
    NSString *sqlString = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (ID INTEGER PRIMARY KEY AUTOINCREMENT, postID TEXT);", self.tableName];
    [self.dataBaseQueue inDatabase:^(FMDatabase *db) {
        BOOL createdTableResult = [db executeUpdate:sqlString];
        if (createdTableResult) {
            NSString *sqlString = [NSString stringWithFormat:@"SELECT * FROM %@;", self.tableName];
            FMResultSet *set = [db executeQuery:sqlString];
            NSMutableArray *postIDArray = [NSMutableArray array];
            while (set.next) {
                NSString *postID = [set objectForColumnName:@"postID"];
//                NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                [postIDArray addObject:postID];
            }
            
            if (complete) {
                complete(postIDArray);
            }
        }
    }];
}

- (void)deleteLikedPost {
    self.tableName = @"t_likedPost";
    NSString *sqlString = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (ID INTEGER PRIMARY KEY AUTOINCREMENT, postID TEXT);", self.tableName];
    [self.dataBaseQueue inDatabase:^(FMDatabase *db) {
        BOOL createdTableResult = [db executeUpdate:sqlString];
        if (createdTableResult) {
            NSString *sqlString = [NSString stringWithFormat:@"DELETE FROM %@;", self.tableName];
            [db executeUpdate:sqlString];
        }
    }];
}
#pragma mark - Private

/**
 创建数据
 */
- (void)createdDataBase {
    
    NSString *pathString = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"A8Cache.sqlite"];
    
    self.dataBaseQueue = [FMDatabaseQueue databaseQueueWithPath:pathString];
}


/**
 获取表名
 */
- (NSString *)getTableNameWithDictionary:(NSDictionary *)dict {
    
    NSString *title = [[dict allKeys] firstObject];
    NSMutableString *source = [title mutableCopy];
    CFRange range = CFRangeMake(0, title.length);
    CFStringTransform(((__bridge CFMutableStringRef)source), &range, kCFStringTransformMandarinLatin, NO);
    CFStringTransform(((__bridge CFMutableStringRef)source), &range, kCFStringTransformStripDiacritics, NO);
    title = [source stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return title;
}
//获取时间戳
- (NSString *)getTimeStamp {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    return currentTimeString;
}
@end
