//
//  JXFMDBMOperator.h
//  DataStoreDemo
//
//  Created by hnbwyh on 2018/7/20.
//  Copyright © 2018年 hainbwyh. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface JXDataModelParser : NSObject

- (NSString *)sqlForTableKeyWithModelCls:(Class)modelCls;

@end


@interface JXFMDBMOperator : NSObject

/**
  单例

 @return 单例对象
 */
+ (instancetype)sharedInstance;

/**
 打开打印日志
 */
- (void)openLog;

@end
