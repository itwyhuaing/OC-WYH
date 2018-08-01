//
//  UIColor+JXColor.h
//  JXObjCategary
//
//  Created by hnbwyh on 2018/7/19.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (JXColor)


/**
 RGB 样式 或 16 进制方式设置颜色
 */
+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha;
+ (UIColor *)colorWithHexSring:(NSString *)hexString A:(CGFloat)alpha;


/**
 依据图片获取颜色

 @param img 当前给定的图片
 @return 计算获得的图片颜色
 */
+ (UIColor *)colorWithImage:(UIImage *)img;


/**
 依据图片上的位置获取颜色

 @param point 位置
 @return 计算获取到的位置颜色
 */
+ (UIColor *)colorAtLocation:(CGPoint)point;

@end
