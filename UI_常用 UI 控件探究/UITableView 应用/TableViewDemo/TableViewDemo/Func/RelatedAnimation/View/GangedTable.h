//
//  GangedTable.h
//  TableViewDemo
//
//  Created by hnbwyh on 2018/11/12.
//  Copyright © 2018年 TongXin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GangedTableModel;

NS_ASSUME_NONNULL_BEGIN

@interface GangedTable : UITableView

// 联动 table 头部 - 外部传入、内部解耦
@property (nonatomic,strong)    UIView *gtableHeader;

// 联动 table 水平方向滚动条bar - 外部传入、内部解耦
//@property (nonatomic,strong)    UIView *gtableBar;

// 联动 table 所需数据 - UI依赖指定数据模型、外部组装
@property (nonatomic,strong)    GangedTableModel *dataModel;


@end

NS_ASSUME_NONNULL_END
