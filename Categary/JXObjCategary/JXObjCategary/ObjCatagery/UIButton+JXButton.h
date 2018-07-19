//
//  UIButton+JXButton.h
//  JXObjCategary
//
//  Created by hnbwyh on 2018/7/16.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (JXButton)

/**
 为 UIButton 类新增防连击属性，设置该值即为防连击间隔
 */
@property (nonatomic,assign) NSTimeInterval acceptEventCustomInterval;

@end
