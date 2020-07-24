//
//  ReqSender.m
//  NetDemo
//
//  Created by hnbwyh on 2020/7/24.
//  Copyright © 2020 JiXia. All rights reserved.
//

#import "ReqSender.h"
#import "ReqDataTool.h"

#define W3MOVEAD @"https://www.movead.xyz"
@implementation ReqSender

+(void)reqServerForShopAdditionWithName:(NSString *)name address:(NSString *)address detail_address:(NSString *)detail_address tels:(NSString *)tels mobies:(NSString *)mobies business_images:(NSString *)business_images permit_images:(NSString *)permit_images succeedHandler:(DataFetchSucceedHandler)succeedHandler failHandler:(DataFetchFailHandler)failHandler {
    NSString *URLString = [NSString stringWithFormat:@"%@/shops",W3MOVEAD];
    NSMutableDictionary *para = [NSMutableDictionary new];
    NSLog(@"\n === 发起请求-添加shop === \n");
    [ReqDataTool postWithURLString:URLString para:para success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"\n %@ \n",responseObject);
    } fail:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"\n %@ \n",error);
    }];
}

+(void)reqServerForShopListWithKey:(NSString *)key succeedHandler:(DataFetchSucceedHandler)succeedHandler failHandler:(DataFetchFailHandler)failHandler {
    NSString *URLString = [NSString stringWithFormat:@"%@/shops",W3MOVEAD];
    NSMutableDictionary *para = [NSMutableDictionary new];
    NSLog(@"\n === 发起请求-shoplist === \n");
    [ReqDataTool getWithURLString:URLString para:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"\n %@ \n",responseObject);
    } fail:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"\n %@ \n",error);
    }];
}

@end
