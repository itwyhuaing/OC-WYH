//
//  JXFileOperator.h
//  DataStoreDemo
//
//  Created by hnbwyh on 2018/8/1.
//  Copyright © 2018年 hainbwyh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static NSString *const kJXNetDataCacheResponse     = @"kJXNetDataCacheResponse";
static NSString *const kJXNetInterfaceData         = @"netInterfaceData";

typedef enum : NSUInteger {
    JXFileFolderDocuments                          = 1000,         // Documents
    JXFileFolderLibrary                            = 2000,         // Library
    JXFileFolderCaches                             = 2001,         // Library/Caches
    JXFileFolderSDWebImageCacheDefault             = 2010,         // Library/Caches/default  (SDWebImageCache 图片)
    JXFileFolderNetInterfaceData                   = 2020,         // Library/Caches/netInterfaceData  (网络接口数据缓存文件 - 自定义文件夹路径)
    JXFileFolderNetHttpCacheResponseData           = 2100,         // Library/Caches/kJXNetDataCacheResponse  (结合 YYCache 高性能数据缓存文件 - 自定义文件夹路径)
    JXFileFolderWKWebKitfsCachedData               = 2031,         // Library/Caches/com.hinabian.hainabian/fsCachedData  (iOS8 之后WKWebkit , H5 页面自带缓存)
    JXFileFolderWKWebKitCachedData                 = 2032,         // Library/Caches/(bundleid)/WebKit  (iOS8 之后WKWebkit , H5 页面自带缓存)
    JXFileFolderLibUIWebKit                        = 2002,         // Library/WebKit (iOS7 及之前 UIWeb , H5 页面自带缓存)
    JXFileFolderTmp                                = 3000,         // Tmp
    JXFileFoldersSet                               = 4000          // 文件夹集合
} JXFileFolderDirectory;

typedef void(^JXFileOperatorBlock)(NSString *info);

@interface JXFileOperator : NSObject

/**
 * 单例
 */
+ (instancetype)defaultManager;

/**<===================== http 网络数据 JSON 存储 =====================>*/
/**
 * 依据 URL 与 参数 存/取数据
 */
+ (BOOL)saveHttpCache:(id)httpData URL:(NSString *)URL parameters:(NSDictionary *)parameters;
+ (id)getHttpCacheForURL:(NSString *)URL parameters:(NSDictionary *)parameters;


/**<===================== 沙盒读写清空操作 =====================>*/

/**
 * 沙盒读取及清空操作 - 只支持 NSString、NSArray、NSDictionary 三类
 */
+(BOOL)sandBoxSaveInfo:(id)info forKey:(NSString *)key;
+(id)sandBoxGetInfo:(Class)cls forKey:(NSString *)key;
+(void) sandBoxClearAllInfo:(NSString *)key;

/**<===================== 常规文件读写清空操作 =====================>*/

/**
 * 文件读取及清空操作 - 只支持 NSString、NSArray、NSDictionary 三类
 */
+ (BOOL)saveDataInfo:(id)info forKey:(NSString *)key;
+ (id)getDataInfo:(Class)cls forKey:(NSString *)key;
+ (BOOL)clearFileDataWithCacheKey:(NSString *)key;


/**
 * 给定文件名 - 创建该文件并返回文件路径
 */
+ (NSString *)filePathAtFolderDirectory:(JXFileFolderDirectory)folderDir fileName:(NSString *)fileName;

/**
 * 计算文件夹大小 - 单位 MB
 */
+ (void)returnSizeAtFileFolder:(JXFileFolderDirectory)folderDir completeBlock:(JXFileOperatorBlock)fileBlock;


/**
 * 清空文件夹
 */
+ (BOOL)clearUpFileFolder:(JXFileFolderDirectory)folderDir;

@end
