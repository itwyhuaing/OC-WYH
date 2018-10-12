//
//  ZFBItemModel.h
//  CollectionViewDemo
//
//  Created by hnbwyh on 2018/9/28.
//  Copyright © 2018年 JiXia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemModel : NSObject

@property (nonatomic,copy)          NSString                        *name;
@property (nonatomic,copy)          NSString                        *icon;
@property (nonatomic,copy)          NSString                        *itemid;

@end


@interface ZFBItemModel : NSObject

@property (nonatomic,copy)          NSString                         *themText;
@property (nonatomic,strong)        NSArray<ItemModel *>             *items;

@end
