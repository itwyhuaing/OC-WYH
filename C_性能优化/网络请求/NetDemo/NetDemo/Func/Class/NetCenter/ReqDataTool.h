//
//  ReqDataTool.h
//  NetDemo
//
//  Created by hnbwyh on 2020/7/24.
//  Copyright © 2020 JiXia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ReqDataToolSuccess)(NSURLSessionDataTask *task,id responseObject);
typedef void(^ReqDataToolFail)(NSURLSessionDataTask *task,NSError *error);
@interface ReqDataTool : NSObject

+ (void)postWithURLString:(NSString *)URLString para:(NSDictionary *)para success:(ReqDataToolSuccess)success fail:(ReqDataToolFail)fail;

+ (void)getWithURLString:(NSString *)URLString para:(NSDictionary *)para success:(ReqDataToolSuccess)success fail:(ReqDataToolFail)fail;

@end

NS_ASSUME_NONNULL_END
