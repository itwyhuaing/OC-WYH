//
//  JSBridgeVC.m
//  JSNativeDemo
//
//  Created by hnbwyh on 2018/4/10.
//  Copyright © 2018年 ZhiXing. All rights reserved.
//

#import "JSBridgeVC.h"
#import <WebKit/WebKit.h>
#import "WKWebViewJavascriptBridge.h"

@interface JSBridgeVC () <WKUIDelegate,WKNavigationDelegate>

@property (nonatomic,strong)        WKWebView                               *wkweb;
@property (nonatomic,strong)        WKWebViewJavascriptBridge               *webViewBridge;

@end

@implementation JSBridgeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass(self.class);
    self.view.backgroundColor = [UIColor orangeColor];
    
    // Web + Bridge
    self.webViewBridge = [WKWebViewJavascriptBridge bridgeForWebView:self.wkweb];
    [self.webViewBridge setWebViewDelegate:self];
    NSString *budlePath = [[NSBundle mainBundle] pathForResource:@"bridge.html" ofType:nil];
    [self.wkweb loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:budlePath]]];
 
    
    // Button
    CGRect rect = CGRectZero;
    rect.size = CGSizeMake(320, 30);
    rect.origin = CGPointMake((self.view.bounds.size.width - rect.size.width) / 2.0,
                              CGRectGetMaxY(self.wkweb.frame) + 15.0);
    UIButton *btn1 = [self createButtonWithTitle:@"点击Btn调起JS方法 getSomeInfo" rect:rect];
    [btn1 addTarget:self action:@selector(clickEventBtn:) forControlEvents:UIControlEventTouchUpInside];
    rect.size = CGSizeMake(320, 30);
    rect.origin = CGPointMake((self.view.bounds.size.width - rect.size.width) / 2.0,
                              CGRectGetMaxY(btn1.frame) + 15.0);
    UIButton *btn2 = [self createButtonWithTitle:@"点击Btn调起JS方法 Alert" rect:rect];
    [btn1 addTarget:self action:@selector(clickEventBtn:) forControlEvents:UIControlEventTouchUpInside];
    btn1.tag = 100;
    btn2.tag = 200;
    [self.view addSubview:btn1];
    [self.view addSubview:btn2];
    
    // 注册方法
    [self registLocationFunction];
    [self registerGobackFunction];
    
}

-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"\n === Start === \n");
}

-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"\n === Commit === \n");
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"\n === Finish === \n");
}

#pragma mark --- event 

// native 获取 web 信息
- (void)clickEventBtn:(UIButton *)btn{
    if (btn.tag == 100) {
        [self.webViewBridge callHandler:@"getSomeInfo" data:@{@"key":@"v8"} responseCallback:^(id responseData) {
            NSLog(@" getSomeInfo : %@",responseData);
        }];
    }else{
        [self.webViewBridge callHandler:@"testFunc" data:@{@"k6":@"v8"} responseCallback:^(id responseData) {
            NSLog(@" testFunc %@",responseData);
        }];
    }
}


// web 获取 native 信息
- (void)registLocationFunction {
    [self.webViewBridge registerHandler:@"locationClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        // 获取位置信息
        NSString *location = @"广东省深圳市南山区学府路XXXX号";
        // 将结果返回给js
        responseCallback(location);
    }];
}

- (void)registerGobackFunction {
    [self.webViewBridge registerHandler:@"goback" handler:^(id data, WVJBResponseCallback responseCallback) {
       
        if ([self.wkweb canGoBack]) {
            [self.wkweb goBack];
        }else{
            [self.navigationController popViewControllerAnimated:TRUE];
        };
        
    }];
}

#pragma mark --- UI

- (UIButton *)createButtonWithTitle:(NSString *)title rect:(CGRect)rect{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setFrame:rect];
    btn.layer.cornerRadius = rect.size.height / 2.0;
    btn.backgroundColor = [UIColor blackColor];
    return btn;
}

-(WKWebView *)wkweb{
    if (!_wkweb) {
        CGRect rect = self.view.bounds;
        rect.size.height /= 2.0;
        rect.size.height += 80;
        WKWebViewConfiguration *cfg = [[WKWebViewConfiguration alloc] init];
        _wkweb = [[WKWebView alloc] initWithFrame:rect configuration:cfg];
        _wkweb.backgroundColor = [UIColor greenColor];
        _wkweb.navigationDelegate   = (id)self;
        _wkweb.UIDelegate           = (id)self;
        [self.view addSubview:_wkweb];
    }
    return _wkweb;
}

@end
