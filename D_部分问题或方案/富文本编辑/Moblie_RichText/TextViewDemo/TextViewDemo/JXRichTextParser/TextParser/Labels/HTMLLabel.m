//
//  HTMLLabel.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/4/12.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#import "HTMLLabel.h"
#import "PLabel.h"
#import "FontLabel.h"
#import "ImgLabel.h"

@implementation HTMLLabel

+(instancetype)currentLabel{
    static HTMLLabel *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HTMLLabel alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _adjustedFirstLineHeadIndentScale   = 10.0;
            _adjustedLineSpacingScale           = 6.0;
            _adjustedKernScale                  = 10.0;
            _adjustedFontSizeScale              = 2.6;
        });
    }
    return self;
}

// <p></p>
+ (NSString *)htmlLabelForPLabelWithTextAttributes:(NSDictionary *)attributes {
    return [[PLabel currentLabel] pLabelWithTextAttributes:attributes];
}

// <font><b><i><s><u></u></s></i></b></font>
+ (NSString *)htmlLabelForFontLabelWithTextAttributes:(NSDictionary *)attributes content:(NSString *)text {
    return [[FontLabel currentLabel] fontLabelWithTextAttributes:attributes content:text];
}

// <img />
+ (NSString *)htmlLabelForImgLabelWithTextAttributes:(NSDictionary *)attributes {
    return [[ImgLabel currentLabel] imgLabelWithTextAttributes:attributes];
}

@end
