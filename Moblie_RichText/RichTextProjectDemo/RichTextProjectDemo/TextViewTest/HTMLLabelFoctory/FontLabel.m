//
//  FontLabel.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/4/10.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FontLabel.h"

@implementation FontLabel

+(NSString *)fontLabelWithTextAttributes:(NSDictionary *)attributes content:(nonnull NSString *)text{
    
    NSMutableString *rlt = [[NSMutableString alloc] initWithString:text];
    UIFont  *font = attributes[@"NSFont"];
    UIColor *clr  = attributes[@"NSColor"];
    NSString *fontSize = [NSString stringWithFormat:@"font-size:%f",font.pointSize];
    NSString *color    = [NSString stringWithFormat:@"color:%@",[self hexStringWithColor:clr]];
    BOOL bold          = [font.description containsString:@"font-weight: bold;"];
    CGFloat obli       = [NSString stringWithFormat:@"%@",attributes[@"NSObliqueness"]].floatValue;
    if (obli > 0.0) {
        [rlt insertString:@"<i>" atIndex:0];
        [rlt appendString:@"</i>"];
    }
    
    if (bold) {
        [rlt insertString:@"<b>" atIndex:0];
        [rlt appendString:@"</b>"];
    }
    
    [rlt insertString:[NSString stringWithFormat:@"<font style=\"%@;%@\">",fontSize,color] atIndex:0];
    [rlt appendString:@"</font>"];
    
    return rlt;
    
}

+ (NSString *)hexStringWithColor:(UIColor *)color {
    
    NSString *colorString = [[CIColor colorWithCGColor:color.CGColor] stringRepresentation];
    NSArray *parts = [colorString componentsSeparatedByString:@" "];
    
    NSMutableString *hexString = [NSMutableString stringWithString:@"#"];
    for (int i = 0; i < 3; i ++) {
        [hexString appendString:[NSString stringWithFormat:@"%02X", (int)([parts[i] floatValue] * 255)]];
    }
    return [hexString copy];
}


@end
