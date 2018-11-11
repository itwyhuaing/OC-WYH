//
//  HNBLinearView.h
//  FineHouse
//
//  Created by 蔡成汉 on 2018/8/31.
//  Copyright © 2018年 Hinabian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HNBLinearLayout.h"

@protocol HNBLinearViewDelegate;
@interface HNBLinearView : UIView

// layout
@property (nonatomic, strong, readonly) HNBLinearLayout *layout;

// delegate
@property (nonatomic, weak) id<HNBLinearViewDelegate>delegate;

// data array
@property (nonatomic, copy) NSArray <id> *dataArray;

// 索引
@property (nonatomic, assign) NSUInteger index;

// 设置页面数据、显示的索引
- (void)setDataArray:(NSArray<id> *)dataArray index:(NSUInteger)index;

@end


@protocol HNBLinearViewDelegate <NSObject>

@optional;

// item did select
- (void)linearView:(HNBLinearView *)linearView itemDidSelect:(NSInteger)index view:(UIView *)view;

// item did scroll
- (void)linearView:(HNBLinearView *)linearView itemDidScroll:(CGFloat)offset nextIndex:(NSUInteger)index;

// item did end scroll
- (void)linearViewDidEndScroll:(HNBLinearView *)linearView;

@end
