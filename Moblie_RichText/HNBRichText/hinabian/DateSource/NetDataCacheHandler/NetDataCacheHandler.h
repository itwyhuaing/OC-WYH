//
//  NetDataCacheHandler.h
//  hinabian
//
//  Created by hnbwyh on 17/3/21.
//  Copyright © 2017年 &#20313;&#22362;. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HNBFileManager.h"

typedef void(^NetDataCacheArrBlock)(NSArray *info);

@interface NetDataCacheHandler : NSObject

+ (instancetype)defaultManager;

/**
 * 圈子首页热门圈子数据缓存
 *
 */
+ (BOOL)writeHotTribesInTribeIndexInfo:(NSArray *)data cacheKey:(NSString *)cacheKey;
+ (void)readHotTribesInTribeIndexInfoWithCacheKey:(NSString *)cacheKey completion:(NetDataCacheArrBlock)compBlock;

@end
