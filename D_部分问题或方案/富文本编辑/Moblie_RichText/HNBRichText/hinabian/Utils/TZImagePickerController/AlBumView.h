//
//  AlBumView.h
//  hinabian
//
//  Created by 何松泽 on 2017/8/16.
//  Copyright © 2017年 &#20313;&#22362;. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AlBumView;
@class TZAlbumModel;
@protocol AlbumViewDelegate<NSObject>

- (void)shouldRemoveFrom:(AlBumView *)view;

- (void)clickCellForIndex:(NSIndexPath *)indexPath ForView:(AlBumView *)View Model:(TZAlbumModel *)model;
@end

@interface AlBumView : UIView

/**代理*/
@property (nonatomic, weak)id <AlbumViewDelegate> delegate;

@property (nonatomic, weak)UIViewController *superViewController;

@property (nonatomic, assign) NSInteger columnNumber;

- (instancetype)initWithFrame:(CGRect)frame superViewController:(UIViewController *)superViewController preModel:(TZAlbumModel *)preModel;
- (instancetype)initWithCoder:(NSCoder *)aDecoder superViewController:(UIViewController *)superViewController;

+ (instancetype)albumViewWithData:(NSArray *)data superViewController:(UIViewController *)superViewController;

- (void)configTableView;

@end
