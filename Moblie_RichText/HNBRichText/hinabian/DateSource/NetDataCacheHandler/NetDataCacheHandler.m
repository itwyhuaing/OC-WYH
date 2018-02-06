//
//  NetDataCacheHandler.m
//  hinabian
//
//  Created by hnbwyh on 17/3/21.
//  Copyright © 2017年 &#20313;&#22362;. All rights reserved.
//

#import "NetDataCacheHandler.h"
#import "TribeIndexHotTribe.h"

@interface NetDataCacheHandler ()

@property (nonatomic,copy) NSString *cachesFolderSize;

@end

@implementation NetDataCacheHandler

+ (instancetype)defaultManager{
    static NetDataCacheHandler *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NetDataCacheHandler alloc] init];
    });
    return instance;
}

#pragma mark --- 圈子首页 - 热门圈子

+(BOOL)writeHotTribesInTribeIndexInfo:(NSArray *)data cacheKey:(NSString *)cacheKey{

    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globalQueue, ^{
        [HNBFileManager writeArrAPPNetInterfaceData:data cacheKey:cacheKey];
    });
    return YES;
}

+(void)readHotTribesInTribeIndexInfoWithCacheKey:(NSString *)cacheKey completion:(NetDataCacheArrBlock)compBlock{

    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globalQueue, ^{
        
        NSArray *hotTribes = nil;
        NSArray *tmpData = [HNBFileManager readArrAPPNetInterfaceDataWithCacheKey:cacheKey];
        if (tmpData != nil) {
            for (NSInteger cou = 0; cou < tmpData.count; cou ++) {
                id tmpJson = tmpData[cou];
                NSDictionary *jsonTmp = [self setDicWithTimestamp:tmpJson];
                TribeIndexHotTribe *f = [TribeIndexHotTribe MR_createEntity];
                [f MR_importValuesForKeysWithObject:jsonTmp];
                //NSLog(@" read cache %@",f.name);
            }
            //hotTribes = [TribeIndexHotTribe MR_findAllSortedBy:@"timestamp" ascending:YES];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            compBlock(hotTribes);
        });
        
    });
    
}


#pragma mark - 时间戳方法

+ (NSDictionary *)setDicWithTimestamp:(id)info{
    NSDictionary *dic = (NSDictionary *)info;
    NSMutableDictionary *jsontmp = [[NSMutableDictionary alloc] init];
    [jsontmp setDictionary:dic];
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval timeInterval = [dat timeIntervalSince1970];
    NSString *dateTime = [NSString stringWithFormat:@"%f",timeInterval];
    [jsontmp setValue:dateTime forKey:@"timestamp"];
    return jsontmp;
}

@end
