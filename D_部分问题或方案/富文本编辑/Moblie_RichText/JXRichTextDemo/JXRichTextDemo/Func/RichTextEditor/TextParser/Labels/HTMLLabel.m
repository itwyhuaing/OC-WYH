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

// <p></p>
+ (NSString *)htmlLabelFor_P_LabelWithTextAttributes:(NSDictionary *)attributes {
    return [[PLabel currentLabel] pLabelWithTextAttributes:attributes];
}

// <font>(<b><i><s><u></u></s></i></b>)</font>
+ (NSString *)htmlLabelFor_Font_LabelWithTextAttributes:(NSDictionary *)attributes content:(NSString *)text {
    return [[FontLabel currentLabel] fontLabelWithTextAttributes:attributes content:text];
}

// <img />
+ (NSString *)htmlLabelFor_Img_LabelWithTextAttributes:(NSDictionary *)attributes {
    return [[ImgLabel currentLabel] imgLabelWithTextAttributes:attributes];
}

@end
