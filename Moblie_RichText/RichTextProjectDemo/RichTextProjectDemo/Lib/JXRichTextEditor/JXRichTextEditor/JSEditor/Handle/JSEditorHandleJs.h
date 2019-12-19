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
// 可编辑 web 实例
@property (nonatomic,strong) WKWebView *handledEditableWeb;

// 是否打印
@property (nonatomic,assign) BOOL isLog;

// js 处理通用方法 - 编辑器格式设置
- (void)formatEditableWebAtFuncLocation:(JSEditorToolBarFuncType)location
                              intention:(OperateIntention)intention
                             completion:(evaluateJsCompletion)completion;

// js 处理通用方法 - 直接接收 js
- (void)editableWebOperatedJs:(NSString *)jsContent completion:(evaluateJsCompletion)completion;

// js 插入图片 - 给定图片路径方式
- (void)editableWebInsertImagePath:(NSString *)iPath
                             width:(NSString *)w
                            height:(NSString *)h
                           sideGap:(NSString *)sGap
                         imageSign:(NSString *)imgSign
                       loadingPath:(NSString *)lPath
                     reLoadingPath:(NSString *)rPath
                        deletePath:(NSString *)dPath
                        completion:(evaluateJsCompletion)completion;

// js 插入图片 - 图片转化为 data 方式
- (void)editableWebInsertImageBase64String:(NSString *)string
                                     width:(NSString *)w
                                    height:(NSString *)h
                                   sideGap:(NSString *)sGap
                                 imageSign:(NSString *)imgSign
                               loadingPath:(NSString *)lPath
                             reLoadingPath:(NSString *)rPath
                                deletePath:(NSString *)dPath
                                completion:(evaluateJsCompletion)completion;

// js 移除上传图片成功之后的灰色蒙版
- (void)removeGrayMaskWithImageSign:(NSString *)imgSign;

// wkwebiew 处于可编辑状态情况下特殊处理
- (void)setWkWebViewShowKeybord;

@end

NS_ASSUME_NONNULL_END
