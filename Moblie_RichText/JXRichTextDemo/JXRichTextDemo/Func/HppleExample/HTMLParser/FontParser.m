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
 <font style="font-size:30px;color:red;">
 你要和别人和平共处，就先得和他们周旋，还得准备随时吃亏。
 </font>
 */

+(instancetype)currentHTMLParser{
    static FontParser *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[FontParser alloc] init];
    });
    return instance;
}

- (NSAttributedString *)modifyAttributedStringWithHppleElement:(TFHppleElement *)element {
    NSString *text = element.text;
    NSString *showText = text ? text : @"";
    NSMutableAttributedString *mutableAtString = [[NSMutableAttributedString alloc] initWithString:showText];
    if ([element.tagName isEqualToString:@"font"]) {
        NSDictionary *atsInfo = [self composeAttributedDicWithAts:element.attributes];
        [self attributedString:mutableAtString info:atsInfo];
    }
    return mutableAtString;
}


- (void)attributedString:(NSMutableAttributedString *)atstring info:(NSDictionary *)info {
    NSArray *keys = info.allKeys;
    NSRange allRange = NSMakeRange(0, atstring.length);
    for (NSString *key in keys) {
        
        if ([key isEqualToString:@"font-size"]) {
            NSString *value = [info valueForKey:key];
            [atstring addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0] range:allRange];
        }
        
        if ([key isEqualToString:@"color"]) {
            NSString *value = [info valueForKey:key];
            if ([value rangeOfString:@"red"].location != NSNotFound) {
                [atstring addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:allRange];
            }else if ([value rangeOfString:@"green"].location != NSNotFound) {
                [atstring addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:allRange];
            }else if ([value rangeOfString:@"blue"].location != NSNotFound) {
                [atstring addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:allRange];
            }
            
        }
        
    }
}

@end
