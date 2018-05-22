//
//  NTEditorMainView.h
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2018/5/9.
//  Copyright © 2018年 hainbwyh. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 标记当前光标所在区域
 *
 * NTEditorMainViewEditingLocationNone  - 非编辑状态
 * NTEditorMainViewEditingLocationTitle - 标题区
 * NTEditorMainViewEditingLocationCnt   - 内容区
 */
typedef enum : NSUInteger {
    NTEditorMainViewEditingLocationNone = 100000,
    NTEditorMainViewEditingLocationTitle,
    NTEditorMainViewEditingLocationCnt,
} NTEditorMainViewEditingLocation;

@class NTEditorMainView;
@protocol NTEditorMainViewDelegate <NSObject>
- (void)ntEditorMainView:(NTEditorMainView *)editor didEndEditingWithCnt:(NSString *)cnt;

@end

@interface NTEditorMainView : UITextView <UITextViewDelegate,UITextFieldDelegate>

@property (nonatomic,weak) id<UITextFieldDelegate,UITextViewDelegate> ntDelegate;


/**
 hdEditing  - :TRUE 设置标题处于编辑态 ,具有较高优先级
 cntEditing - :TRUE 设置内容区处于编辑态
 */
- (void)modifyHeaderEditing:(BOOL)hdEditing contentEditing:(BOOL)cntEditing;


@property (nonatomic,assign) NTEditorMainViewEditingLocation editingLocation;

@end
