//
//  NTEditorAttributeConfig.h
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2018/5/22.
//  Copyright © 2018年 hainbwyh. All rights reserved.
//

/**
 v1.0 所支持
 粗体、斜体、删除线、字体大小、对齐方式
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    EditorRichTextCapacityTypeImage = 20000,
    EditorRichTextCapacityTypeBold,
    EditorRichTextCapacityTypeItalic,
    EditorRichTextCapacityTypeStrikethrough,
    EditorRichTextCapacityTypeFont,
    EditorRichTextCapacityTypeAlign,
} EditorRichTextCapacityType;



@interface NTEditorAttributeConfig : NSObject

- (void)configAttributes:(NSArray *)att;


- (void)updateAttributesForEditor:(UITextView *)editor didSelectedIndex:(NSInteger)index;

@end
