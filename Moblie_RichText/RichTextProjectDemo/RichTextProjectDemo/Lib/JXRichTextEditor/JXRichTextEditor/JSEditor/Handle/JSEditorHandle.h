//
//  JSEditorHandle.h
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/12/10.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSEditorConfig.h"
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^evaluateJsCompletion)(id info,NSError *error);
@interface JSEditorHandle : NSObject

// js 处理通用方法
- (void)formatEditableWeb:(WKWebView *)web funcLocation:(JSEditorToolBarFuncLocation)location completion:(evaluateJsCompletion)completion;

// js “激活”编辑功能
- (void)focusEditableWeb:(WKWebView *)web completion:(evaluateJsCompletion)completion;

// js "使失效"编辑功能
- (void)blurEditableWeb:(WKWebView *)web completion:(evaluateJsCompletion)completion;

// wkwebiew 处于可编辑状态情况下特殊处理
- (void)setWkWebViewShowKeybord;

// 是否打印
@property (nonatomic,assign) BOOL isLog;

@end

NS_ASSUME_NONNULL_END
