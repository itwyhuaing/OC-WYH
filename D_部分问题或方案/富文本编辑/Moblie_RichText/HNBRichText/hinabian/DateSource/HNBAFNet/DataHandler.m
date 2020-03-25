//
//  DataHandler.m
//  hinabian
//
//  Created by hnbwyh on 16/5/11.
//  Copyright © 2016年 &#20313;&#22362;. All rights reserved.
//

#import "DataHandler.h"
#import "Tribe.h"

@implementation DataHandler

+ (void)doGetAllTribesHandleData:(id)responseObject complete:(DataHandlerComplete)completion{
    
    
    [Tribe MR_truncateAll];
    NSMutableArray * Tribes = [responseObject returnValueWithKey:@"data"];
    
    NSInteger countLabels = 0;
    if ([Tribes isKindOfClass:[NSArray class]] && Tribes) {
        countLabels = Tribes.count;
    }
    
    for(int i =0; i<countLabels; i++)
    {
        id tmpJson = Tribes[i];
        NSDictionary *jsontmp = [self setTimestampDic:tmpJson];
        Tribe * f = [Tribe MR_createEntity];
        [f MR_importValuesForKeysWithObject:jsontmp];
        //NSLog(@"Tribe ====== >%@",f.name);
    }
    
}

#pragma mark 时间戳方法
+ (NSDictionary *)setTimestampDic:(id)info{
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
