//
//  DropListMenu.h
//  YHDropListMenu
//
//  Created by wyh on 15/12/14.
//  Copyright © 2015年 lachesismh. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DropListMenu;

@protocol DropListMenuDelegate <NSObject>

/**
 * 列主题数组
 */
- (NSArray *)dropListMenu:(DropListMenu *)dropListMenu titlesForSection:(NSInteger)section;

/**
 * 下拉 cell 主题数组
 */
- (NSArray *)dropListMenu:(DropListMenu *)dropListMenu section:(NSInteger)section;

/**
 * 选中 某一列 cell
 */
- (void)dropListMenu:(DropListMenu *)dropListMenu section:(NSInteger)section didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface DropListMenu : UIView

- (id)initWithFrame:(CGRect)frame superView:(UIView *)view delegate:(id<DropListMenuDelegate>)delegate;


@end