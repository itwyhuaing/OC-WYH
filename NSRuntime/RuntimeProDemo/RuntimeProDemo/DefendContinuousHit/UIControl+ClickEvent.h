//
//  UIControl+ClickEvent.h
//  Share
//
//  Created by hnbwyh on 16/9/8.
//  Copyright © 2016年 hnbwyh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (ClickEvent)

/**
 * 自定义防连击时间间隔
 */
@property (nonatomic,assign) NSTimeInterval custom_acceptEventInterval;

/**
 * 测试属性
 */
@property (nonatomic,copy) NSString *testProperty;

@property (copy, nonatomic) NSString *method;


@end
