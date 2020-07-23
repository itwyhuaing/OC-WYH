//
//  FontLabel.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/4/12.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#import "FontLabel.h"
#import <UIKit/UIKit.h>

@implementation FontLabel

+(instancetype)currentLabel{
    static FontLabel *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[FontLabel alloc] init];
    });
    return instance;
}

- (NSString *)fontLabelWithTextAttributes:(NSDictionary *)attributes content:(nonnull NSString *)text{
    
    NSMutableString *rlt = [[NSMutableString alloc] initWithString:text];
    UIFont          *font               = attributes[@"NSFont"];
    UIColor         *clr                = attributes[@"NSColor"];
    NSString        *strikeThrough      = [NSString stringWithFormat:@"%@",attributes[@"NSStrikethrough"]];
    NSString        *underline          = [NSString stringWithFormat:@"%@",attributes[@"NSUnderline"]];
    NSString        *underlineColor     = [NSString stringWithFormat:@"%@",attributes[@"NSUnderlineColor"]];
    NSString        *fontSize           = [NSString stringWithFormat:@"font-size:%fpx",font.pointSize * self.adjustedFontSizeScale];
    NSString        *color              = [NSString stringWithFormat:@"color:%@",[self hexStringWithColor:clr]];
    BOOL            bold                = [font.description containsString:@"font-weight: bold;"];
    CGFloat         obliFloat           = [NSString stringWithFormat:@"%@",attributes[@"NSObliqueness"]].floatValue;
    CGFloat         strikethroughFloat  = 0.0;
    CGFloat         underlineFloat      = 0.0;
    
    // 下划线
    if (underline) {
        underlineFloat = underline.floatValue;
        if (underlineFloat > 0.0) {
            [rlt insertString:@"<u>" atIndex:0];
            [rlt appendString:@"</u>"];
        }
    }
    // 删除线
    if (strikeThrough) {
        strikethroughFloat = strikeThrough.floatValue;
        if (strikethroughFloat > 0.0) {
            [rlt insertString:@"<s>" atIndex:0];
            [rlt appendString:@"</s>"];
        }
    }
    // 斜体
    if (obliFloat > 0.0) {
        [rlt insertString:@"<i>" atIndex:0];
        [rlt appendString:@"</i>"];
    }
    // 粗体
    if (bold) {
        [rlt insertString:@"<b>" atIndex:0];
        [rlt appendString:@"</b>"];
    }
    
    [rlt insertString:[NSString stringWithFormat:@"<font style=\"%@;%@\">",fontSize,color] atIndex:0];
    [rlt appendString:@"</font>"];
    
    return rlt;
    
}

- (NSString *)hexStringWithColor:(UIColor *)color {
    
    NSString *colorString = [[CIColor colorWithCGColor:color.CGColor] stringRepresentation];
    NSArray *parts = [colorString componentsSeparatedByString:@" "];
    
    NSMutableString *hexString = [NSMutableString stringWithString:@"#"];
    for (int i = 0; i < 3; i ++) {
        [hexString appendString:[NSString stringWithFormat:@"%02X", (int)([parts[i] floatValue] * 255)]];
    }
    return [hexString copy];
}

@end
