//
//  PLabel.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/4/10.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLabel.h"

@implementation PLabel

+ (NSString *)pLabelWithTextAttributes:(NSDictionary *)attributes{
    NSParagraphStyle *paraStyle  = attributes[@"NSParagraphStyle"];
    CGFloat kern = [NSString stringWithFormat:@"%@",attributes[@"NSKern"]].floatValue;
    NSString *textIndent    = [NSString stringWithFormat:@"text-indent:%fem",paraStyle.firstLineHeadIndent];
    NSString *lineHeight    = [NSString stringWithFormat:@"line-height:%fpx",paraStyle.lineSpacing];
    NSString *letterSpace   = [NSString stringWithFormat:@"letter-spacing:%fpx",kern * 2.0];
    NSString *textAlign     = @"text-align:left";
    switch (paraStyle.alignment) {
        case NSTextAlignmentCenter:
            {
              textAlign     = @"text-align:center";
            }
            break;
        case NSTextAlignmentRight:
            {
                textAlign     = @"text-align:right";
            }
            break;
            
        default:
            break;
    }
    NSString *rlt = [NSString stringWithFormat:@"<p style=\"%@;%@;%@;%@;\"></p>",textIndent,lineHeight,letterSpace,textAlign];
    return rlt;
}

@end
