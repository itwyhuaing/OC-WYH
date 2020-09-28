//
//  XpathFilter.m
//  hinabian
//
//  Created by hnbwyh on 2020/8/18.
//  Copyright © 2020 深圳市海那边科技有限公司. All rights reserved.
//

#import "XpathFilter.h"
#import <WebKit/WebKit.h>

@interface XpathFilter ()

{
    
    double excount;
    // 次数过滤
    NSInteger excountFor_UIButtonBarButton;         // 美洽咨询页面-返回按钮 - 2
    NSInteger excountForUITabBarButton;             // 底部 Tab 点击 - 4
    NSInteger excountForUITapForUIImageV;           // UIImageView - Tap 手势 - 2
    
    // 时间过滤
    NSTimeInterval timeValueForScroll;              // 滚动
    
}

@end

@implementation XpathFilter

+ (instancetype)currentXpathFilter {
    static XpathFilter *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [XpathFilter new];
    });
    return instance;
}

-(void)filterForObj:(id)obj analyzationType:(AnalyzationType)type completion:(void (^)(UIView * _Nonnull, BOOL))completion {
    [self filterForObj:obj analyzationType:type completion:completion];
}

-(void)filterForObj:(id)obj analyzationType:(AnalyzationType)type gesture:(UIGestureRecognizer *)gesture completion:(void (^)(UIView * _Nonnull, BOOL))completion {
    if (obj && [obj isKindOfClass:[UIView class]]) {
        UIView *v = (UIView *)obj;
        BOOL p = TRUE;
        if (type == AnalyzationUIControlType) {
            p = [self permitForAnalyzationUIControl:v];
        }else if (type == AnalyzationUIViewType){
            p = [self permitForAnalyzationUIView:v];
        }else if (type == AnalyzationUITableViewType){
            p = [self permitForAnalyzationUITableView:v];
        }else if (type == AnalyzationUICollectionViewType){
            p = [self permitForAnalyzationUICollectionView:v];
        }else if (type == AnalyzationUIGestureType){
            p = [self permitForAnalyzationUIView:v gesture:gesture];
        }else {
            
        }
        
        if (p) {
            completion(v,p);
        }else {
            NSLog(@"\n hooktest-当前次数:%f,不准许,当前栈顶对象:%@, \n",excount,obj);
        }
    }else {
        NSLog(@"\n hooktest不存在期待的View-当前栈顶对象 :%@ \n",obj);
    }
}


// 特殊情况的处理
- (BOOL)permitForAnalyzationUIControl:(UIView *)view {
    BOOL rlt = TRUE;
    if (view) {
        if ([@"WKContentView" isEqualToString:NSStringFromClass(view.class)]) {
            rlt = FALSE;
        }
        
        // 次数 - 2 ; 位置：美洽咨询页面-返回按钮
        if ([@"_UIButtonBarButton" isEqualToString:NSStringFromClass(view.class)]) {
            excountFor_UIButtonBarButton ++;
            NSLog(@"\nhooktest-计算excountFor_UIButtonBarButton+1:%ld\n",excountFor_UIButtonBarButton);
            if (excountFor_UIButtonBarButton < 2) {
                rlt = FALSE;
            }else {
                NSLog(@"\nhooktest-次数置空前:%ld\n",excountFor_UIButtonBarButton);
                excountFor_UIButtonBarButton = 0;
            }
            excount = excountFor_UIButtonBarButton;
        }
        
        
        // 次数 - 4 ; 位置：底部 Tab 点击
        if ([@"UITabBarButton" isEqualToString:NSStringFromClass(view.class)]) {
            excountForUITabBarButton ++;
            NSLog(@"\nhooktest-计算excountForUITabBarButton+1:%ld\n",excountForUITabBarButton);
            if (excountForUITabBarButton < 4) {
                rlt = FALSE;
            }else {
                NSLog(@"\n hooktest-次数置空前:%ld\n",excountForUITabBarButton);
                excountForUITabBarButton = 0;
            }
            excount = @(excountForUITabBarButton).doubleValue;
        }
        
    }
    return rlt;
}

// 特殊情况的处理
- (BOOL)permitForAnalyzationUIView:(UIView *)view {
    BOOL rlt = TRUE;
    // 次数 - 2
    excountForUITapForUIImageV ++;
    NSLog(@"\nhooktest-计算excountForUITapForUIImageV+1:%ld\n",excountForUITapForUIImageV);
    if (excountForUITapForUIImageV < 2) {
        rlt = FALSE;
    }else {
        NSLog(@"\nhooktest-次数置空前:%ld\n",excountForUITapForUIImageV);
        excountForUITapForUIImageV = 0;
    }
    excount = excountForUITapForUIImageV;
    return rlt;
}

// 特殊情况的处理
- (BOOL)permitForAnalyzationUITableView:(UIView *)view {
    BOOL rlt = TRUE;
    return rlt;
}

// 特殊情况的处理
- (BOOL)permitForAnalyzationUICollectionView:(UIView *)view {
    BOOL rlt = TRUE;
    return rlt;
}

// 特殊情况的处理
- (BOOL)permitForAnalyzationUIView:(UIView *)view gesture:(UIGestureRecognizer *)gesture{
    BOOL rlt = TRUE;
    // 滚动 - 0.03 秒
    if ([NSStringFromClass(gesture.class) isEqualToString:@"UIScrollViewPanGestureRecognizer"]) {
        if (timeValueForScroll <= 0.0) {
            timeValueForScroll = NSDate.date.timeIntervalSince1970;
        }
        NSTimeInterval t = NSDate.date.timeIntervalSince1970;
        if (t - timeValueForScroll < 0.002) {
            rlt = FALSE;
        }else {
            NSLog(@"\n hooktest-时间置空前:%f\n",timeValueForScroll);
            timeValueForScroll = 0.0;
        }
        excount = timeValueForScroll;
    }
    return rlt;
}

@end
