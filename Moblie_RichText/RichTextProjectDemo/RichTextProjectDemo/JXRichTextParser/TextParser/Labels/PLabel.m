//
//  PLabel.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/4/12.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#import "PLabel.h"
#import <UIKit/UIKit.h>

@implementation PLabel

+(instancetype)currentLabel{
    static PLabel *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[PLabel alloc] init];
    });
    return instance;
}

- (NSString *)pLabelWithTextAttributes:(NSDictionary *)attributes{
    
    NSParagraphStyle *paraStyle  = attributes[@"NSParagraphStyle"];
    CGFloat kern = [NSString stringWithFormat:@"%@",attributes[@"NSKern"]].floatValue;
    
    CGFloat adjustedFirstLineHeadIndent = (paraStyle.firstLineHeadIndent > 0.0) ?  paraStyle.firstLineHeadIndent : self.adjustedFirstLineHeadIndentScale;
    CGFloat adjustedLineSpacing         = (paraStyle.lineSpacing > 0.0) ?  paraStyle.lineSpacing : self.adjustedLineSpacingScale;
    CGFloat adjustedKern                = (kern > 0.0) ?  kern : self.adjustedKernScale;
    
    NSString *textIndent    = [NSString stringWithFormat:@"text-indent:%fpx",adjustedFirstLineHeadIndent * 2.6];
    NSString *lineHeight    = [NSString stringWithFormat:@"line-height:%fpx",adjustedLineSpacing * 8.5];
    NSString *letterSpace   = [NSString stringWithFormat:@"letter-spacing:%fpx",adjustedKern * 2.6];
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
