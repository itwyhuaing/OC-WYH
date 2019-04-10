//
//  HTMLFactory.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/4/10.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTMLFactory.h"
#import "PLabel.h"
#import "FontLabel.h"
#import "ImgLabel.h"

@implementation HTMLFactory

+ (NSString *)htmlFactoryWithttributedString:(NSAttributedString *)attributedText{
    NSMutableString *htmlContent = [[NSMutableString alloc] init];
    NSRange effectiveRange = NSMakeRange(0, 0);
    while (NSMaxRange(effectiveRange) < attributedText.string.length) {
        NSDictionary *attributes = [attributedText attributesAtIndex:effectiveRange.location effectiveRange:&effectiveRange];
        NSString *text = [attributedText.string substringWithRange:effectiveRange];
        effectiveRange = NSMakeRange(NSMaxRange(effectiveRange), 0);
        NSTextAttachment *attachment = attributes[@"NSAttachment"];
        if (attachment) { // 图片
            
        }else{  // 文字
            
            [htmlContent appendString:[FontLabel fontLabelWithTextAttributes:attributes content:text]];
            
            if (NSMaxRange(effectiveRange) >= attributedText.string.length) {
                NSString *p_end = @"</p>";
                NSMutableString *p = [[NSMutableString alloc] initWithString:[PLabel pLabelWithTextAttributes:attributes]];
                [p insertString:htmlContent atIndex:p.length - p_end.length];
                htmlContent = p;
            }
            
        }
    }
    return htmlContent;
}

@end
