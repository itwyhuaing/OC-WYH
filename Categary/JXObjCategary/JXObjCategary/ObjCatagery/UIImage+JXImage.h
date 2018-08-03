//
//  UIImage+JXImage.h
//  JXObjCategary
//
//  Created by hnbwyh on 2018/7/19.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JXImage)


/**
 将给定的图片处理为自定义大小的图片

 @param orgImg 待处理图片
 @param size 目标尺寸
 @return 处理之后的图片
 */
+ (UIImage *)customImageWithOriginImage:(UIImage *)orgImg toSize:(CGSize)size;


/**
 依据给定的颜色生产图片

 @param clr 指定颜色
 @return 生成的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)clr;

@end
