//
//  NTEditorConfig.h
//  RichTextPro
//
//  Created by hnbwyh on 2019/12/24.
//  Copyright © 2019 JiXia. All rights reserved.
//

#ifndef NTEditorConfig_h
#define NTEditorConfig_h


//=============================== 尺寸定义 ===============================
// 系统尺寸
#define SCREEN_WIDTH                            [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT                           [UIScreen mainScreen].bounds.size.height

// 系统兼容
#define IS_IPHONE_X                             ([UIScreen mainScreen].bounds.size.height == 812.f || [UIScreen mainScreen].bounds.size.height == 896.f)
#define STATUBAR_HEIGHT                         (IS_IPHONE_X ? 44.0 : 20.0)
#define NAVIGATION_BAR_HEIGHT                   44.0
#define BOTTOM_HEIGHT_SUIT_OFF_X                (IS_IPHONE_X ? 34.0 : 0)
#define BOTTOMTAB_HEIGHT                        (49.0 + BOTTOM_HEIGHT_SUIT_OFF_X)

// 自定义尺寸
#define TOOL_BAR_HEIGHT                          44.0
#define LAYER_LINE_HEIGHT                        0.8

//=============================== 逻辑定义 ===============================
#define WSelf                               __weak typeof(self)weakSelf = self;

#endif /* NTEditorConfig_h */
