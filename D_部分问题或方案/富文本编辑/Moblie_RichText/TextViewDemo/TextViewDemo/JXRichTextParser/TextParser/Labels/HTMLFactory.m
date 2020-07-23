//
//  HTMLFactory.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/4/10.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTMLFactory.h"
#import "HTMLLabel.h"

@implementation HTMLFactory

+ (NSString *)htmlFactoryWithAttributedString:(NSAttributedString *)attributedText{
    NSMutableString *rlt = [[NSMutableString alloc] init];
    
    NSRange effectiveRange = NSMakeRange(0, 0);
    NSMutableString *paraContent = [[NSMutableString alloc] init];
    while (NSMaxRange(effectiveRange) < attributedText.string.length) {
        NSMutableString *itemContent = [[NSMutableString alloc] init];
        NSDictionary *attributes = [attributedText attributesAtIndex:effectiveRange.location effectiveRange:&effectiveRange];
        NSString *text = [attributedText.string substringWithRange:effectiveRange];
        NSTextAttachment *attachment = attributes[@"NSAttachment"];
        effectiveRange = NSMakeRange(NSMaxRange(effectiveRange), 0);
        if (![self isEndWithLineBreakForContent:text]) {
            // <font>、<b>、<i>、<img>
            if (attachment) { // 图片
                [itemContent appendString:[HTMLLabel htmlLabelForImgLabelWithTextAttributes:attributes]];
            }else{  // 文字
                [itemContent appendString:[HTMLLabel htmlLabelForFontLabelWithTextAttributes:attributes content:text]];
            }
            [paraContent appendString:itemContent];
            // <p>
            NSRange range = NSMakeRange(effectiveRange.location, effectiveRange.length);
            if ([self isEndParagraphWithAttributedString:attributedText range:range]) {
                NSString *p_end = @"</p>";
                NSMutableString *p = [[NSMutableString alloc] initWithString:[HTMLLabel htmlLabelForPLabelWithTextAttributes:attributes]];
                [p insertString:paraContent atIndex:p.length - p_end.length];
                [rlt appendString:p];
                paraContent = [[NSMutableString alloc] init];
            }
            NSLog(@"");
        }
    }
    return rlt;
}


// 节点是否为段落结束
+ (BOOL)isEndParagraphWithAttributedString:(NSAttributedString *)attributedText range:(NSRange)range{
    BOOL isEndPara = FALSE;
    if (NSMaxRange(range) >= attributedText.length) {
        isEndPara = TRUE;
    }else{
        [attributedText attributesAtIndex:range.location effectiveRange:&range];
        NSString *nextText = [attributedText.string substringWithRange:range];
        if ([self isEndWithLineBreakForContent:nextText] ) {
            isEndPara = TRUE;
        }
    }
    return isEndPara;
    
}

// 判定字符串格式
+ (BOOL)isEndWithLineBreakForContent:(NSString *)content{
    /** 注意 \n 可能有空格的情况 : @"\n" @" \\ n" @" \n" @" \n "*/
    BOOL lineBreak = FALSE;
    if (content) {
        content = [content stringByReplacingOccurrencesOfString:@"\n" withString:@"A"];
        content = [content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if ([content hasSuffix:@"A"]) {
            lineBreak = TRUE;
        }
    }
    return lineBreak;
}

@end
