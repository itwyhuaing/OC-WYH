/*
 网络状态判断提示页：四种情况!
 网络状态判断后以下几步：
 第一步：loadWithFrame:(CGRect)frame superView:(UIView *)superV showType:(HNBNetRemindViewShowType)showType delegate:(id<HNBNetRemindViewDelegate>)delegate 添加界面
 
 第二步：代理方法 ，针对不同类型的视图状态进行点击后的下一步处理
 */
//
//  HNBNetRemindView.h
//  hinabian
//
//  Created by hnbwyh on 16/8/3.
//  Copyright © 2016年 &#20313;&#22362;. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 * 提示样式
 * HNBNetRemindViewShowPoorNt             无网络
 * HNBNetRemindViewShowFailNetReq         请求失败
 * HNBNetRemindViewShowFailReleatedData   没有请求到相关数据，用于搜索结果提示
 * HNBNetRemindViewShowFailToShowTip      意外情况，纯文本提醒 （eg:他人个人中心用户不存在请求发生错误）
 */
typedef enum : NSUInteger {
    HNBNetRemindViewShowPoorNet = 10000, 
    HNBNetRemindViewShowFailNetReq,
    HNBNetRemindViewShowFailReleatedData,
    HNBNetRemindViewShowFailToShowTip,
} HNBNetRemindViewShowType;

@class HNBNetRemindView;
/**
 * 点击事件的代理
 */
@protocol HNBNetRemindViewDelegate <NSObject>
@optional
- (void)clickOnNetRemindView:(HNBNetRemindView *)remindView;

@end

@interface HNBNetRemindView : UIView

/** 当前的展示状态
 * TRUE - 展示 ， FALSE - 隐藏
 */
@property (nonatomic,assign) BOOL isStatus;


/**
 * 创建 + 布局 + 添加到父视图
 * frame     创建该 view 的frame
 * superV    父视图
 * showType  样式选择
 * delegate  代理
 */
- (void)loadWithFrame:(CGRect)frame superView:(UIView *)superV showType:(HNBNetRemindViewShowType)showType delegate:(id<HNBNetRemindViewDelegate>)delegate;

/**
 * 外部设置文本提示信息
 * title            提示文本
 * subs             需要标注的文本数组
 */
- (void)setTipWithMsg:(NSString *)title subStringArray:(NSArray *)subs;

@end
