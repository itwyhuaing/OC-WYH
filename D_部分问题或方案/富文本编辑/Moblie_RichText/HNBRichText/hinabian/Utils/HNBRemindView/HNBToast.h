//
//  HNBToast.h
//  hinabian
//
//  Created by hnbwyh on 16/9/1.
//  Copyright © 2016年 &#20313;&#22362;. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 * HNBToastHudOnlyTitleAndDetailText 样式时参数msg的格式 : "title"P&"content"
 */
typedef enum : NSUInteger {
    HNBToastHudWaiting = 90,
    HNBToastHudSuccession,
    HNBToastHudFailure,
    HNBToastHudOnlyText,
    HNBToastHudOnlyTitleAndDetailText,
} HNBToastHudStyle;


@interface HNBToast : NSObject


/**
 * hud 上第一个最上面的子控件距离顶部的偏移
 * hinabian - 扩展
 */
@property (assign, nonatomic) CGFloat y_offset;


/**
 * The minimum size of the HUD bezel. Defaults to CGSizeZero (no minimum size).
 * 默认值 - ; 不设置时即以默认值大小样式展示
 */
@property (assign, nonatomic) CGSize minSize;

/**
 * The minimum size of the HUD bezel. Defaults to CGSizeZero (no minimum size).
 * 默认值 - ; 不设置时即以默认值大小样式展示
 */
@property (assign, nonatomic) CGSize maxSize;

/**
 * 蒙版背景色
 */
@property (strong, nonatomic) UIColor *bgColor;


///**
// * 显示 hud
// * superView - 父视图 - 为空时添加在 window 上
// * msg - 请稍后 
// */
//- (void)showWaitingStatusOnView:(UIView *)superView msg:(NSString *)msg;
//
///**
// * 显示 hud
// * 静态图片 + 文字提示 - 成功（Y） 、 失败 (N)、 故障 (!) 、纯文本
// * superView - 父视图 - 为空时添加在 window 上
// * imgName - 静态图片 - 为空时不显示图片
// * msg - 文本提示信息  - 为空时不显示该hud
// */
//- (void)showOnView:(UIView *)superView imageName:(NSString *)imgName msg:(NSString *)msg;
//
///**
// * 隐藏 hud
// * imgName - 静态图片 - 为空时不显示图片
// * msg - 文本提示信息  - 为空时不显示该hud
// * delay - 延时 - 隐藏该hud之前的延时时长
// */
//- (void)dismissImageName:(NSString *)imgName msg:(NSString *)msg afterDelay:(NSTimeInterval)delay;
//- (void)dismissAfterDelay:(NSTimeInterval)delay;
//- (void)dismiss;
//
//+(instancetype)shareManager;

/**
 * 隐藏 hud
 * superView - 父视图 - 为空时添加在 window 上
 * imgName - 静态图片 - 为空时不显示图片
 * msg - 文本提示信息  - 为空时不显示该hud
 * delay - 延时 - 隐藏该hud之前的延时时长
 */
//- (void)showMesageWithHiddenOnView:(UIView *)superView imageName:(NSString *)imgName msg:(NSString *)msg afterDelay:(NSTimeInterval)delay;

+(instancetype)shareManager;
- (void)toastWithOnView:(UIView *)superView msg:(NSString *)msg afterDelay:(NSTimeInterval)delay style:(HNBToastHudStyle)hudStyle;
- (void)dismiss;

@end
