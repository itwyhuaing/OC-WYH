//
//  YHFileOperator.h
//  LXYHOCFunctionsDemo
//
//  Created by hnbwyh on 17/6/8.
//  Copyright © 2017年 lachesismh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHFileOperator : NSObject

/**
 * 给定文件名 - 创建该文件并返回文件路径
 */
+ (NSString *)filePathForFileName:(NSString *)fileName;

/**
 * 沙盒-偏好设置存数据
 */
+ (BOOL)defaultSaveInfo:(id)info forKey:(NSString *)key;

/**
 * 沙盒-偏好设置取数据
 */
+ (id)defaultGetInfoCls:(Class)cls forKey:(NSString *)key;

@end
