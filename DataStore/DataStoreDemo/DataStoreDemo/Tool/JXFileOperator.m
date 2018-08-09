//
//  JXFileOperator.m
//  DataStoreDemo
//
//  Created by hnbwyh on 2018/8/1.
//  Copyright © 2018年 hainbwyh. All rights reserved.
//

#import "JXFileOperator.h"


@interface JXFileOperator ()
@property (nonatomic,strong) NSFileManager              *fileManager;
@property (nonatomic,assign) BOOL                       logStatus;
@end

@implementation JXFileOperator

+ (instancetype)defaultManager{
    static JXFileOperator *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[JXFileOperator alloc] init];
    });
    return instance;
}

- (void)openLog{
    self.logStatus = TRUE;
}

#pragma mark ------ http 网络数据 JSON 存储

+ (BOOL)saveHttpCache:(id)httpData URL:(NSString *)URL parameters:(NSDictionary *)parameters{
    BOOL rlt = FALSE;
    BOOL isSave = [httpData isKindOfClass:[NSDictionary class]];
    if (httpData && isSave) {
        NSString *filePath = [self filePathAtFolderDirectory:JXFileFolderNetHttpCacheResponseData fileName:[self cacheKeyWithURL:URL parameters:parameters]];
        rlt = [httpData writeToFile:filePath atomically:NO];
    }
    return rlt;
}
+ (id)getHttpCacheForURL:(NSString *)URL parameters:(NSDictionary *)parameters{
    NSString *filePath = [self filePathAtFolderDirectory:JXFileFolderNetHttpCacheResponseData fileName:[self cacheKeyWithURL:URL parameters:parameters]];
    return [NSDictionary dictionaryWithContentsOfFile:filePath];
}

#pragma mark - cacheKeyWithURL

+ (NSString *)cacheKeyWithURL:(NSString *)URL parameters:(NSDictionary *)parameters {
    if(!parameters || parameters.count == 0){return URL;};
    // 将参数字典转换成字符串
    NSData *stringData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString *paraString = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
    NSString *cacheKey = [NSString stringWithFormat:@"%@%@",URL,paraString];
    
    return [NSString stringWithFormat:@"%ld",cacheKey.hash];
}

#pragma mark ------ 沙盒读写清空操作

+(BOOL)sandBoxSaveInfo:(id)info forKey:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:info forKey:key];
    BOOL isSaved = [userDefaults synchronize];
    return isSaved;
}

+(id)sandBoxGetInfo:(Class)cls forKey:(NSString *)key{
    NSString *ClsString = NSStringFromClass(cls);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([ClsString isEqualToString:NSStringFromClass([NSString class])]) {
        NSString *str = [userDefaults stringForKey:key];
        return str;
    }else if ([ClsString isEqualToString:NSStringFromClass([NSArray class])]){
        NSArray *arr = [userDefaults arrayForKey:key];
        return arr;
    }else if ([ClsString isEqualToString:NSStringFromClass([NSDictionary class])]){
        NSDictionary *dic = [userDefaults dictionaryForKey:key];
        return dic;
    }else{
        id rls = [userDefaults valueForKey:key];
        return rls;
    }
}
+(void) sandBoxClearAllInfo:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark ------ 常规文件读写清空操作

+ (BOOL)clearFileDataWithCacheKey:(NSString *)key{
    NSString *dataCachePath = [[self netInterfaceDataCachePath] stringByAppendingPathComponent:key];
    return [[NSFileManager defaultManager] removeItemAtPath:dataCachePath error:nil];
}


+(BOOL)saveDataInfo:(id)info forKey:(NSString *)key{
    BOOL rlt = FALSE;
    BOOL isSave = [info isKindOfClass:[NSString class]] ||
                  [info isKindOfClass:[NSArray class]] ||
                  [info isKindOfClass:[NSDictionary class]];
    if (info && isSave) {
        NSString *dataCachePath = [[self netInterfaceDataCachePath] stringByAppendingPathComponent:key];
        rlt = [info isKindOfClass:[NSString class]] ? [info writeToFile:dataCachePath atomically:NO encoding:NSUTF8StringEncoding error:nil] : [info writeToFile:dataCachePath atomically:NO];
    }
    return rlt;
}

+(id)getDataInfo:(Class)cls forKey:(NSString *)key{
    NSString *dataCachePath = [[self netInterfaceDataCachePath] stringByAppendingPathComponent:key];
    if ([cls isSubclassOfClass:[NSString class]]) {
        return [NSString stringWithContentsOfFile:dataCachePath encoding:NSUTF8StringEncoding error:nil];
    }else if([cls isSubclassOfClass:[NSArray class]]){
        return [NSArray arrayWithContentsOfFile:dataCachePath];
    }else if([cls isSubclassOfClass:[NSDictionary class]]){
        return [NSDictionary dictionaryWithContentsOfFile:dataCachePath];
    }else {
        return @"";
    }
    
}

#pragma mark ------ 生成文件路径

+ (NSString *)filePathAtFolderDirectory:(JXFileFolderDirectory)folderDir fileName:(NSString *)fileName{
    NSString *filePath = [self fileFolder:folderDir];
    filePath = [filePath stringByAppendingPathComponent:fileName];
    return filePath;
}

#pragma mark ------ 清空文件夹

+ (BOOL)clearUpFileFolder:(JXFileFolderDirectory)folderDir{
    
    BOOL isClear = TRUE; // 默认值
    switch (folderDir) {
        case JXFileFolderDocuments:
            isClear = [[NSFileManager defaultManager] removeItemAtPath:[self documentPath] error:nil];
            [[self class] printLogMsg:@"JXFileFolderDocuments"];
            break;
        case JXFileFolderLibrary:
            isClear = [[NSFileManager defaultManager] removeItemAtPath:[self libraryPath] error:nil];
            [[self class] printLogMsg:@"JXFileFolderLibrary"];
            break;
        case JXFileFolderCaches:
            isClear = [[NSFileManager defaultManager] removeItemAtPath:[self cachePath] error:nil];
            [[self class] printLogMsg:@"JXFileFolderCaches"];
            break;
        case JXFileFolderSDWebImageCacheDefault:
            isClear = [[NSFileManager defaultManager] removeItemAtPath:[self sdWebImageCacheDefaultPath] error:nil];
            [[self class] printLogMsg:@"JXFileFolderSDWebImageCacheDefault"];
            break;
        case JXFileFolderWKWebKitfsCachedData:
            isClear = [[NSFileManager defaultManager] removeItemAtPath:[self wkWebKitfsCachedDataPath] error:nil];
            [[self class] printLogMsg:@"JXFileFolderWKWebKitfsCachedData"];
            break;
        case JXFileFolderNetInterfaceData:
            isClear = [[NSFileManager defaultManager] removeItemAtPath:[self netInterfaceDataCachePath] error:nil];
            [[self class] printLogMsg:@"JXFileFolderNetInterfaceData"];
            break;
        case JXFileFolderNetHttpCacheResponseData:
            isClear = [[NSFileManager defaultManager] removeItemAtPath:[self netHttpDataCacheResponsePath] error:nil];
            [[self class] printLogMsg:@"JXFileFolderNetHttpCacheResponseData"];
            break;
        case JXFileFolderTmp:
            isClear = [[NSFileManager defaultManager] removeItemAtPath:[self tmpPath] error:nil];
            [[self class] printLogMsg:@"JXFileFolderTmp"];
            break;
        case JXFileFolderLibUIWebKit:
            isClear = [[NSFileManager defaultManager] removeItemAtPath:[self libUIWebKitPath] error:nil];
            [[self class] printLogMsg:@"JXFileFolderTmp"];
            break;
        case JXFileFoldersSet:
            isClear = [[NSFileManager defaultManager] removeItemAtPath:[self netInterfaceDataCachePath] error:nil] &&
            [[NSFileManager defaultManager] removeItemAtPath:[self sdWebImageCacheDefaultPath] error:nil] &&
            [[NSFileManager defaultManager] removeItemAtPath:[self wkWebKitfsCachedDataPath] error:nil] &&
            [[NSFileManager defaultManager] removeItemAtPath:[self wkWebKitCachePath] error:nil] &&
            [[NSFileManager defaultManager] removeItemAtPath:[self libUIWebKitPath] error:nil] &&
            [[NSFileManager defaultManager] removeItemAtPath:[self netHttpDataCacheResponsePath] error:nil];
            [[self class] printLogMsg:@"JXFileFoldersSet"];
            break;
        default:
            break;
    }
    return isClear;
}

#pragma mark ------ folder size

+ (void)returnSizeAtFileFolder:(JXFileFolderDirectory)folderDir completeBlock:(JXFileOperatorBlock)fileBlock{
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globalQueue, ^{
        NSString *TMPString = [self returnSizeAtFileFolder:folderDir];
        dispatch_async(dispatch_get_main_queue(), ^{
            fileBlock(TMPString);
        });
    });
}


// 私有方法 - 计算1
+ (NSString *)returnSizeAtFileFolder:(JXFileFolderDirectory)folderDir {
    CGFloat folderSize = 0.00; // 默认值
    switch (folderDir) {
            case JXFileFolderDocuments:
            folderSize += [self caculateSizeAtSingleFolder:[self documentPath]];
            [[self class] printLogMsg:@"JXFileFolderDocuments"];
            break;
            case JXFileFolderLibrary:
            folderSize += [self caculateSizeAtSingleFolder:[self libraryPath]];
            [[self class] printLogMsg:@"JXFileFolderLibrary"];
            break;
            case JXFileFolderCaches:
            folderSize += [self caculateSizeAtSingleFolder:[self cachePath]];
            [[self class] printLogMsg:@"JXFileFolderCaches"];
            break;
            case JXFileFolderSDWebImageCacheDefault:
            folderSize += [self caculateSizeAtSingleFolder:[self sdWebImageCacheDefaultPath]];
            [[self class] printLogMsg:@"JXFileFolderSDWebImageCacheDefault"];
            break;
            case JXFileFolderWKWebKitfsCachedData:
            folderSize += [self caculateSizeAtSingleFolder:[self wkWebKitfsCachedDataPath]];
            [[self class] printLogMsg:@"JXFileFolderWKWebKitfsCachedData"];
            break;
            case JXFileFolderNetInterfaceData:
            folderSize += [self caculateSizeAtSingleFolder:[self netInterfaceDataCachePath]];
            [[self class] printLogMsg:@"JXFileFolderNetInterfaceData"];
            break;
            case JXFileFolderNetHttpCacheResponseData:
            folderSize += [self caculateSizeAtSingleFolder:[self netHttpDataCacheResponsePath]];
            [[self class] printLogMsg:@"JXFileFolderNetHttpCacheResponseData"];
            break;
            case JXFileFolderTmp:
            folderSize += [self caculateSizeAtSingleFolder:[self tmpPath]];
            [[self class] printLogMsg:@"JXFileFolderTmp"];
            break;
            case JXFileFolderLibUIWebKit:
            folderSize += [self caculateSizeAtSingleFolder:[self libUIWebKitPath]];
            [[self class] printLogMsg:@"JXFileFolderTmp"];
            break;
            case JXFileFoldersSet:
            folderSize += [self caculateSizeAtSingleFolder:[self netInterfaceDataCachePath]];
            folderSize += [self caculateSizeAtSingleFolder:[self sdWebImageCacheDefaultPath]];
            folderSize += [self caculateSizeAtSingleFolder:[self wkWebKitfsCachedDataPath]];
            folderSize += [self caculateSizeAtSingleFolder:[self wkWebKitCachePath]];
            folderSize += [self caculateSizeAtSingleFolder:[self libUIWebKitPath]];
            folderSize += [self caculateSizeAtSingleFolder:[self netHttpDataCacheResponsePath]];
            [[self class] printLogMsg:@"JXFileFoldersSet"];
            break;
        default:
            break;
    }
    
    if (folderSize/(1024 * 1024) < 0.01) {
        return @"0.00 MB";
    }
    return [NSString stringWithFormat:@"%.2f MB",folderSize/(1024 * 1024)];
    
}

// 私有方法 - 计算2 - 单个文件夹大小
+ (CGFloat)caculateSizeAtSingleFolder:(NSString *)folderPath{
    
    CGFloat folderSize = 0.0;
    if ([[NSFileManager defaultManager] fileExistsAtPath:folderPath]){
        NSEnumerator *childFilesEnumertor = [[[NSFileManager defaultManager] subpathsAtPath:folderPath] objectEnumerator];
        NSString *fileName = nil;
        while ((fileName = [childFilesEnumertor nextObject]) != nil) {
            NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
            folderSize += [[[NSFileManager defaultManager] attributesOfItemAtPath:fileAbsolutePath error:nil] fileSize];
        }
    }
    return folderSize;
    
}


#pragma mark ------ 私有方法

#pragma mark  删除某一路径下的文件

- (void)deleteSubFilesForPath:(NSString *)path{
    NSArray *subFilePaths = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    for (NSString *subPath in subFilePaths) {
        [[self class] printLogMsg:[NSString stringWithFormat:@"subPath:%@",subPath]];
    }
}

#pragma mark  获取 bundleID

+ (NSString *)bundleid{
    
    NSString *bundleId  =  [[[NSBundle mainBundle] infoDictionary]
                            objectForKey:@"CFBundleIdentifier"];
    
    return bundleId;
}


#pragma mark  获取文件路径

// 默认 JXFileFolderDocuments
+ (NSString *)fileFolder:(JXFileFolderDirectory)folderDir{
    NSString *rlt = [self documentPath];
    switch (folderDir) {
        case JXFileFolderDocuments:
            rlt = [self documentPath];
            break;
        case JXFileFolderLibrary:
            rlt = [self libraryPath];
            break;
        case JXFileFolderCaches:
            rlt = [self cachePath];
            break;
        case JXFileFolderSDWebImageCacheDefault:
            rlt = [self sdWebImageCacheDefaultPath];
            break;
        case JXFileFolderWKWebKitfsCachedData:
            rlt = [self wkWebKitfsCachedDataPath];
            break;
        case JXFileFolderNetInterfaceData:
            rlt = [self netInterfaceDataCachePath];
            break;
        case JXFileFolderNetHttpCacheResponseData:
            rlt = [self netHttpDataCacheResponsePath];
            break;
        case JXFileFolderTmp:
            rlt = [self tmpPath];
            break;
        case JXFileFolderLibUIWebKit:
            rlt = [self libUIWebKitPath];
            break;
        case JXFileFolderWKWebKitCachedData:
            rlt = [self wkWebKitCachePath];
            break;
        case JXFileFoldersSet:
            break;
    }
    [[self class] printLogMsg:[NSString stringWithFormat:@"fileFolder:%@",rlt]];
    return rlt;
    
}


// Documents
+ (NSString *)documentPath{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

// Tmp
+ (NSString *)tmpPath{
    return nil;
}

// Library
+ (NSString *)libraryPath{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
}

// Library/WebKit
+ (NSString *)libUIWebKitPath{
    return [[self libraryPath] stringByAppendingPathComponent:@"WebKit"];
}

// Library/Caches
+ (NSString *)cachePath{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
}

// Library/Caches/netInterfaceData
+ (NSString *)netInterfaceDataCachePath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *dataCachePath = [[self cachePath] stringByAppendingPathComponent:kJXNetInterfaceData];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataCachePath]) {
        [fileManager createDirectoryAtPath:dataCachePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return dataCachePath;
}

// Library/Caches/kJXNetDataCacheResponse
+ (NSString *)netHttpDataCacheResponsePath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *dataCachePath = [[self cachePath] stringByAppendingPathComponent:kJXNetDataCacheResponse];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataCachePath]) {
        [fileManager createDirectoryAtPath:dataCachePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return dataCachePath;
}

// Library/Caches/default  (SDWebImageCache 图片)
+ (NSString *)sdWebImageCacheDefaultPath{
    return [[self cachePath] stringByAppendingPathComponent:@"default"];
}

// Library/Caches/(bundleid)/fsCachedData  (iOS8 之后WKWebkit , H5 页面自带缓存)
+ (NSString *)wkWebKitfsCachedDataPath{
    return [NSString stringWithFormat:@"%@/%@/fsCachedData",[self cachePath],[self bundleid]];
}

// Library/Caches/(bundleid)/WebKit  (iOS8 之后WKWebkit , H5 页面自带缓存)
+ (NSString *)wkWebKitCachePath{
    return [NSString stringWithFormat:@"%@/%@/WebKit",[self cachePath],[self bundleid]];
}

- (void)printLogMsg:(NSString *)msg{
    self.logStatus ? NSLog(@"\n%@\n",msg) : nil;
}

@end
