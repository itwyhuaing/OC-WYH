//
//  JSCoreVC.m
//  JSNativeDemo
//
//  Created by hnbwyh on 2018/4/10.
//  Copyright © 2018年 ZhiXing. All rights reserved.
//

#import "JSCoreVC.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface JSCoreVC ()<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic,strong) WKWebView *wkweb;

@end

@implementation JSCoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass(self.class);
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // 添加 web
    WKWebViewConfiguration *cfg = [[WKWebViewConfiguration alloc] init];
    _wkweb = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:cfg];
    [self.view addSubview:_wkweb];
    _wkweb.UIDelegate = (id)self;
    _wkweb.navigationDelegate = (id)self;
    
    // 加载页面
    NSString *path = [[NSBundle mainBundle] pathForResource:@"jscore.html" ofType:nil];
    NSURL    *URLString = [NSURL fileURLWithPath:path];
    [self.wkweb loadRequest:[NSURLRequest requestWithURL:URLString]];
    
}

-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"\n %s \n",__FUNCTION__);
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"\n %s \n",__FUNCTION__);
}

-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"\n %s \n",__FUNCTION__);
}

@end
