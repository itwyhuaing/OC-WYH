//
//  ReqSender.h
//  NetDemo
//
//  Created by hnbwyh on 2020/7/24.
//  Copyright © 2020 JiXia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^DataFetchLocalCachedHandler)(id JSON);
typedef void(^DataFetchSucceedHandler)(id JSON);
typedef void(^DataFetchFailHandler)(id error);
@interface ReqSender : NSObject

+ (void)reqServerForShopAdditionWithName:(NSString *)name
                                 address:(NSString *)address
                          detail_address:(NSString *)detail_address
                                    tels:(NSString *)tels
                                  mobies:(NSString *)mobies
                         business_images:(NSString *)business_images
                           permit_images:(NSString *)permit_images
                          succeedHandler:(DataFetchSucceedHandler)succeedHandler
                             failHandler:(DataFetchFailHandler)failHandler;

+ (void)reqServerForShopListWithKey:(NSString *)key succeedHandler:(DataFetchSucceedHandler)succeedHandler failHandler:(DataFetchFailHandler)failHandler;


@end

NS_ASSUME_NONNULL_END
