//
//  JSEditorView.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/12/10.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#import "JSEditorView.h"
#import "WKEditorWeb.h"

@interface JSEditorView () <WKUIDelegate,WKNavigationDelegate>

@property (nonatomic,readwrite,strong) WKEditorWeb          *wkEditor;

@end

@implementation JSEditorView

#pragma mark ------ init

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

#pragma mark ------ Keyboard

- (void)keyboardWillShowOrHide:(NSNotification *)notify{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    NSDictionary *info = notify.userInfo;
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    int curve = [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
    CGRect keyRectEnd = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = UIInterfaceOrientationIsLandscape(orientation) ? ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.000000) ? keyRectEnd.size.height : keyRectEnd.size.width : keyRectEnd.size.height;
    UIViewAnimationOptions animationOptions = curve << 16;
    [self logMessage:[NSString stringWithFormat:@"%s:%@:%@:%@:%@",__FUNCTION__,notify.name,self.wkEditor.inputView,[NSValue valueWithCGRect:keyRectEnd],self.superview]];
    if ([notify.name isEqualToString:UIKeyboardWillShowNotification]) {
        [UIView animateWithDuration:duration delay:0 options:animationOptions animations:^{
            
        } completion:^(BOOL finished) {
            if (_delegate && [_delegate respondsToSelector:@selector(jsEditorView:willShowWithKeyRectEnd:)]) {
                [_delegate jsEditorView:self willShowWithKeyRectEnd:keyRectEnd];
            }
        }];
        
    }else if ([notify.name isEqualToString:UIKeyboardDidShowNotification]) {
        NSLog(@"");
    }else if ([notify.name isEqualToString:UIKeyboardWillHideNotification]){
        [UIView animateWithDuration:duration delay:0 options:animationOptions animations:^{
            
        } completion:^(BOOL finished) {
            if (_delegate && [_delegate respondsToSelector:@selector(jsEditorView:willHideWithKeyRectEnd:)]) {
                [_delegate jsEditorView:self willHideWithKeyRectEnd:keyRectEnd];
            }
        }];
    }else if ([notify.name isEqualToString:UIKeyboardDidHideNotification]) {
        NSLog(@"");
    }
    
}

#pragma mark ------ WKUIDelegate,WKNavigationDelegate

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSString *httpString = navigationAction.request.URL.absoluteString;
    WKNavigationActionPolicy policy = WKNavigationActionPolicyAllow;
    [self logMessage:[NSString stringWithFormat:@"%s:%@",__FUNCTION__,httpString]];
    if ([httpString hasPrefix:@"http"]){
        policy = WKNavigationActionPolicyCancel;
    }else if ([httpString rangeOfString:@"callback://0/"].location != NSNotFound) {
        NSString *className = [httpString stringByReplacingOccurrencesOfString:@"callback://0/" withString:@""];
        if (_navigationDelegate && [_navigationDelegate respondsToSelector:@selector(jsEditorView:navigationActionWithFuncs:)]) {
            [_navigationDelegate jsEditorView:self navigationActionWithFuncs:className];
        }
    }
    decisionHandler(policy);
}


#pragma mark ------ isLog

-(void)setIsLog:(BOOL)isLog {
    _isLog = isLog;
}

- (void)logMessage:(NSString *)msg {
    _isLog ? NSLog(@"\n%s:%@\n\n",__FUNCTION__,msg) : nil;
}

#pragma mark ------ 懒加载

-(WKWebView *)wkEditor{
    if (!_wkEditor) {
        CGRect rect = CGRectZero;
        rect.size = [UIScreen mainScreen].bounds.size;
        rect.size.height -= 64;
        WKWebViewConfiguration *cfg = [[WKWebViewConfiguration alloc] init];
        _wkEditor = [[WKEditorWeb alloc] initWithFrame:rect configuration:cfg];
        _wkEditor.UIDelegate = self;
        _wkEditor.navigationDelegate = self;
    }
    return _wkEditor;
}


#pragma mark ------ UI

- (void)layoutUI {
    [self addSubview:self.wkEditor];
}

- (void)loadContent {
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *htmlPath = [bundle pathForResource:@"editor" ofType:@"html"];
    [self.wkEditor loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:htmlPath]]];
}

-(void)dealloc {
    [self logMessage:[NSString stringWithFormat:@"\n%s\n",__FUNCTION__]];
    [self removeObserver];
}

#pragma mark ------ private method

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


@end
