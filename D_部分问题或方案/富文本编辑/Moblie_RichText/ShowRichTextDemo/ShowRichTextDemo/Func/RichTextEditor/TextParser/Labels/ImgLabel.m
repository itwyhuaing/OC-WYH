//
//  ImgLabel.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/4/12.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#import "ImgLabel.h"
#import <UIKit/UIKit.h>
#import "NSTextAttachment+RichText.h"

@implementation ImgLabel

+(instancetype)currentLabel{
    static ImgLabel *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ImgLabel alloc] init];
    });
    return instance;
}

- (NSString *)imgLabelWithTextAttributes:(NSDictionary *)attributes{
    NSString *rlt = @"";
    NSTextAttachment *attachment = attributes[@"NSAttachment"];
    NSLog(@"\n %@ \n",attachment.extendedInfo);
    UIImage *image = (UIImage *)attachment.image;
    if (image) {
        /**<img src="http://cache.hinabian.com/images/release/b/d/bb87ed887dbe7fff01a6a383895baa0d.png" width=200 height=100 />*/
        CGFloat screenW     = CGRectGetWidth([UIScreen mainScreen].bounds);
        CGFloat theWidth    = image.size.width >= screenW ? screenW : image.size.width;
        CGFloat theHeight   = theWidth * image.size.height / image.size.width;
        NSString *theURLStr = [NSString stringWithFormat:@"%@",[attachment.extendedInfo objectForKey:kImageAttachmentLoadedURL]];
        rlt = [NSString stringWithFormat:@"<img src=\"%@\" width=%f height=%f />",theURLStr,theWidth,theHeight];
    }
    return rlt;
}


@end
