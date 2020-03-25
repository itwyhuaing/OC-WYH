//
//  UIView+JXView.h
//  JXObjCategary
//
//  Created by hnbwyh on 2018/9/4.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JXView)


/**
 渲染卡片效果

 @return 具有卡片效果的视图
 */
+ (UIView *)cardStyleView;

/**
 渲染颜色渐变 ： 参考 - https://www.jianshu.com/p/e7c9e94e165b

 @return 具有颜色渐变效果的视图
 */
+ (UIView *)gradeColorViewWithFrame:(CGRect)rect;

@end
