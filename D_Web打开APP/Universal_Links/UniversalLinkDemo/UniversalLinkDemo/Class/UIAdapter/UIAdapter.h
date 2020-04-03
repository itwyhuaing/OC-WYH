//
//  UIAdapter.h
//  hinabian
//
//  Created by hnbwyh on 2019/6/20.
//  Copyright © 2019 深圳市海那边科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAdapter : NSObject

// 宽度
+ (CGFloat)deviceWidth;

// 高度
+ (CGFloat)deviceHeight;

// 750×1334({375,667})       @2x       4.7                      iPhone6/6s/7/7s/8/8s
+ (BOOL)device4_7Inch;

//1242×2208({414,736})      @3x        5.5                       iPhone6P/iPhone7P/iPhone8P
+ (BOOL)device5_5Inch;

//1125×2436({375,812})       @3x        5.8                       iPhoneX/iPhoneXS/iPhone 11 Pro
+ (BOOL)device5_8Inch;

// 828x1792({414,896})         @2x       6.1                      iPhoneXR/iPhone 11
+ (BOOL)device6_1Inch;

//1242x2688({414, 896})        @3x        6.5                     iPhoneX/S  Max、iPhone 11 Pro Max
+ (BOOL)device6_5Inch;

/**
 * 屏幕顶部是否整齐（是否是“刘海屏”）
 * TRUE - 顶部整齐，非刘海屏         FALSE - 顶部不整齐，即“刘海屏”
 */
+ (BOOL)isTidyTopScreen;

// 适配屏幕底部高度
+ (CGFloat)heightToSuitScreenBootom;

// 设备状态栏高度
+ (CGFloat)statusHeight;

// 设备导航栏高度
+ (CGFloat)navHeight;

// 设备底部标签栏高度
+ (CGFloat)tabBarHeight;

// 以 w=375 设备为设计基准
+ (CGFloat)scaleBy375W;

// 以 w=414 设备为设计基准
+ (CGFloat)scaleBy414W;

// 顶部导航栏下边沿与底部标签栏上边沿之间的高度
+ (CGFloat)heightForExTopAndBottom;


/**
 
#define AdLogoHeight (ceilf(IS_IPHONE_X ? (130.0/414.0*SCREEN_WIDTH - TABBAR_OFFSET) : (130.0/375.0*SCREEN_WIDTH)))
 
4.7        750×1334(375 * 667)       @2x        Retina4.7                 iPhone6/6s/7/7s/8/8s
5.5        1242×2208(414 * 736)      @3x        Retina 5.5                 iPhone6P/iPhone7P/iPhone8P
5.8        1125×2436(375 * 812)      @3x        iPhone X/ XS               iPhoneX/iPhoneXS/iPhone 11 Pro
6.1        828x1792(414 * 896)       @2x        iPhoneXR                   iPhoneXR/iPhone 11
6.5        1242x2688(414 * 896)      @3x        iPhoneXMax                 iPhoneX Max/iPhone 11 Pro Max
*/

@end

NS_ASSUME_NONNULL_END
