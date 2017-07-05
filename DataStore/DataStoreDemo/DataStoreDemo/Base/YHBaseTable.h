//
//  YHBaseTable.h
//  LXYHOCFunctionsDemo
//
//  Created by hnbwyh on 17/6/8.
//  Copyright © 2017年 lachesismh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHBaseTable;
@protocol YHBaseTableDelegate <NSObject>
@optional
- (void)yhBaseTable:(YHBaseTable *)yhTable didSelectedCellIndexPath:(NSIndexPath *)index;
@end


@interface YHBaseTable : UITableView

@property (nonatomic,weak) id<YHBaseTableDelegate>yhDelegate;

-(instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource;

@end
