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
    
    // [UIScreen mainScreen].scale center
    
    NSParagraphStyle *paraStyle  = attributes[@"NSParagraphStyle"];
    CGFloat kern = [NSString stringWithFormat:@"%@",attributes[@"NSKern"]].floatValue;
    
    //NSString *textIndent    = @"text-indent:30.0px";
    //NSString *lineHeight    = @"line-height:50px";
    //NSString *letterSpace   = @"letter-spacing:26px";
    CGFloat adjustedFirstLineHeadIndent = (paraStyle.firstLineHeadIndent > 0.0) ?  paraStyle.firstLineHeadIndent : 10.0;
    CGFloat adjustedLineSpacing         = (paraStyle.lineSpacing > 0.0) ?  paraStyle.lineSpacing : 6.0;
    CGFloat adjustedKern                = (kern > 0.0) ?  kern : 10.0;
    
    NSString *textIndent    = [NSString stringWithFormat:@"text-indent:%fpx",adjustedFirstLineHeadIndent * 2.6];
    NSString *lineHeight    = [NSString stringWithFormat:@"line-height:%fpx",adjustedLineSpacing * 8.5];
    NSString *letterSpace   = [NSString stringWithFormat:@"letter-spacing:%fpx",adjustedKern * 2.6];
    NSString *textAlign     = @"text-align:left";
    
    //NSLog(@"\n\n %f \n %f \n %f \n\n",paraStyle.firstLineHeadIndent,paraStyle.lineSpacing,kern);
    
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
