//
//  JSEditorConfig.h
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/12/10.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#ifndef JSEditorConfig_h
#define JSEditorConfig_h



// 尺寸定义
#define SCREEN_WIDTH                            [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT                           [UIScreen mainScreen].bounds.size.height
#define IS_IPHONE_X                             ([UIScreen mainScreen].bounds.size.height == 812.f || [UIScreen mainScreen].bounds.size.height == 896.f)
#define TOOL_BAR_HEIGHT                         44.0
#define LAYER_LINE_HEIGHT                       0.8
#define BOTTOM_HEIGHT_SUIT_IPHONE_X             (IS_IPHONE_X ? 34.0 : 0)


// 标记功能位置
typedef enum : NSUInteger {
    JSEditorToolBarInsertImage = 10000,     // 插入图片
    JSEditorToolBarBold,                // 粗体
    JSEditorToolBarItalic,              // 斜体
    JSEditorToolBarStrikethrough,       // 删除线
    JSEditorToolBarH1,                  // 字体 H1
    JSEditorToolBarH2,                  // 字体 H2
    JSEditorToolBarH3,                  // 字体 H3
    JSEditorToolBarH4,                  // 字体 H4
    JSEditorToolBarKeyBaord,            // 键盘收起或弹起
} JSEditorToolBarFuncType;

// 标记操作意向
typedef enum : NSUInteger {
    OperateIntentionOFF = 0,
    OperateIntentionON,
    OperateIntentionOther,
} OperateIntention;

// 标记工具条位置
typedef enum : NSUInteger {
    JSEditorToolBarYHight = 20000,
    JSEditorToolBarYLow,
    JSEditorToolBarYOther,
} JSEditorToolBarYStatus;

#endif /* JSEditorConfig_h */
