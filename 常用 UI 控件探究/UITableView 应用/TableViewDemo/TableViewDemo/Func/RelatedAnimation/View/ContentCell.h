//
//  ContentCell.h
//  CollectionViewDemo
//
//  Created by hnbwyh on 2018/11/9.
//  Copyright © 2018年 JiXia. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContentCell : UITableViewCell

@property (nonatomic,strong) NSArray *datas;

@property (nonatomic,copy)   NSString *title;

@end

NS_ASSUME_NONNULL_END
