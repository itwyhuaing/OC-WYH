//
//  JSEditorHandle.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/12/10.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#import "JSEditorHandle.h"
#import <objc/runtime.h>

static void (*originalIMP)(id self, SEL _cmd, void* arg0, BOOL arg1, BOOL arg2, id arg3) = NULL;
void interceptIMP (id self, SEL _cmd, void* arg0, BOOL arg1, BOOL arg2, id arg3) {
    originalIMP(self, _cmd, arg0, TRUE, arg2, arg3);
}

@implementation JSEditorHandle

#pragma mark - common js handle

-(void)formatEditableWeb:(WKWebView *)web funcLocation:(JSEditorToolBarFuncLocation)location completion:(evaluateJsCompletion)completion {
    NSString *js = @"";
    if (location == JSEditorToolBarInsertImage) {
        
    }
    else if (location == JSEditorToolBarBold) {
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
    }
    [web evaluateJavaScript:js completionHandler:completion];
}


#pragma mark - js 控制键盘

- (void)focusEditableWeb:(WKWebView *)web completion:(evaluateJsCompletion)completion{
    NSString *js = [NSString stringWithFormat:@"zss_editor.focusEditor();"];
    [web evaluateJavaScript:js completionHandler:completion];
}

- (void)blurEditableWeb:(WKWebView *)web completion:(evaluateJsCompletion)completion{
    NSString *js = [NSString stringWithFormat:@"zss_editor.blurEditor();"];
    [web evaluateJavaScript:js completionHandler:completion];
}


-(void)insertImageFromDevice:(UIButton *)btn{

}


#pragma mark - WKWebView 处理 JS focus() 函数问题
/**
 可参考1：https://stackoverflow.com/questions/32407185/wkwebview-cant-open-keyboard-for-input-field
 可参考2：http://www.jianshu.com/p/c7bd2af5005b
 **/

- (void)setWkWebViewShowKeybord {
    Class cls = NSClassFromString(@"WKContentView");
    SEL originalSelector = NSSelectorFromString(@"_startAssistingNode:userIsInteracting:blurPreviousNode:userObject:");
    Method originalMethod = class_getInstanceMethod(cls, originalSelector);
    IMP impOvverride = (IMP) interceptIMP;
    originalIMP = (void *)method_getImplementation(originalMethod);
    method_setImplementation(originalMethod, impOvverride);
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
