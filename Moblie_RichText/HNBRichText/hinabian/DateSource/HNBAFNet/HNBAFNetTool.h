//
//  HNBAFNetTool.h
//  hinabian
//
//  Created by wangyinghua on 16/4/6.
//  Copyright © 2016年 &#20313;&#22362;. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef void(^HNBAFNetToolSuccess)(NSURLSessionDataTask *task,id responseObject);
typedef void(^HNBAFNetToolFailure)(NSURLSessionDataTask *task,NSError *error);

@interface HNBAFNetTool : NSObject

//单例模式
+ (instancetype)sharedHNBNetTool;

#pragma mark - GET text/html
+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(HNBAFNetToolSuccess)success failure:(HNBAFNetToolFailure)failure;

#pragma mark - POST text/html
+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(HNBAFNetToolSuccess)success failure:(HNBAFNetToolFailure)failure;

#pragma mark - POST JSON
+(void)JSONPOST:(NSString *)URLString parameters:(id)parameters success:(HNBAFNetToolSuccess)success failure:(HNBAFNetToolFailure)failure;

#pragma mark - POST HTML
+(void)HTMLPOST:(NSString *)URLString parameters:(id)parameters success:(HNBAFNetToolSuccess)success failure:(HNBAFNetToolFailure)failure;

#pragma mark - GET  objType
+ (void)acceptableContentTypes:(NSString *)objType GET:(NSString *)URLString parameters:(id)parameters success:(HNBAFNetToolSuccess)success failure:(HNBAFNetToolFailure)failure;

#pragma mark - POST objType
+ (void)acceptableContentTypes:(NSString *)objType POST:(NSString *)URLString parameters:(id)parameters success:(HNBAFNetToolSuccess)success failure:(HNBAFNetToolFailure)failure;

+ (void)cancleAllRequest;

#pragma mark ------ web 打开失败

+ (void)webOpenFailPOST:(NSString *)URLString parameters:(id)parameters success:(HNBAFNetToolSuccess)success failure:(HNBAFNetToolFailure)failure;

@end
