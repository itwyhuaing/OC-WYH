//
//  DataFetcher.m
//  hinabian
//
//  Created by hnbwyh on 15/6/15.
//  Copyright (c) 2015年 &#20313;&#22362;. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataFetcher.h"
#import <AFNetworking/AFNetworking.h>
#import "HNBAFNetTool.h"
#import "DataHandler.h"
#import "HNBToast.h"
#import "HNBAssetModel.h"

@implementation DataFetcher


+(void)cancleAllRequest{
    [HNBAFNetTool cancleAllRequest];
}

#pragma mark ---------  获取所有圈子

+ (void)doGetAllTribes:(DataFetchSucceedHandler)suceedHandler withFailHandler:(DataFetchFailHandler)failHandler
{
    
    [HNBAFNetTool POST:[NSString  stringWithFormat:@"%@/%@",H5URL,@"tribe/getTribeList"] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        //如果成功
        int errCode=   [[responseObject valueForKey:@"state"] intValue];
        if(errCode == 0)
        {
            [DataHandler doGetAllTribesHandleData:responseObject complete:nil];
        }
        else
        {
            NSLog(@"%@",[responseObject valueForKey:@"data"]);
        }
        
        suceedHandler(responseObject);
        
    }  failure:^(NSURLSessionDataTask *task, NSError *error) {
        failHandler(error);
    }];
    
}



+(void) hnbRichTextUpdatePostImage:(HNBAssetModel *)info WithSucceedHandler:(DataFetchSucceedHandler)suceedHandler withFailHandler:(DataFetchFailHandler)failHandler{
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //超时30s
    manager.requestSerializer.timeoutInterval = 30.f;
    UIImage *curImage = (UIImage *)info.image;
    //图片压缩率为最低
    NSData *imageData = UIImageJPEGRepresentation(curImage, 0.1);
    //NSMutableDictionary *parameters = @{@"avatar":imageData};
    
    /*显示HUD*/
    //    [[HNBToast shareManager] toastWithOnView:nil msg:@"正在提交" afterDelay:0.f style:HNBToastHudWaiting];
    
    [manager POST:@"https://imgupload.hinabian.com/image/saveWithCommonReturn" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:@"upfile" fileName:@"photo.jpg" mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        int errCode=   [[responseObject valueForKey:@"state"] intValue];
        if(errCode == 0)
        {
            //            [[HNBToast shareManager] toastWithOnView:nil msg:@"提交成功" afterDelay:DELAY_TIME style:HNBToastHudSuccession];
            
        }else
        {
            [[HNBToast shareManager] toastWithOnView:nil msg:[responseObject valueForKey:@"errmsg"] afterDelay:DELAY_TIME style:HNBToastHudFailure];
        }
        
        suceedHandler(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 传图已有进度条提示
        /**[[HNBToast shareManager] toastWithOnView:nil msg:@"上传失败" afterDelay:DELAY_TIME style:HNBToastHudFailure];**/
        failHandler(error);
        
    }];
    
    
}


+(void)hnbRichTextPostTribeID:(NSString *)tribeID themID:(NSString *)themID title:(NSString *)titleString content:(NSString *)contentString topicID:(NSString *)topicID withSucceedHandler:(DataFetchSucceedHandler)suceedHandler withFailHandler:(DataFetchFailHandler)failHandler{
    
    //显示HUD
    [[HNBToast shareManager] toastWithOnView:nil msg:@"正在提交" afterDelay:0.f style:HNBToastHudWaiting];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       titleString,@"title",
                                       contentString,@"content",
                                       nil];
    if (themID != nil || (themID.length > 0 && ![themID isEqualToString:@"null"])) {
        [parameters setObject:themID forKey:@"id"];
    }
    
    if (tribeID != nil || (tribeID.length > 0 && ![tribeID isEqualToString:@"null"])) {
        [parameters setObject:tribeID forKey:@"tribe_id"];
    }
    
    if (topicID != nil || (topicID.length > 0 && ![topicID isEqualToString:@"null"])) {
        [parameters setObject:topicID forKey:@"topic_id"];
    }
    
    parameters = [HNBUtils addGeneralKey:parameters];
    parameters = [HNBUtils addPlatformKey:parameters];
    NSString *URLString = [NSString  stringWithFormat:@"%@/%@",APIURL,@"theme/save"];
    [HNBAFNetTool POST:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //如果成功
        int errCode=   [[responseObject valueForKey:@"state"] intValue];
        if(errCode == 0)
        {
            [[HNBToast shareManager] toastWithOnView:nil msg:@"发帖成功" afterDelay:DELAY_TIME style:HNBToastHudSuccession];
        }
        else
        {
            [[HNBToast shareManager] toastWithOnView:nil msg:[responseObject valueForKey:@"data"] afterDelay:DELAY_TIME style:HNBToastHudFailure];
        }
        
        suceedHandler(responseObject);
        
    }  failure:^(NSURLSessionDataTask *task, NSError *error) {
        [[HNBToast shareManager] toastWithOnView:nil msg:@"发帖失败" afterDelay:DELAY_TIME style:HNBToastHudFailure];
        failHandler(error);
    }];
    
}


@end
