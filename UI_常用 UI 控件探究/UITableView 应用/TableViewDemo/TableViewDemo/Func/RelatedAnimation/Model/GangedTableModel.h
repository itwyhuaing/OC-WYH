//
//  GangedTableModel.h
//  TableViewDemo
//
//  Created by hnbwyh on 2018/11/12.
//  Copyright © 2018年 TongXin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ItemModel : NSObject

@property (nonatomic,copy)  NSString    *cnt;
@property (nonatomic,copy)  NSString    *img;
@property (nonatomic,copy)  NSString    *pid;

@end


@interface ElementModel : NSObject

@property (nonatomic,copy)      NSString             *them;
@property (nonatomic,strong)    NSArray<ItemModel *> *items;

@end

@interface GangedTableModel : NSObject

@property (nonatomic,strong) NSArray<NSString *>            *barThems;
@property (nonatomic,strong) NSArray<ElementModel *>        *elements;

@end

NS_ASSUME_NONNULL_END
