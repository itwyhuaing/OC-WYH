//
//  HNBFileManager.h
//  hinabian
//
//  Created by hnbwyh on 17/7/11.
//  Copyright © 2017年 &#20313;&#22362;. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    HNBFileFolderDocuments = 1000, // Documents
    HNBFileFolderLibrary = 2000,   // Library
    HNBFileFolderCaches = 2001,    // Library/Caches
    HNBFileFolderSDWebImageCacheDefault = 2010,    // Library/Caches/default  (SDWebImageCache 图片)
    HNBFileFolderNetInterfaceData = 2020,    // Library/Caches/netInterfaceData  (网络接口数据缓存文件 - 自定义文件夹路径)
    HNBFileFolderWKWebKitfsCachedData = 2031,    // Library/Caches/com.hinabian.hainabian/fsCachedData  (iOS8 之后WKWebkit , H5 页面自带缓存)
    HNBFileFolderLibUIWebKit = 2002,   // Library/WebKit (iOS7 及之前 UIWeb , H5 页面自带缓存)
    HNBFileFolderTmp = 3000,       // Tmp
    HNBFileFoldersSet = 4000       // 文件夹集合
} HNBFileFolderDirectory;

typedef void(^HNBFileManagerBlock)(NSString *info);

@interface HNBFileManager : NSObject

/**
 * 字符串 数组 字典 图片 按 key 移除
 */
+ (BOOL)clearFileDataWithCacheKey:(NSString *)key;

/**
 * 字符串 读写
 */
+ (BOOL)writeStringAPPNetInterfaceData:(NSString *)str cacheKey:(NSString *)key;
+ (NSString *)readStringAPPNetInterfaceDataWithCacheKey:(NSString *)key;

/**
 * 数组 读写
 */
+ (BOOL)writeArrAPPNetInterfaceData:(NSArray *)data cacheKey:(NSString *)key;
+ (NSArray *)readArrAPPNetInterfaceDataWithCacheKey:(NSString *)key;

/**
 * 字典 读写
 */
+ (BOOL)writeDicAPPNetInterfaceData:(NSDictionary *)data cacheKey:(NSString *)key;
+ (NSDictionary *)readDicAPPNetInterfaceDataWithCacheKey:(NSString *)key;

/**
 * 图片 读写
 */
+ (BOOL)writeImageAPPNetInterfaceData:(NSData *)data cacheKey:(NSString *)key;
+ (UIImage *)readImageAPPNetInterfaceDataWithCacheKey:(NSString *)key;

/**
 * 计算文件夹大小 - 单位 MB
 */
+ (void)returnSizeAtFileFolder:(HNBFileFolderDirectory)folderDir completeBlock:(HNBFileManagerBlock)fileBlock;


/**
 * 清空文件夹
 */
+ (BOOL)clearUpFileFolder:(HNBFileFolderDirectory)folderDir;

/**<=====================发帖图片选择器图片路径 缓存 读取 移除 =====================>*/

/**
 * 发帖图片选择器图片路径
 */
+ (NSString *)richTextImagesCachePathWithKey:(NSString *)key;


/**
 * 发帖图片选择器图片缓存
 */
+ (BOOL)writeRichTextImageData:(NSData *)data path:(NSString *)path;

/**
 * 发帖图片选择器图片读取
 */
+ (BOOL)readRichTextImageFromPath:(NSString *)path;

/**
 * 发帖图片选择器图片移除
 */
+ (BOOL)removeRichTextImageFromPath:(NSString *)path;


@end
