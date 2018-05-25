//
//  EditorToolBar.h
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2018/5/9.
//  Copyright © 2018年 hainbwyh. All rights reserved.
//

#import <UIKit/UIKit.h>





@class EditorToolBar;
@protocol EditorToolBarDelegate <NSObject>
- (void)editorToolBar:(EditorToolBar *)bar didSelectItemAtIndexPath:(NSInteger)index;

@end

@interface EditorToolBar : UIView

@property (nonatomic,weak) id <EditorToolBarDelegate> delegate;

/**
 * 工具条是否可滑动
 * default : TRUE - 可滑动
 */
@property (nonatomic,assign) BOOL scrollEnable;

/**
 * 数组元素内容与显示内容相对应
 */
- (void)editorToolBarWithContents:(NSArray *)cnts;

/**
 * 样式修改
 */
- (void)modifyItemSize:(CGSize)itemSize reloadRightNow:(BOOL)reloadRightNow;
- (void)modifyminimumLineSpacing:(CGFloat)lineSpace reloadRightNow:(BOOL)reloadRightNow;
- (void)modifyInset:(UIEdgeInsets)inset reloadRightNow:(BOOL)reloadRightNow;

@end
