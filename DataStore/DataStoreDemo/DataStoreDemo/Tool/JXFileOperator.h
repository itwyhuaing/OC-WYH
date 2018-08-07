//
//  JXFileOperator.h
//  DataStoreDemo
//
//  Created by hnbwyh on 2018/8/1.
//  Copyright © 2018年 hainbwyh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static NSString *const kHNBNetDataCacheResponse     = @"kHNBNetDataCacheResponse";
static NSString *const kHNBNetInterfaceData         = @"netInterfaceData";

typedef enum : NSUInteger {
    HNBFileFolderDocuments                          = 1000,         // Documents
    HNBFileFolderLibrary                            = 2000,         // Library
    HNBFileFolderCaches                             = 2001,         // Library/Caches
    HNBFileFolderSDWebImageCacheDefault             = 2010,         // Library/Caches/default  (SDWebImageCache 图片)
    HNBFileFolderNetInterfaceData                   = 2020,         // Library/Caches/netInterfaceData  (网络接口数据缓存文件 - 自定义文件夹路径)
    HNBFileFolderNetHttpCacheResponseData           = 2100,         // Library/Caches/kHNBNetDataCacheResponse  (结合 YYCache 高性能数据缓存文件 - 自定义文件夹路径)
    HNBFileFolderWKWebKitfsCachedData               = 2031,         // Library/Caches/com.hinabian.hainabian/fsCachedData  (iOS8 之后WKWebkit , H5 页面自带缓存)
    HNBFileFolderWKWebKitCachedData                 = 2032,         // Library/Caches/(bundleid)/WebKit  (iOS8 之后WKWebkit , H5 页面自带缓存)
    HNBFileFolderLibUIWebKit                        = 2002,         // Library/WebKit (iOS7 及之前 UIWeb , H5 页面自带缓存)
    HNBFileFolderTmp                                = 3000,         // Tmp
    HNBFileFoldersSet                               = 4000          // 文件夹集合
} HNBFileFolderDirectory;

typedef void(^JXFileOperatorBlock)(NSString *info);

@interface JXFileOperator : NSObject

+ (instancetype)defaultManager;

/**<===================== YYCache 高性能数据存储:需要先引入  YYCache =====================>*/
/**
 * 依据 URL 与 参数 存/取数据
 */
+ (void)setHttpCache:(id)httpData URL:(NSString *)URL parameters:(NSDictionary *)parameters;
+ (id)httpCacheForURL:(NSString *)URL parameters:(NSDictionary *)parameters;

/**
 *  获取网络缓存的总大小 bytes(字节) 、 删除所有网络缓存
 */
+ (CGFloat)getAllHttpCacheSizeAboutYYCache;
+ (void)removeAllHttpCacheAboutYYCache;

/**<===================== 沙盒读写操作 =====================>*/

/**
 * 沙盒读取及清空操作 - 只支持 NSString、NSArray、NSDictionary 三类
 */
+(BOOL)sandBoxSaveInfo:(id)info forKey:(NSString *)key;
+(id)sandBoxGetInfo:(Class)cls forKey:(NSString *)key;
+(void) sandBoxClearAllInfo:(NSString *)key;

/**<===================== 常规文件读写操作 =====================>*/

/**
 * 给定文件名 - 创建该文件并返回文件路径
 */
+ (NSString *)filePathForFileName:(NSString *)fileName;

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
+ (void)returnSizeAtFileFolder:(HNBFileFolderDirectory)folderDir completeBlock:(JXFileOperatorBlock)fileBlock;


/**
 * 清空文件夹
 */
+ (BOOL)clearUpFileFolder:(HNBFileFolderDirectory)folderDir;

@end
