//
//  WKWebVC.m
//  JSNativeDemo1
//
//  Created by hnbwyh on 2017/9/22.
//  Copyright © 2017年 hainbwyh. All rights reserved.
//

#import "WKWebVC.h"
#import <WebKit/WebKit.h>

static NSString *JSMethod           = @"JSMethod";
static NSString *openWXAPP       = @"openWXAPP";

@interface WKWebVC () <WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>

@property (nonatomic,strong) WKWebView *wkweb;

@property (nonatomic,strong) UIView *nativeHolder;

@property (nonatomic,strong) UILabel *msgTip;

@end

@implementation WKWebVC

#pragma mark ------------ life

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *htmlPath = [bundle pathForResource:@"jsoc" ofType:@"html"];
    _req = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:htmlPath]];
    
    
    CGRect rect = self.view.bounds;
    rect.size.height /= 2.0;
    rect.size.height += 80;
    WKWebViewConfiguration *cfg = [[WKWebViewConfiguration alloc] init];
    _wkweb = [[WKWebView alloc] initWithFrame:rect configuration:cfg];
    _wkweb.backgroundColor = [UIColor greenColor];
    _wkweb.navigationDelegate = self;
    _wkweb.UIDelegate = self;
    [self.view addSubview:_wkweb];
    
    [_wkweb.configuration.userContentController addScriptMessageHandler:self name:JSMethod];
    [_wkweb.configuration.userContentController addScriptMessageHandler:self name:openWXAPP];
    
    [self showUI];
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)showUI{
    [self.wkweb loadRequest:self.req];
    self.nativeHolder = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                      CGRectGetMaxY(self.wkweb.frame),
                                                      self.view.bounds.size.width,
                                                      self.view.bounds.size.height/2.0)];
    [self.view addSubview:self.nativeHolder];
    
    
    CGRect rect = CGRectZero;
    rect.size.width = [UIScreen mainScreen].bounds.size.width;
    rect.size.height = 80.0;
    UILabel *des = [[UILabel alloc] initWithFrame:rect];
    des.textColor = [UIColor blackColor];
    des.numberOfLines = 0;
    des.font = [UIFont systemFontOfSize:15.0];
    des.text = @" native 调用原生方法及传参给 web ： \n - (void)evaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))completionHandler";
    
    rect.size = CGSizeMake(300, 30);
    rect.origin = CGPointMake((self.view.bounds.size.width - rect.size.width) / 2.0,
                              CGRectGetMaxY(des.frame) + 15.0);
    UIButton *btn1 = [self createButtonWithTitle:@"点击UIButton调起JS方法,修改HTML" rect:rect];
    [btn1 addTarget:self action:@selector(clickBtn1:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.nativeHolder addSubview:des];
    [self.nativeHolder addSubview:btn1];
    
    self.wkweb.backgroundColor = [UIColor redColor];
    self.nativeHolder.backgroundColor = [UIColor greenColor];

}

- (UIButton *)createButtonWithTitle:(NSString *)title rect:(CGRect)rect{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setFrame:rect];
    btn.layer.cornerRadius = rect.size.height / 2.0;
    btn.backgroundColor = [UIColor blackColor];
    return btn;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.wkweb.configuration.userContentController removeScriptMessageHandlerForName:JSMethod];
    [self.wkweb.configuration.userContentController removeScriptMessageHandlerForName:openWXAPP];
}

#pragma mark ------------ WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSString *URLString = navigationAction.request.URL.absoluteString;
    NSLog(@" \n \n %s - %@\n \n",__func__,URLString);
    WKNavigationActionPolicy policy = WKNavigationActionPolicyAllow;
    if ([URLString hasPrefix:@"http://www.baidu.com"]) {
        [self showNavTipWithMsg:URLString];
        policy = WKNavigationActionPolicyCancel;
    }
    decisionHandler(policy);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSLog(@" \n \n %s \n \n",__func__);
    decisionHandler(WKNavigationResponsePolicyAllow);
}


- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@" \n \n %s \n \n",__func__);
}


- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@" \n \n %s \n \n",__func__);
}


- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@" \n \n %s \n \n",__func__);
}


- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@" \n \n %s \n \n",__func__);
}


- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@" \n \n %s \n \n",__func__);
}




#pragma mark ------------ WKUIDelegate

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"alert - 展示 JS 函数"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
    
}

#pragma mark ------------ WKScriptMessageHandler

-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"\n \n %@ \n \n %@ \n \n %@ \n \n",message.body,message.frameInfo,message.name);
    if ([message.name isEqualToString:JSMethod]) {
        
    }
    
    if ([message.name isEqualToString:openWXAPP]) {
        // info.plist 文件需要先配置 LSApplicationQueriesSchemes 白名单
        NSArray *cntData = [message.body objectForKey:@"content"];
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",cntData.firstObject]]] ||
            [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",cntData.lastObject]]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",cntData.firstObject]]];
        }
    }
    
}

#pragma mark ------------

#pragma mark ------------ private method


- (void)clickBtn1:(UIButton *)btn{
    NSString *para1 = @"pstring";
    NSArray  *dict  = @{
                        @"key1":@"V1",
                        @"key2":@"V2"
                        };
    NSArray *arr = @[@"a1",@"a2"];
    NSString *dict2 = @"{k1:\"value1\",k2:\"value2\"}";
    
    // str
    NSString *js = [NSString stringWithFormat:@"testDivText(\"%@\");",para1];
    
    // str - dic
    NSString *js2 = [NSString stringWithFormat:@"testDivTextAndDic(\"%@\",%@);",para1,dict2];
    
    // str - arr
    NSString *js3 = [NSString stringWithFormat:@"testDivTextAndArr(\"%@\",%@);",para1,arr];
    
    // 只传 字符串
    [self.wkweb evaluateJavaScript:js completionHandler:^(id _Nullable info, NSError * _Nullable error) {
        NSLog(@" \n \n info :%@ \n \n",info);
    }];
    
    // 传 字符串 - 字典
//    [self.wkweb evaluateJavaScript:js2 completionHandler:^(id _Nullable info, NSError * _Nullable error) {
//        NSLog(@" \n \n info :%@ \n \n",info);
//    }];
    
    // 传 字符串 - 数组 -
//    [self.wkweb evaluateJavaScript:js3 completionHandler:^(id _Nullable info, NSError * _Nullable error) {
//        NSLog(@" \n \n info :%@ \n \n",info);
//    }];
    
}

- (void)showNavTipWithMsg:(NSString *)msg{
    self.msgTip.text = [NSString stringWithFormat:@"拦截:%@",msg];
    
    CGRect rect = self.msgTip.frame;
    rect.origin.y = 0;
    [UIView animateWithDuration:1.0 animations:^{
        [self.msgTip setFrame:rect];
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            [self.msgTip setFrame:CGRectMake(rect.origin.x, rect.origin.y - rect.size.height, rect.size.width, rect.size.height)];
        }];
    });
    
}

#pragma mark ------------ 懒加载

-(UILabel *)msgTip{
    if (!_msgTip) {
        _msgTip = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 36.0)];
        _msgTip.font = [UIFont systemFontOfSize:18.0];
        _msgTip.backgroundColor = [UIColor grayColor];
        _msgTip.textColor = [UIColor whiteColor];
        _msgTip.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_msgTip];
    }
    return _msgTip;
}

@end
