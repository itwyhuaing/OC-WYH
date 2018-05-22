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
            _boldAble ? typeingAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:32.0 weight:UIFontWeightBold] : nil;
        }
            break;
        case EditorRichTextCapacityTypeItalic:
        {
            test = @"EditorRichTextCapacityTypeItalic";
            _italicAble = !_italicAble;
            _italicAble ? typeingAttributes[NSObliquenessAttributeName] = @(0.3) : nil;
        }
            break;
        case EditorRichTextCapacityTypeStrikethrough:
        {
            test = @"EditorRichTextCapacityTypeStrikethrough";
            _strikeThroughAble = !_strikeThroughAble;
            _strikeThroughAble ? typeingAttributes[NSStrikethroughStyleAttributeName] = @(NSUnderlineStyleSingle) : nil;
        }
            break;
        case EditorRichTextCapacityTypeFont:
        {
            test = @"EditorRichTextCapacityTypeFont";
            _fontAble = !_fontAble;
            _fontAble ? typeingAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:32.0] : nil;
        }
            break;
            
        default:
            break;
    }
    editor.typingAttributes = typeingAttributes;
    
    NSLog(@" \n capacity:\n%@\n\n ",test);
    
}

@end
