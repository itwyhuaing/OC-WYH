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

- (void)editableWeb:(WKWebView *)web funcLocation:(JSEditorToolBarFuncLocation)location completion:(evaluateJsCompletion)completion;

- (void)focusEditableWeb:(WKWebView *)web completion:(evaluateJsCompletion)completion;

- (void)blurEditableWeb:(WKWebView *)web completion:(evaluateJsCompletion)completion;

- (void)setWkWebViewShowKeybord;

@end

NS_ASSUME_NONNULL_END
