//
//  ImgLabel.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/4/10.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImgLabel.h"
#import "RTImage.h"

@implementation ImgLabel

+(NSString *)imgLabelWithTextAttributes:(NSDictionary *)attributes{
    NSString *rlt = @"";
    NSTextAttachment *attachment = attributes[@"NSAttachment"];
    RTImage *image = (RTImage *)attachment.image;
    if (image) {
        
    }
    return rlt;
}

@end
