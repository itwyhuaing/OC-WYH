//
//  UIColor+JXColor.h
//  JXObjCategary
//
//  Created by hnbwyh on 2018/7/19.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (JXColor)

+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha;
+ (UIColor *)colorWithHexSring:(NSString *)hexString A:(CGFloat)alpha;

+ (UIColor *)colorWithImage:(UIImage *)img;
@end
