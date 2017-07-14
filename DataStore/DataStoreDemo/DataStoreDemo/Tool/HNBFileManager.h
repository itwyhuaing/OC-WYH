//
//  HNBFileManager.h
//  hinabian
//
//  Created by hnbwyh on 17/7/11.
//  Copyright © 2017年 &#20313;&#22362;. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

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
 * 计算文件夹大小 - 单位 MB
 */
+ (void)returnSizeAtFileFolder:(HNBFileFolderDirectory)folderDir completeBlock:(HNBFileManagerBlock)fileBlock;


/**
 * 清空文件夹
 */
+ (BOOL)clearUpFileFolder:(HNBFileFolderDirectory)folderDir;

/*================= 普通文件 =====================*/
/**
 * 字符串 读写 文件
 */
+ (BOOL)writeStringAPPNetInterfaceData:(NSString *)str cacheKey:(NSString *)key;
+ (NSString *)readStringAPPNetInterfaceDataWithCacheKey:(NSString *)key;

/**
 * 数组 读写 文件
 */
+ (BOOL)writeArrAPPNetInterfaceData:(NSArray *)data cacheKey:(NSString *)key;
+ (NSArray *)readArrAPPNetInterfaceDataWithCacheKey:(NSString *)key;

/**
 * 字典 读写 文件
 */
+ (BOOL)writeDicAPPNetInterfaceData:(NSDictionary *)data cacheKey:(NSString *)key;
+ (NSDictionary *)readDicAPPNetInterfaceDataWithCacheKey:(NSString *)key;

/**
 * 图片 读写 文件
 */
+ (BOOL)writeImageAPPNetInterfaceData:(UIImage *)data cacheKey:(NSString *)key;
+ (UIImage *)readImageAPPNetInterfaceDataWithCacheKey:(NSString *)key;

/*=============== 偏好设置存数据 =======================*/

/**
 * 沙盒-偏好设置存数据
 */
+ (BOOL)defaultSaveInfo:(id)info forKey:(NSString *)key;

/**
 * 沙盒-偏好设置取数据
 */
+ (id)defaultGetInfoCls:(Class)cls forKey:(NSString *)key;

/*=============== 归档 =======================*/
/**
 * 归档
 */
+ (BOOL)archiveCustombject:(id)obj toFileName:(NSString *)fileName;

/**
 * 解档
 */
+ (id)unArchiveCustombject:(id)obj fromFileName:(NSString *)fileName;

@end
