//
//  ScrollBannerView.h
//  YHScrollBannerView
//
//  Created by wangyinghua on 2017/5/12.
//  Copyright © 2017年 wangyinghua. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScrollBannerView;
@protocol ScrollBannerViewDelegate <NSObject>
@optional
- (void)scrollBannerView:(ScrollBannerView *)banner didSelectedImageViewAtIndex:(NSInteger)index;
- (void)scrollBannerView:(ScrollBannerView *)banner didEndScrollAtIndex:(NSInteger)index;
@end

@interface ScrollBannerView : UIView
/**
 delegate
 */
@property (nonatomic, weak) id<ScrollBannerViewDelegate> delegate;

/**
 重构init方法

 @param frame frame
 @param ti 轮播时间 -- 大于 0 自动轮播，其他手动轮播
 @return 实例化后的轮播容器
 */
- (instancetype)initWithFrame:(CGRect)frame autoPlayTimeInterval:(NSTimeInterval)ti;

/**
 重置轮播容器数据，并且启动定时器

 @param dataSource 轮播容器数据
 */
- (void)reFreshBannerViewWithDataSource:(NSArray<NSString *> *)dataSource;

@end
