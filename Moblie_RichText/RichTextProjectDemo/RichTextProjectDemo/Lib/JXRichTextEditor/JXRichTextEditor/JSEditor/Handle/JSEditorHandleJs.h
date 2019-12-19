//
//  JSEditorHandleJs.h
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
@interface JSEditorHandleJs : NSObject

// 是否打印
@property (nonatomic,assign) BOOL isLog;

// js 处理通用方法 - 编辑器格式设置
- (void)formatEditableWeb:(WKWebView *)web
             funcLocation:(JSEditorToolBarFuncType)location
                intention:(OperateIntention)intention
               completion:(evaluateJsCompletion)completion;

// js 处理通用方法 - 直接接收 js
- (void)editableWeb:(WKWebView *)web operatedJs:(NSString *)jsContent completion:(evaluateJsCompletion)completion;

// js 插入图片 - 给定图片路径方式
- (void)editableWeb:(WKWebView *)web
    insertImagePath:(NSString *)iPath
              width:(NSString *)w
             height:(NSString *)h
            sideGap:(NSString *)sGap
          imageSign:(NSString *)imgSign
        loadingPath:(NSString *)lPath
      reLoadingPath:(NSString *)rPath
         deletePath:(NSString *)dPath
         completion:(evaluateJsCompletion)completion;

// js 插入图片 - 图片转化为 data 方式
- (void)editableWeb:(WKWebView *)web
 insertImgBase64Str:(NSString *)string
              width:(NSString *)w
             height:(NSString *)h
            sideGap:(NSString *)sGap
          imageSign:(NSString *)imgSign
        loadingPath:(NSString *)lPath
      reLoadingPath:(NSString *)rPath
         deletePath:(NSString *)dPath
         completion:(evaluateJsCompletion)completion;

// js 移除上传图片成功之后的灰色蒙版
- (void)editableWeb:(WKWebView *)web removeGrayMaskWithImageSign:(NSString *)imgSign completion:(evaluateJsCompletion)completion;

// wkwebiew 处于可编辑状态情况下特殊处理
- (void)setWkWebViewShowKeybord;

@end

NS_ASSUME_NONNULL_END
