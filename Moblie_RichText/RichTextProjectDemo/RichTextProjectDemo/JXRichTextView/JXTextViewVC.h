//
//  JXTextViewVC.h
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2018/5/8.
//  Copyright © 2018年 hainbwyh. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface JXTextViewVC : UIViewController

@end

/**
 原生实现富文本技术难点两方面：
 1. 如何实现富文本的编辑
    1.1 UITextView 中属性 typingAttributes 可修改，且当前状态下的 typingAttributes 参数值(粗体、斜体、下划线、字体大小行间距等等)即决定当前输入的富文本类型
 
 2. 如何将其转换为 HTML 数据
 
 v1.0 所支持
 粗体、斜体、删除线、字体大小、对齐方式
 */
