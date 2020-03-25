//
//  HNBFileManager.m
//  hinabian
//
//  Created by hnbwyh on 17/7/11.
//  Copyright © 2017年 &#20313;&#22362;. All rights reserved.
//

#import "HNBFileManager.h"

@interface HNBFileManager ()
@property (nonatomic,strong) NSFileManager *fileManager;
@end

@implementation HNBFileManager

#pragma mark ------ 基本数据类型存取

+ (BOOL)clearFileDataWithCacheKey:(NSString *)key{
    NSString *dataCachePath = [[self netInterfaceDataCachePath] stringByAppendingPathComponent:key];
    return [[NSFileManager defaultManager] removeItemAtPath:dataCachePath error:nil];
}

+ (BOOL)writeStringAPPNetInterfaceData:(NSString *)str cacheKey:(NSString *)key{
    NSString *dataCachePath = [[self netInterfaceDataCachePath] stringByAppendingPathComponent:key];
    return [str writeToFile:dataCachePath atomically:NO encoding:NSUTF8StringEncoding error:nil];
}

+ (NSString *)readStringAPPNetInterfaceDataWithCacheKey:(NSString *)key{
    NSString *dataCachePath = [[self netInterfaceDataCachePath] stringByAppendingPathComponent:key];
    return [NSString stringWithContentsOfFile:dataCachePath encoding:NSUTF8StringEncoding error:nil];
}

+ (BOOL)writeArrAPPNetInterfaceData:(NSArray *)data cacheKey:(NSString *)key{
    NSString *dataCachePath = [[self netInterfaceDataCachePath] stringByAppendingPathComponent:key];
    return [data writeToFile:dataCachePath atomically:NO];
}

+ (NSArray *)readArrAPPNetInterfaceDataWithCacheKey:(NSString *)key{
    NSString *dataCachePath = [[self netInterfaceDataCachePath] stringByAppendingPathComponent:key];
    return [NSArray arrayWithContentsOfFile:dataCachePath];
}

+ (BOOL)writeDicAPPNetInterfaceData:(NSDictionary *)data cacheKey:(NSString *)key{
    NSString *dataCachePath = [[self netInterfaceDataCachePath] stringByAppendingPathComponent:key];
    return [data writeToFile:dataCachePath atomically:NO];
}

+ (NSDictionary *)readDicAPPNetInterfaceDataWithCacheKey:(NSString *)key{
    NSString *dataCachePath = [[self netInterfaceDataCachePath] stringByAppendingPathComponent:key];
    return [NSDictionary dictionaryWithContentsOfFile:dataCachePath];
}

+ (BOOL)writeImageAPPNetInterfaceData:(NSData *)data cacheKey:(NSString *)key{
    //设置一个图片的存储路径
    //NSString *imagePath = [path_sandox stringByAppendingString:@"/Library/Caches/pic_splash.png"];
    NSString *dataCachePath = [[self netInterfaceDataCachePath] stringByAppendingPathComponent:key];
    return [data writeToFile:dataCachePath atomically:YES];
}

+ (UIImage *)readImageAPPNetInterfaceDataWithCacheKey:(NSString *)key{
    NSString *dataCachePath = [[self netInterfaceDataCachePath] stringByAppendingPathComponent:key];
    return [UIImage imageWithContentsOfFile:dataCachePath];
}

#pragma mark ------ folder size

+ (void)returnSizeAtFileFolder:(HNBFileFolderDirectory)folderDir completeBlock:(HNBFileManagerBlock)fileBlock{
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globalQueue, ^{
        NSString *TMPString = [self returnSizeAtFileFolder:folderDir];
        //NSLog(@" 11 --- > %@",[NSThread currentThread]);
        dispatch_async(dispatch_get_main_queue(), ^{
            //NSLog(@" 22 --- > %@",[NSThread currentThread]);
            fileBlock(TMPString);
        });
        
    });
    
}


// 私有方法 - 计算1
+ (NSString *)returnSizeAtFileFolder:(HNBFileFolderDirectory)folderDir{
    
    CGFloat folderSize = 0.00; // 默认值
    switch (folderDir) {
        case HNBFileFolderDocuments:
            folderSize += [self caculateSizeAtSingleFolder:[self documentPath]];
            NSLog(@"HNBFileFolderDocuments");
            break;
        case HNBFileFolderLibrary:
            folderSize += [self caculateSizeAtSingleFolder:[self libraryPath]];
            NSLog(@"HNBFileFolderLibrary");
            break;
        case HNBFileFolderCaches:
            folderSize += [self caculateSizeAtSingleFolder:[self cachePath]];
            NSLog(@"HNBFileFolderCaches");
            break;
        case HNBFileFolderSDWebImageCacheDefault:
            folderSize += [self caculateSizeAtSingleFolder:[self sdWebImageCacheDefaultPath]];
            NSLog(@"HNBFileFolderSDWebImageCacheDefault");
            break;
        case HNBFileFolderWKWebKitfsCachedData:
            folderSize += [self caculateSizeAtSingleFolder:[self wkWebKitfsCachedDataPath]];
            NSLog(@"HNBFileFolderWKWebKitfsCachedData");
            break;
        case HNBFileFolderNetInterfaceData:
            folderSize += [self caculateSizeAtSingleFolder:[self netInterfaceDataCachePath]];
            NSLog(@"HNBFileFolderNetInterfaceData");
            break;
        case HNBFileFolderTmp:
            folderSize += [self caculateSizeAtSingleFolder:[self tmpPath]];
            NSLog(@"HNBFileFolderTmp");
            break;
        case HNBFileFolderLibUIWebKit:
            folderSize += [self caculateSizeAtSingleFolder:[self libUIWebKitPath]];
            NSLog(@"HNBFileFolderTmp");
            break;
        case HNBFileFoldersSet:
            folderSize += [self caculateSizeAtSingleFolder:[self netInterfaceDataCachePath]];
            folderSize += [self caculateSizeAtSingleFolder:[self sdWebImageCacheDefaultPath]];
            folderSize += [self caculateSizeAtSingleFolder:[self wkWebKitfsCachedDataPath]];
            folderSize += [self caculateSizeAtSingleFolder:[self libUIWebKitPath]];
            NSLog(@"HNBFileFoldersSet");
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
            //NSLog(@" 文件：%@ < ====== > 大小 ：%llu",fileAbsolutePath,[[[NSFileManager defaultManager] attributesOfItemAtPath:fileAbsolutePath error:nil] fileSize]);
        }
        //NSLog(@"文件件大小：%f ---- 换算：%f",folderSize,folderSize/(1024 * 1024));
    }
    return folderSize;
    
}


#pragma mark ------ 私有方法 生成文件夹
// Library/Caches/netInterfaceData
+ (NSString *)createNetInterfaceDataCachePath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *dataCachePath = [[self cachePath] stringByAppendingPathComponent:@"netInterfaceData"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataCachePath]) {
        [fileManager createDirectoryAtPath:dataCachePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return dataCachePath;
}

#pragma mark ------ 获取文件路径

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
    NSString *dataCachePath = [[self cachePath] stringByAppendingPathComponent:@"netInterfaceData"];
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

#pragma mark ------ 私有方法 获取 bundleID

+ (NSString *)bundleid{
    
    NSString *bundleId  =  [[[NSBundle mainBundle] infoDictionary]
                            objectForKey:@"CFBundleIdentifier"];
    
    return bundleId;
}

#pragma mark ------ 清空文件夹
// 外部
+ (BOOL)clearUpFileFolder:(HNBFileFolderDirectory)folderDir{
    
    BOOL isClear = TRUE; // 默认值
    switch (folderDir) {
        case HNBFileFolderDocuments:
            isClear = [[NSFileManager defaultManager] removeItemAtPath:[self documentPath] error:nil];
            NSLog(@"HNBFileFolderDocuments");
            break;
        case HNBFileFolderLibrary:
            isClear = [[NSFileManager defaultManager] removeItemAtPath:[self libraryPath] error:nil];
            NSLog(@"HNBFileFolderLibrary");
            break;
        case HNBFileFolderCaches:
            isClear = [[NSFileManager defaultManager] removeItemAtPath:[self cachePath] error:nil];
            NSLog(@"HNBFileFolderCaches");
            break;
        case HNBFileFolderSDWebImageCacheDefault:
            isClear = [[NSFileManager defaultManager] removeItemAtPath:[self sdWebImageCacheDefaultPath] error:nil];
            NSLog(@"HNBFileFolderSDWebImageCacheDefault");
            break;
        case HNBFileFolderWKWebKitfsCachedData:
            isClear = [[NSFileManager defaultManager] removeItemAtPath:[self wkWebKitfsCachedDataPath] error:nil];
            NSLog(@"HNBFileFolderWKWebKitfsCachedData");
            break;
        case HNBFileFolderNetInterfaceData:
            isClear = [[NSFileManager defaultManager] removeItemAtPath:[self netInterfaceDataCachePath] error:nil];
            NSLog(@"HNBFileFolderNetInterfaceData");
            break;
        case HNBFileFolderTmp:
            isClear = [[NSFileManager defaultManager] removeItemAtPath:[self tmpPath] error:nil];
            NSLog(@"HNBFileFolderTmp");
            break;
        case HNBFileFolderLibUIWebKit:
            isClear = [[NSFileManager defaultManager] removeItemAtPath:[self libUIWebKitPath] error:nil];
            NSLog(@"HNBFileFolderTmp");
            break;
        case HNBFileFoldersSet:
            isClear = [[NSFileManager defaultManager] removeItemAtPath:[self netInterfaceDataCachePath] error:nil] &&
                      [[NSFileManager defaultManager] removeItemAtPath:[self sdWebImageCacheDefaultPath] error:nil] &&
                      [[NSFileManager defaultManager] removeItemAtPath:[self wkWebKitfsCachedDataPath] error:nil] &&
                      [[NSFileManager defaultManager] removeItemAtPath:[self libUIWebKitPath] error:nil];
            NSLog(@"HNBFileFoldersSet");
            break;
        default:
            break;
    }
    return isClear;
}

/**<=====================发帖图片选择器图片路径 缓存 移除 =====================>*/

+ (NSString *)richTextImagesCachePathWithKey:(NSString *)key{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *imagesCachePath = [[self cachePath] stringByAppendingPathComponent:@"RichTextImagesCache"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:imagesCachePath]) {
        [fileManager createDirectoryAtPath:imagesCachePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    imagesCachePath = [imagesCachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",key]];
    return imagesCachePath;
}

+(BOOL)writeRichTextImageData:(NSData *)data path:(NSString *)path{
    return [data writeToFile:path atomically:TRUE];
}

+(BOOL)removeRichTextImageFromPath:(NSString *)path{
    return [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}

+ (BOOL)readRichTextImageFromPath:(NSString *)path{
    UIImage *img = [[UIImage alloc] initWithContentsOfFile:path];
    if (img != nil) {
        return TRUE;
    }
    return FALSE;
}

@end
