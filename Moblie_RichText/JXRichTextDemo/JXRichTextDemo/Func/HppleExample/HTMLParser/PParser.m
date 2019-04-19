//
//  PParser.m
//  JXRichTextDemo
//
//  Created by hnbwyh on 2019/4/17.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "PParser.h"

@implementation PParser

/**
 <p style="text-indent:2em;font-size:24px;color:blue;">
 你要和别人和平共处，就先得和他们周旋，还得准备随时吃亏。
 </p>
 */

+(instancetype)currentHTMLParser{
    static PParser *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[PParser alloc] init];
    });
    return instance;
}

- (NSAttributedString *)addAttributesWithAts:(NSMutableAttributedString *)ats attribute:(NSDictionary *)attributes{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    NSArray *keys = attributes.allKeys;
    NSRange allRange = NSMakeRange(0, ats.length);
    for (NSString *key in keys) {
        
        if ([key isEqualToString:@"text-indent"]) {
            NSString *value = [attributes valueForKey:key];
            if (value && ![value isEqualToString:@"auto"]) {
                paraStyle.firstLineHeadIndent = value.floatValue;
            }
        }
        
        if ([key isEqualToString:@"line-height"]) {
            NSString *value = [attributes valueForKey:key];
            if (value && ![value isEqualToString:@"auto"]) {
                paraStyle.lineSpacing = value.floatValue;
            }
//            else {
//                paraStyle.lineSpacing = 10.0;
//            }
        }
        
        if ([key isEqualToString:@"text-align"]) {
            NSString *value = [attributes valueForKey:key];
            if ([value isEqualToString:@"left"]) {
                paraStyle.alignment = NSTextAlignmentLeft;
            }else if ([value isEqualToString:@"center"]) {
                paraStyle.alignment = NSTextAlignmentCenter;
            }else if ([value isEqualToString:@"right"]) {
                paraStyle.alignment = NSTextAlignmentRight;
            }
            
        }
        
        if ([key isEqualToString:@"letter-spacing"]) {
            NSString *value = [attributes valueForKey:key];
            if (value && ![value isEqualToString:@"auto"]) {
                [ats addAttribute:NSKernAttributeName value:@(value.floatValue) range:allRange];
            }
        }
        
        if ([key isEqualToString:@"font-size"]) {
            NSString *value = [attributes valueForKey:key];
            [ats addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:value.floatValue] range:allRange];
        }
        
        if ([key isEqualToString:@"color"]) {
            NSString *value = [attributes valueForKey:key];
            if ([value rangeOfString:@"red"].location != NSNotFound) {
                [ats addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:allRange];
            }else if ([value rangeOfString:@"green"].location != NSNotFound) {
                [ats addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:allRange];
            }else if ([value rangeOfString:@"blue"].location != NSNotFound) {
                [ats addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:allRange];
            }
            
        }
        
    }
    [ats addAttribute:NSParagraphStyleAttributeName value:paraStyle range:allRange];
    return ats;
}

@end
