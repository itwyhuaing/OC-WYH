//
//  UIImage+JXImage.m
//  JXObjCategary
//
//  Created by hnbwyh on 2018/7/19.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "UIImage+JXImage.h"

@implementation UIImage (JXImage)

+(UIImage *)imageWithColor:(UIColor *)clr{
    
    const CGFloat alpha     = CGColorGetAlpha(clr.CGColor);
    const BOOL opaque       = alpha == 1;
    CGRect rect             = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContextWithOptions(rect.size, opaque, 0);
    CGContextRef context    = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [clr CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image          = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
