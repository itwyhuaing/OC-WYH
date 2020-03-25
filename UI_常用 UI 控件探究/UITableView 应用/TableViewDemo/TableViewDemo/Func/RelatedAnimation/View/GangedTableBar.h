//
//  GangedTableBar.h
//  TableViewDemo
//
//  Created by hnbwyh on 2018/11/12.
//  Copyright © 2018年 TongXin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface TabBarItem : UICollectionViewCell

@property (nonatomic,copy)      NSString *title;

@end
NS_ASSUME_NONNULL_END


@class GangedTableBar;
@protocol GangedTableBarDelegate <NSObject>
@optional
- (void)gangedTableBar:(GangedTableBar *)bar didSelectedAtIndexPath:(NSIndexPath *)index;

@end


NS_ASSUME_NONNULL_BEGIN

@interface GangedTableBar : UIView

@property (nonatomic,strong)        NSArray<NSString *> *thems;

@property (nonatomic,weak) id<GangedTableBarDelegate> delegate;

// 滚动
- (void)gangedTableBarScrollToItemAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
