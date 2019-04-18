//
//  FontParser.m
//  JXRichTextDemo
//
//  Created by hnbwyh on 2019/4/17.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "FontParser.h"

@implementation FontParser

 /**
  <font></font>
  <font><u></u></font>
  <font><u><b></b></u></font>
  <font><u><b><i></i></b></u></font>
  
  <font><b>加粗测试数据</b>正常字体数据<i>斜体测试数据</i></font>
  
 */

+(instancetype)currentHTMLParser{
    static FontParser *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[FontParser alloc] init];
    });
    return instance;
}

- (NSAttributedString *)parserFontLabelsWithFontElement:(TFHppleElement *)felement {
    NSAttributedString *rlt;
    if ([felement.tagName isEqualToString:@"font"]) {
        // font 属性参数提取
        NSDictionary *fontAttributes = [self composeAttributedDicWithAts:felement.attributes];
        CGFloat fontSize             = 16.0;
        UIColor *clr                 = [UIColor blackColor];
        NSArray *keys                = fontAttributes.allKeys;
        for (NSString *key in keys) {
            
            if ([key isEqualToString:@"font-size"]) {
                NSString *value = [fontAttributes valueForKey:key];
                fontSize        = value.floatValue;
            }else if ([key isEqualToString:@"color"]) {
                NSString *value = [fontAttributes valueForKey:key];
                if ([value rangeOfString:@"red"].location != NSNotFound) {
                    clr = [UIColor redColor];
                }else if ([value rangeOfString:@"green"].location != NSNotFound) {
                    clr = [UIColor greenColor];
                }else if ([value rangeOfString:@"blue"].location != NSNotFound) {
                    clr = [UIColor blueColor];
                }
                
            }
            
        }
        
        // 标签解析
        if ([felement hasChildren]) {
            NSArray *children = [felement children];
            NSMutableAttributedString *tmpString = [[NSMutableAttributedString alloc] initWithString:@""];
            for (NSInteger idx = 0; idx < children.count; idx ++) {
                TFHppleElement *theElement = children[idx];
                if ([theElement.tagName isEqualToString:@"text"]) {
                    NSString *showText = theElement.content ? theElement.content : @"";
                    [tmpString appendAttributedString:[[NSAttributedString alloc] initWithString:showText]];
                }else if ([theElement.tagName isEqualToString:@"u"]){
                    NSAttributedString *u_text = [self parserULabelWith_U_Element:theElement fontSize:fontSize];
                    [tmpString appendAttributedString:u_text];
                }else if ([theElement.tagName isEqualToString:@"b"]){
                    NSAttributedString *b_text = [self parserULabelWith_B_Element:theElement fontSize:fontSize];
                    [tmpString appendAttributedString:b_text];
                }else if ([theElement.tagName isEqualToString:@"i"]){
                    NSAttributedString *i_text = [self parserULabelWith_I_Element:theElement fontSize:fontSize];
                    [tmpString appendAttributedString:i_text];
                }else if ([theElement.tagName isEqualToString:@"s"]){
                    NSAttributedString *s_text = [self parserULabelWith_S_Element:theElement fontSize:fontSize];
                    [tmpString appendAttributedString:s_text];
                }
            }
            // font 属性设置
            [tmpString addAttribute:NSForegroundColorAttributeName value:clr range:NSMakeRange(0, tmpString.length)];
            rlt = tmpString;
            
        }
    }
    return rlt;
}

// u
- (NSAttributedString *)parserULabelWith_U_Element:(TFHppleElement *)uelement fontSize:(CGFloat)fs {
    NSAttributedString *rlt;
    if ([uelement.tagName isEqualToString:@"u"]) {
        if ([uelement hasChildren]) {
            NSArray *children = [uelement children];
            NSMutableAttributedString *tmpString = [[NSMutableAttributedString alloc] initWithString:@""];
            for (NSInteger idx = 0; idx < children.count; idx ++) {
                TFHppleElement *theElement = children[idx];
                if ([theElement.tagName isEqualToString:@"text"]) {
                    NSString *showText = theElement.content ? theElement.content : @"";
                    [tmpString appendAttributedString:[[NSAttributedString alloc] initWithString:showText]];
                }else if ([theElement.tagName isEqualToString:@"b"]){
                    NSAttributedString *b_text = [self parserULabelWith_B_Element:theElement fontSize:fs];
                    [tmpString appendAttributedString:b_text];
                }else if ([theElement.tagName isEqualToString:@"i"]){
                    NSAttributedString *i_text = [self parserULabelWith_I_Element:theElement fontSize:fs];
                    [tmpString appendAttributedString:i_text];
                }else if ([theElement.tagName isEqualToString:@"s"]){
                    NSAttributedString *s_text = [self parserULabelWith_S_Element:theElement fontSize:fs];
                    [tmpString appendAttributedString:s_text];
                }
            }
            [tmpString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, tmpString.length)];
            rlt = tmpString;
        }
    }
    return rlt;
}

// b
- (NSAttributedString *)parserULabelWith_B_Element:(TFHppleElement *)belement fontSize:(CGFloat)fs {
    NSAttributedString *rlt;
    if ([belement.tagName isEqualToString:@"b"]) {
        if ([belement hasChildren]) {
            NSArray *children = [belement children];
            NSMutableAttributedString *tmpString = [[NSMutableAttributedString alloc] initWithString:@""];
            for (NSInteger idx = 0; idx < children.count; idx ++) {
                TFHppleElement *theElement = children[idx];
                if ([theElement.tagName isEqualToString:@"text"]) {
                    NSString *showText = theElement.content ? theElement.content : @"";
                    [tmpString appendAttributedString:[[NSAttributedString alloc] initWithString:showText]];
                }else if ([theElement.tagName isEqualToString:@"u"]){
                    NSAttributedString *u_text = [self parserULabelWith_U_Element:theElement fontSize:fs];
                    [tmpString appendAttributedString:u_text];
                }else if ([theElement.tagName isEqualToString:@"i"]){
                    NSAttributedString *i_text = [self parserULabelWith_I_Element:theElement fontSize:fs];
                    [tmpString appendAttributedString:i_text];
                }else if ([theElement.tagName isEqualToString:@"s"]){
                    NSAttributedString *s_text = [self parserULabelWith_S_Element:theElement fontSize:fs];
                    [tmpString appendAttributedString:s_text];
                }
            }
            [tmpString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fs weight:UIFontWeightBold] range:NSMakeRange(0, tmpString.length)];
            rlt = tmpString;
        }
    }
    return rlt;
}

// i
- (NSAttributedString *)parserULabelWith_I_Element:(TFHppleElement *)ielement fontSize:(CGFloat)fs {
    NSAttributedString *rlt;
    if ([ielement.tagName isEqualToString:@"i"]) {
        if ([ielement hasChildren]) {
            NSArray *children = [ielement children];
            NSMutableAttributedString *tmpString = [[NSMutableAttributedString alloc] initWithString:@""];
            for (NSInteger idx = 0; idx < children.count; idx ++) {
                TFHppleElement *theElement = children[idx];
                if ([theElement.tagName isEqualToString:@"text"]) {
                    NSString *showText = theElement.content ? theElement.content : @"";
                    [tmpString appendAttributedString:[[NSAttributedString alloc] initWithString:showText]];
                }else if ([theElement.tagName isEqualToString:@"b"]){
                    NSAttributedString *b_text = [self parserULabelWith_B_Element:theElement fontSize:fs];
                    [tmpString appendAttributedString:b_text];
                }else if ([theElement.tagName isEqualToString:@"u"]){
                    NSAttributedString *u_text = [self parserULabelWith_U_Element:theElement fontSize:fs];
                    [tmpString appendAttributedString:u_text];
                }else if ([theElement.tagName isEqualToString:@"s"]){
                    NSAttributedString *s_text = [self parserULabelWith_S_Element:theElement fontSize:fs];
                    [tmpString appendAttributedString:s_text];
                }
            }
            [tmpString addAttribute:NSObliquenessAttributeName value:@(0.3) range:NSMakeRange(0, tmpString.length)];
            rlt = tmpString;
        }
    }
    return rlt;
}

// s
- (NSAttributedString *)parserULabelWith_S_Element:(TFHppleElement *)selement fontSize:(CGFloat)fs {
    NSAttributedString *rlt;
    if ([selement.tagName isEqualToString:@"s"]) {
        if ([selement hasChildren]) {
            NSArray *children = [selement children];
            NSMutableAttributedString *tmpString = [[NSMutableAttributedString alloc] initWithString:@""];
            for (NSInteger idx = 0; idx < children.count; idx ++) {
                TFHppleElement *theElement = children[idx];
                if ([theElement.tagName isEqualToString:@"text"]) {
                    NSString *showText = theElement.content ? theElement.content : @"";
                    [tmpString appendAttributedString:[[NSAttributedString alloc] initWithString:showText]];
                }else if ([theElement.tagName isEqualToString:@"b"]){
                    NSAttributedString *b_text = [self parserULabelWith_B_Element:theElement fontSize:fs];
                    [tmpString appendAttributedString:b_text];
                }else if ([theElement.tagName isEqualToString:@"i"]){
                    NSAttributedString *i_text = [self parserULabelWith_I_Element:theElement fontSize:fs];
                    [tmpString appendAttributedString:i_text];
                }else if ([theElement.tagName isEqualToString:@"u"]){
                    NSAttributedString *u_text = [self parserULabelWith_U_Element:theElement fontSize:fs];
                    [tmpString appendAttributedString:u_text];
                }
            }
            [tmpString addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, tmpString.length)];
            rlt = tmpString;
        }
    }
    return rlt;
}

@end
