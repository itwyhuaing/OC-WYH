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
//
//+ (NSString *)htmlFactoryWithAttributedString:(NSAttributedString *)attributedText{
//    NSMutableString *rlt = [[NSMutableString alloc] init];
//    if (attributedText) {
//        //NSMutableString *lastHtmlContent = [[NSMutableString alloc] init];
//        NSMutableString *htmlContent = [[NSMutableString alloc] init];
//        NSRange effectiveRange = NSMakeRange(0, 0);
//        while (NSMaxRange(effectiveRange) < attributedText.string.length) {
//            NSDictionary *attributes = [attributedText attributesAtIndex:effectiveRange.location effectiveRange:&effectiveRange];
//            NSString *text = [attributedText.string substringWithRange:effectiveRange];
//            NSTextAttachment *attachment = attributes[@"NSAttachment"];
//
//            // <font>、<b>、<i>、<img>
//            if (attachment) { // 图片
//
//            }else{  // 文字
//                [htmlContent appendString:[FontLabel fontLabelWithTextAttributes:attributes content:text]];
//            }
//            // <p>
//            if ([self isNewParagraphWithAttributedString:attributedText currntRange:effectiveRange currentText:text]) {
//                NSString *p_end = @"</p>";
//                NSMutableString *p = [[NSMutableString alloc] initWithString:[PLabel pLabelWithTextAttributes:attributes]];
//                [p insertString:htmlContent atIndex:p.length - p_end.length];
//            }
//            effectiveRange = NSMakeRange(NSMaxRange(effectiveRange), 0);
//        }
//        rlt = htmlContent;
//    }else{
//        rlt = [[NSMutableString alloc] initWithString:@"<p></p>"];
//    }
//    return rlt;
//
//}


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
        if (![text isEqualToString:@"\n"]) {
            // <font>、<b>、<i>、<img>
            if (attachment) { // 图片
                [ImgLabel imgLabelWithTextAttributes:attributes];
            }else{  // 文字
                [itemContent appendString:[FontLabel fontLabelWithTextAttributes:attributes content:text]];
            }
            [paraContent appendString:itemContent];
            // <p>
            NSRange range = NSMakeRange(effectiveRange.location, effectiveRange.length);
            if ([self isEndParagraphWithAttributedString:attributedText range:range]) {
                NSString *p_end = @"</p>";
                NSMutableString *p = [[NSMutableString alloc] initWithString:[PLabel pLabelWithTextAttributes:attributes]];
                [p insertString:paraContent atIndex:p.length - p_end.length];
                [rlt appendString:p];
                paraContent = [[NSMutableString alloc] init];
            }
            NSLog(@"");
        }
    }
    return rlt;
}


+ (BOOL)isEndParagraphWithAttributedString:(NSAttributedString *)attributedText range:(NSRange)range{
    BOOL isEndPara = FALSE;
    if (NSMaxRange(range) >= attributedText.length) {
        isEndPara = TRUE;
    }else{
        [attributedText attributesAtIndex:range.location effectiveRange:&range];
        NSString *nextText = [attributedText.string substringWithRange:range];
        if ([nextText isEqualToString:@"\n"] ) {
            isEndPara = TRUE;
        }
    }
    return isEndPara;
    
}

@end
