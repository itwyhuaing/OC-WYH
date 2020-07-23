//
//  NTEditorAttributeConfig.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2018/5/22.
//  Copyright © 2018年 hainbwyh. All rights reserved.
//

#import "NTEditorAttributeConfig.h"
#import <UIKit/UIKit.h>

@interface NTEditorAttributeConfig ()

@property (nonatomic,strong) NSMutableArray *attributes;

@property (nonatomic,assign) BOOL imageAble;
@property (nonatomic,assign) BOOL boldAble;
@property (nonatomic,assign) BOOL italicAble;
@property (nonatomic,assign) BOOL strikeThroughAble;
@property (nonatomic,assign) BOOL fontAble;

@end

@implementation NTEditorAttributeConfig

-(void)configAttributes:(NSArray *)att{
    self.attributes = [[NSMutableArray alloc] initWithArray:att];
}

- (void)updateAttributesForEditor:(UITextView *)editor didSelectedIndex:(NSInteger)index{
    EditorRichTextCapacityType capacity = index + EditorRichTextCapacityTypeImage;
    NSMutableDictionary *typeingAttributes = [editor.typingAttributes mutableCopy];
    
    NSString *test = @"";
    switch (capacity) {
        case EditorRichTextCapacityTypeImage:
            {
                test = @"EditorRichTextCapacityTypeImage";
                _imageAble = !_imageAble;
            }
            break;
        case EditorRichTextCapacityTypeBold:
        {
            test = @"EditorRichTextCapacityTypeBold";
            _boldAble = !_boldAble;
            typeingAttributes[NSFontAttributeName] = (_boldAble ? [UIFont systemFontOfSize:32.0 weight:UIFontWeightBold] : [UIFont systemFontOfSize:32.0 weight:UIFontWeightRegular]);
        }
            break;
        case EditorRichTextCapacityTypeItalic:
        {
            test = @"EditorRichTextCapacityTypeItalic";
            _italicAble = !_italicAble;
            typeingAttributes[NSObliquenessAttributeName] = (_italicAble ? @(0.3) : @(0));
        }
            break;
        case EditorRichTextCapacityTypeStrikethrough:
        {
            test = @"EditorRichTextCapacityTypeStrikethrough";
            _strikeThroughAble = !_strikeThroughAble;
            typeingAttributes[NSStrikethroughStyleAttributeName] = (_strikeThroughAble ? @(NSUnderlineStyleSingle) : @(NSUnderlineStyleNone));
        }
            break;
        case EditorRichTextCapacityTypeFont:
        {
            test = @"EditorRichTextCapacityTypeFont";
            _fontAble = !_fontAble;
            typeingAttributes[NSFontAttributeName] = _fontAble ? [UIFont systemFontOfSize:32.0] : [UIFont systemFontOfSize:16.0];
        }
            break;
            
        default:
            break;
    }
    editor.typingAttributes = typeingAttributes;
}

@end
