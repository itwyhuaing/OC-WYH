//
//  HNBAFNetTool.m
//  hinabian
//
//  Created by wangyinghua on 16/4/6.
//  Copyright © 2016年 &#20313;&#22362;. All rights reserved.
//

#import "HNBAFNetTool.h"
#import <AFNetworking/AFNetworking.h>
#import "HNBToast.h"


static AFHTTPSessionManager *afnManager = nil;
static AFHTTPSessionManager *afnJsonManager = nil;
static AFHTTPSessionManager *afnHtmlManager = nil;

@implementation HNBAFNetTool


/**
 *  创建单例
 *
 *  @return
 */
+ (instancetype)sharedHNBNetTool {
    static HNBAFNetTool *__manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __manager = [[HNBAFNetTool alloc] init];
        afnManager = [AFHTTPSessionManager manager];
        //afnManager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        afnManager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        
        afnJsonManager = [AFHTTPSessionManager manager];
        afnJsonManager.responseSerializer = [AFJSONResponseSerializer serializer];
        afnJsonManager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        afnJsonManager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        afnHtmlManager = [AFHTTPSessionManager manager];
        
        afnHtmlManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        afnHtmlManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    });
    
    return __manager;
    
}

+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(HNBAFNetToolSuccess)success failure:(HNBAFNetToolFailure)failure{
    [[HNBAFNetTool sharedHNBNetTool] GET:URLString parameters:parameters success:success failure:failure];
}

+(void)POST:(NSString *)URLString parameters:(id)parameters success:(HNBAFNetToolSuccess)success failure:(HNBAFNetToolFailure)failure{
    [[HNBAFNetTool sharedHNBNetTool] POST:URLString parameters:parameters success:success failure:failure];
}

+(void)JSONPOST:(NSString *)URLString parameters:(id)parameters success:(HNBAFNetToolSuccess)success failure:(HNBAFNetToolFailure)failure{
    [[HNBAFNetTool sharedHNBNetTool] JSONPOST:URLString parameters:parameters success:success failure:failure];
}

+(void)HTMLPOST:(NSString *)URLString parameters:(id)parameters success:(HNBAFNetToolSuccess)success failure:(HNBAFNetToolFailure)failure{
    [[HNBAFNetTool sharedHNBNetTool] HTMLPOST:URLString parameters:parameters success:success failure:failure];
}


+(void)acceptableContentTypes:(NSString *)objType GET:(NSString *)URLString parameters:(id)parameters success:(HNBAFNetToolSuccess)success failure:(HNBAFNetToolFailure)failure{
    [[HNBAFNetTool sharedHNBNetTool] acceptableContentTypes:objType GET:URLString parameters:parameters success:success failure:failure];
}

+(void)acceptableContentTypes:(NSString *)objType POST:(NSString *)URLString parameters:(id)parameters success:(HNBAFNetToolSuccess)success failure:(HNBAFNetToolFailure)failure{
    [[HNBAFNetTool sharedHNBNetTool] acceptableContentTypes:objType POST:URLString parameters:parameters success:success failure:failure];
}

+ (void)cancleAllRequest
{
    [[HNBAFNetTool sharedHNBNetTool] cancleAllRequest];
}

- (void)cancleAllRequest
{
    //    [afnManager.operationQueue cancelAllOperations];
    //    [afnManager invalidateSessionCancelingTasks:TRUE];
    //    afnManager = [AFHTTPSessionManager manager];
    //    //afnManager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    //    afnManager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    //    NSLog(@"session = %@",afnManager.session);
    //    //NSLog(@"session = %@",afnManager.session);
    for (NSURLSessionDataTask *f in afnManager.dataTasks) {
        NSLog(@"cancle %@",f);
        [f cancel];
    }
    for (NSURLSessionDataTask *f in afnJsonManager.dataTasks) {
        NSLog(@"cancle %@",f);
        [f cancel];
    }
    
    
}
- (void)GET:(NSString *)URLString parameters:(id)parameters success:(HNBAFNetToolSuccess)success failure:(HNBAFNetToolFailure)failure{
    //AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    afnManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",nil];
    [afnManager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}

-(void)POST:(NSString *)URLString parameters:(id)parameters success:(HNBAFNetToolSuccess)success failure:(HNBAFNetToolFailure)failure{
    
    [afnManager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(task,responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code == -1009) {
            
            [[HNBToast shareManager] toastWithOnView:nil msg:@"无网络,请稍后重试" afterDelay:1.0 style:HNBToastHudFailure];
            
        } else {
            
            failure(task,error);
            
        }
    }];
}


-(void)JSONPOST:(NSString *)URLString parameters:(id)parameters success:(HNBAFNetToolSuccess)success failure:(HNBAFNetToolFailure)failure{
    
    [afnJsonManager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (error.code == -1009) {
            
            [[HNBToast shareManager] toastWithOnView:nil msg:@"无网络,请稍后重试" afterDelay:1.0 style:HNBToastHudFailure];
            
        } else {
            
            failure(task,error);
            
        }
    }];
}

-(void)HTMLPOST:(NSString *)URLString parameters:(id)parameters success:(HNBAFNetToolSuccess)success failure:(HNBAFNetToolFailure)failure{

    
    [afnHtmlManager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (error.code == -1009) {
            
            [[HNBToast shareManager] toastWithOnView:nil msg:@"无网络,请稍后重试" afterDelay:1.0 style:HNBToastHudFailure];
            
        } else {
            
            failure(task,error);
            
        }
    }];
}

- (void)acceptableContentTypes:(NSString *)objType GET:(NSString *)URLString parameters:(id)parameters success:(HNBAFNetToolSuccess)success failure:(HNBAFNetToolFailure)failure{
    // AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if (objType.length != 0) {
        afnManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:objType];
    }
    [afnManager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}

-(void)acceptableContentTypes:(NSString *)objType POST:(NSString *)URLString parameters:(id)parameters success:(HNBAFNetToolSuccess)success failure:(HNBAFNetToolFailure)failure{
    //AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if (objType.length != 0) {
        afnManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:objType];
    }
    [afnManager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}


+(void)webOpenFailPOST:(NSString *)URLString parameters:(id)parameters success:(HNBAFNetToolSuccess)success failure:(HNBAFNetToolFailure)failure{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"application/html", nil];
    manager.responseSerializer =  [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //NSLog(@" webOpenFailPOST uploadProgress %@ ",uploadProgress);
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //NSLog(@" webOpenFailPOST responseObject :%@ ",responseObject);
        id resIdInfo = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:nil];
        //NSLog(@" ====== ");
        NSLog(@" webOpenFailPOST resIdInfo :%@ ",resIdInfo);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@" webOpenFailPOST error :%@ ",error);
        
    }];
    
}

@end

