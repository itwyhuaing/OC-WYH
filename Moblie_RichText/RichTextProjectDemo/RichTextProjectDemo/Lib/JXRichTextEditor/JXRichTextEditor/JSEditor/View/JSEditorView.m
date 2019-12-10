//
//  JSEditorView.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/12/10.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#import "JSEditorView.h"
#import <WebKit/WebKit.h>


@interface JSEditorView () <WKUIDelegate,WKNavigationDelegate>

@property (nonatomic,strong) WKWebView          *wkEditor;

@end

@implementation JSEditorView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutUI];
        [self loadContent];
        [self addObserver];
    }
    return self;
}

- (void)layoutUI {
    [self addSubview:self.wkEditor];
}


- (void)loadContent {
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *htmlPath = [bundle pathForResource:@"editor" ofType:@"html"];
    [self.wkEditor loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:htmlPath]]];
}

-(void)dealloc {
    [self removeObserver];
}

- (void)addObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShowOrHide:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShowOrHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}


- (void)removeObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


#pragma mark ------ Keyboard

- (void)keyboardWillShowOrHide:(NSNotification *)notify{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    NSDictionary *info = notify.userInfo;
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    int curve = [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
    CGRect keyRectEnd = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = UIInterfaceOrientationIsLandscape(orientation) ? ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.000000) ? keyRectEnd.size.height : keyRectEnd.size.width : keyRectEnd.size.height;
    UIViewAnimationOptions animationOptions = curve << 16;
    
    //const int extraHeight = 0;// 10;
    if ([notify.name isEqualToString:UIKeyboardWillShowNotification]) {
        [UIView animateWithDuration:duration delay:0 options:animationOptions animations:^{
            
        } completion:^(BOOL finished) {
            //[self upDateToolBarFrameOriginY:CGRectGetMaxY(self.frame) - keyboardHeight - TOOL_BAR_HEIGHT];
//            toolBarDownStatus = FALSE;
            if (_delegate && [_delegate respondsToSelector:@selector(jsEditorView:willShowKeyboardWithHeight:)]) {
                [_delegate jsEditorView:self willShowKeyboardWithHeight:keyboardHeight];
            }
        }];
        
    } else {
        [UIView animateWithDuration:duration delay:0 options:animationOptions animations:^{
            
        } completion:^(BOOL finished) {
//            [self upDateToolBarFrameOriginY:CGRectGetMaxY(self.frame) - TOOL_BAR_HEIGHT];
//            toolBarDownStatus = TRUE;
            if (_delegate && [_delegate respondsToSelector:@selector(jsEditorView:willHideKeyboardWithHeight:)]) {
                [_delegate jsEditorView:self willHideKeyboardWithHeight:keyboardHeight];
            }
        }];
    }
    
}

#pragma mark ------ delegate

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSString *httpString = navigationAction.request.URL.absoluteString;
    NSLog(@" \n \n \n \n  ===decidePolicyForNavigationAction===  \n %@ \n \n \n \n",httpString);
    if ([httpString hasPrefix:@"http"]) {
        decisionHandler(WKNavigationActionPolicyCancel);
    } else if ([httpString rangeOfString:@"callback://0/"].location != NSNotFound) {
        NSString *className = [httpString stringByReplacingOccurrencesOfString:@"callback://0/" withString:@""];
        //[self updateToolBarWithButtonName:className];
        if (_delegate && [_delegate respondsToSelector:@selector(jsEditorView:navigationActionWithFuncs:)]) {
            [_delegate jsEditorView:self navigationActionWithFuncs:className];
        }
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

//-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
//    NSLog(@" ===didFinishNavigation=== ");
//    NSString *js = @"alerShow()";
//    [self.wkEditor evaluateJavaScript:js completionHandler:^(id _Nullable info, NSError * _Nullable error) {
//        NSLog(@" \n \n alerShow :%@ \n \n",info);
//    }];
//}

#pragma mark ------ 懒加载

-(WKWebView *)wkEditor{
    if (!_wkEditor) {
        CGRect rect = CGRectZero;
        rect.size = [UIScreen mainScreen].bounds.size;
        rect.size.height -= 64;
        WKWebViewConfiguration *cfg = [[WKWebViewConfiguration alloc] init];
        _wkEditor = [[WKWebView alloc] initWithFrame:rect configuration:cfg];
        _wkEditor.UIDelegate = self;
        _wkEditor.navigationDelegate = self;
    }
    return _wkEditor;
}

@end
