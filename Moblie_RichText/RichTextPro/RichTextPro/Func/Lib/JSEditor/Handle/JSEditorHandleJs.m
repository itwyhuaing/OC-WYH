//
//  JSEditorHandleJs.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/12/10.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#import "JSEditorHandleJs.h"
#import <objc/runtime.h>

static void (*originalIMP)(id self, SEL _cmd, void* arg0, BOOL arg1, BOOL arg2, id arg3) = NULL;
void interceptIMP (id self, SEL _cmd, void* arg0, BOOL arg1, BOOL arg2, id arg3) {
    originalIMP(self, _cmd, arg0, TRUE, arg2, arg3);
}

@implementation JSEditorHandleJs

#pragma mark - common js handle

-(void)formatEditableWeb:(WKWebView *)web funcLocation:(JSEditorToolBarFuncType)location intention:(OperateIntention)intention completion:(evaluateJsCompletion)completion {
    NSString *js = @"";
    if (location == JSEditorToolBarBold) {
        js = @"zss_editor.setBold();";
    }
    else if (location == JSEditorToolBarItalic) {
        js = @"zss_editor.setItalic();";
    }
    else if (location == JSEditorToolBarStrikethrough) {
        js = @"zss_editor.setStrikeThrough();";
    }
    else if (location == JSEditorToolBarH1) {
        js = @"zss_editor.setHeading('h1');";
    }
    else if (location == JSEditorToolBarH2) {
        js = @"zss_editor.setHeading('h2');"; 
    }
    else if (location == JSEditorToolBarH3) {
        js = @"zss_editor.setHeading('h3');";
    }
    else if (location == JSEditorToolBarH4) {
        js = @"zss_editor.setHeading('h4');";
    }else if (location == JSEditorToolBarKeyBaord){ // js 控制键盘
        if (intention == OperateIntentionON) {
            js = [NSString stringWithFormat:@"zss_editor.focusEditor();"];
        }else{
            js = [NSString stringWithFormat:@"zss_editor.blurEditor();"];
        }
    }
    [self editableWeb:web operatedJs:js completion:completion];
}


-(void)editableWeb:(WKWebView *)web operatedJs:(NSString *)jsContent completion:(evaluateJsCompletion)completion {
    [web evaluateJavaScript:jsContent completionHandler:completion];
}

- (void)editableWeb:(WKWebView *)web
    insertImagePath:(NSString *)iPath
              width:(NSString *)w
             height:(NSString *)h
            sideGap:(NSString *)sGap
          imageSign:(NSString *)imgSign
        loadingPath:(NSString *)lPath
      reLoadingPath:(NSString *)rPath
         deletePath:(NSString *)dPath
         completion:(evaluateJsCompletion)completion {
    __weak typeof(self) weakSelf = self;
    [self prepareInsertEditableWeb:web completion:^(id  _Nonnull info, NSError * _Nonnull error) {
        NSString *js = [NSString stringWithFormat:@"zss_editor.insertImage(\"%@\", \"%@\", \"%@\", \"%@\",\"%@\",\"%@\");", [NSURL fileURLWithPath:iPath].absoluteString, w,h,imgSign,[NSURL fileURLWithPath:lPath].absoluteString,sGap];
        [weakSelf editableWeb:web operatedJs:js completion:^(id  _Nonnull info, NSError * _Nonnull error) {
            completion ? completion(info,error) : nil;
        }];
    }];
}

- (void)editableWeb:(WKWebView *)web
 insertImgBase64Str:(NSString *)string
              width:(NSString *)w
             height:(NSString *)h
            sideGap:(NSString *)sGap
          imageSign:(NSString *)imgSign
        loadingPath:(NSString *)lPath
      reLoadingPath:(NSString *)rPath
         deletePath:(NSString *)dPath
         completion:(evaluateJsCompletion)completion {
    __weak typeof(self) weakSelf = self;
    [self prepareInsertEditableWeb:web completion:^(id  _Nonnull info, NSError * _Nonnull error) {
        NSString *js = [NSString stringWithFormat:@"zss_editor.insertImageBase64String(\"%@\", \"%@\", \"%@\", \"%@\",\"%@\",\"%@\");", string, w,h,imgSign,[NSURL fileURLWithPath:lPath].absoluteString,sGap];
        [weakSelf editableWeb:web operatedJs:js completion:^(id  _Nonnull info, NSError * _Nonnull error) {
            completion ? completion(info,error) : nil;
        }];
    }];
}

- (void)originalContentDOMForEditableWeb:(WKWebView *)web completion:(evaluateJsCompletion)completion {
    NSString *js = @"zss_editor.getOriginalDOM();";
     [self editableWeb:web operatedJs:js completion:^(id  _Nonnull info, NSError * _Nonnull error) {
         completion ? completion(info,error) : nil;
    }];
}


#pragma mark -

-(void)prepareInsertEditableWeb:(WKWebView *)web completion:(evaluateJsCompletion)completion {
    NSString *js = @"zss_editor.prepareInsert();";
    [self editableWeb:web operatedJs:js completion:completion];
}

- (void)editableWeb:(WKWebView *)web removeGrayMaskWithImageSign:(NSString *)imgSign completion:(evaluateJsCompletion)completion {
    NSString *js = [NSString stringWithFormat:@"zss_editor.removeGrayMaskWithElementID(\"%@\");",imgSign];
    [self editableWeb:web operatedJs:js completion:completion];
}

- (void)handleTest:(WKWebView *)web {
    NSString *js = @"zss_editor.handleTest()";
    [self editableWeb:web operatedJs:js completion:^(id  _Nonnull info, NSError * _Nonnull error) {
        NSLog(@"\n %s \n\n %@ \n %@ \n",__FUNCTION__,info,error);
    }];
}

#pragma mark - WKWebView 处理 JS focus() 函数问题
/**
 可参考1：https://stackoverflow.com/questions/32407185/wkwebview-cant-open-keyboard-for-input-field
 可参考2：http://www.jianshu.com/p/c7bd2af5005b
 **/

- (void)setWkWebViewShowKeybord {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = NSClassFromString(@"WKContentView");
        SEL originalSelector = NSSelectorFromString(@"_startAssistingNode:userIsInteracting:blurPreviousNode:userObject:");
        Method originalMethod = class_getInstanceMethod(cls, originalSelector);
        IMP impOvverride = (IMP) interceptIMP;
        originalIMP = (void *)method_getImplementation(originalMethod);
        method_setImplementation(originalMethod, impOvverride);
    });
}

#pragma mark ------ isLog

-(void)setIsLog:(BOOL)isLog {
    _isLog = isLog;
}

- (void)logMessage:(NSString *)msg {
    _isLog ? NSLog(@"\n%s:%@\n\n",__FUNCTION__,msg) : nil;
}

#pragma mark ------ dealloc

-(void)dealloc {
    [self logMessage:[NSString stringWithFormat:@"\n%s\n",__FUNCTION__]];
}

@end
