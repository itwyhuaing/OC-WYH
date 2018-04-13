//
//  XQFOfflineCacheHandler.h
//  A8TV_IPhone
//
//  Created by ggt on 2017/4/10.
//  Copyright © 2017年 New Sense Networks Technology Co., Ltd.. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "NewsDataEntity.h"


typedef NS_ENUM(NSUInteger, XQFOfflineCacheModelType) {
    XQFOfflineCacheModelTypeNewsAndVideos,  /**< 首页新闻和热门视屏 */
    XQFOfflineCacheModelTypeHighlights, /**< 精彩集锦 */
    XQFOfflineCacheModelTypePosts, /**< 帖子 */
};

@interface XQFOfflineCacheHandler : NSObject

singleton_interface(XQFOfflineCacheHandler)

/**
 存储数据
 */
- (void)saveDataWithDictionary:(NSDictionary *)dict;

/**
 读取数据
 */
- (void)readDataWithCacheTitle:(NSString *)cacheTitle complete:(void (^)(NSArray *array))complete;

/**
 删除数据
 */
- (void)deletedDataWithCacheTitle:(NSString *)cacheTitle;

// 浏览历史

- (void)saveHistoryCacheDataWithModel:(id )model type:(XQFOfflineCacheModelType)type;

- (void)readHistoryHistoryCacheDataWithComplete:(void (^)(NSArray *array))complete;

- (void)deletedHistoryCacheData;

//点赞历史
- (void)saveLikedPostWithPostID:(NSString *)postID;

- (void)readLikedPostWithComplete:(void (^)(NSArray *array))complete;

- (void)deleteLikedPost;
@end
