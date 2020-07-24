//
//  ReqDataTool.m
//  NetDemo
//
//  Created by hnbwyh on 2020/7/24.
//  Copyright © 2020 JiXia. All rights reserved.
//

#import "ReqDataTool.h"
#import <AFNetworking.h>

@implementation ReqDataTool

+ (void)postWithURLString:(NSString *)URLString para:(NSDictionary *)para success:(ReqDataToolSuccess)success fail:(ReqDataToolFail)fail{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/json",@"text/javascript",@"text/html"]];
    [self httpManager:manager
               method:@"POST"
            URLString:URLString
                 para:para
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success ? success(task,responseObject) : nil;
    } fail:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        fail ? fail(task,error) : nil;
    }];
    
}


+(void)getWithURLString:(NSString *)URLString para:(NSDictionary *)para success:(ReqDataToolSuccess)success fail:(ReqDataToolFail)fail {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/json",@"text/javascript",@"text/html"]];
    [self httpManager:manager
               method:@"GET"
            URLString:URLString
                 para:para
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success ? success(task,responseObject) : nil;
    } fail:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        fail ? fail(task,error) : nil;
    }];
}


+ (void)httpManager:(AFHTTPSessionManager *)afmgr method:(NSString *)method URLString:(NSString *)URLString para:(NSDictionary *)para success:(ReqDataToolSuccess)success fail:(ReqDataToolFail)fail{
    if ([method isEqualToString:@"POST"]) {
        [afmgr POST:URLString parameters:para headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
            NSLog(@"\n uploadProgress ： %@ \n",uploadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            success ? success(task,responseObject) : nil;
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            fail ? fail(task,error) : nil;
        }];
    }else if ([method isEqualToString:@"GET"]){
        [afmgr GET:URLString parameters:para headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            NSLog(@"\n downloadProgress ： %@ \n",downloadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            success ? success(task,responseObject) : nil;
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            fail ? fail(task,error) : nil;
        }];
    }
}


@end
