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
    
    NSString *adjustedFirstLineHeadIndent = [NSString stringWithFormat:@"%fpt",MAX(0.0, paraStyle.firstLineHeadIndent)];
    NSString *adjustedLineSpacing         = [NSString stringWithFormat:@"%fpt",MAX(0.0, paraStyle.lineSpacing)];
    NSString *adjustedKern                = [NSString stringWithFormat:@"%fpt",MAX(0.0, kern)];
    if (MAX(0.0, paraStyle.lineSpacing) <= 0.0) {
        adjustedLineSpacing = @"auto";
    }
    if (MAX(0.0, kern) <= 0.0) {
        adjustedKern = @"auto";
    }
    NSString *textIndent    = [NSString stringWithFormat:@"text-indent:%@",adjustedFirstLineHeadIndent];
    NSString *lineHeight    = [NSString stringWithFormat:@"line-height:%@",adjustedLineSpacing];
    NSString *letterSpace   = [NSString stringWithFormat:@"letter-spacing:%@",adjustedKern];
    NSString *textAlign     = @"text-align:left";
    
    NSLog(@" P标签段落数据测试: %@ - %@ - %@ \n %@ - %@ - %@ ",adjustedFirstLineHeadIndent,adjustedLineSpacing,adjustedKern,textIndent,lineHeight,letterSpace);
    
    
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
