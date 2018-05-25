//
//  WKLoadHtmlVC.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2018/5/18.
//  Copyright © 2018年 hainbwyh. All rights reserved.
//

#import "WKLoadHtmlVC.h"
#import <WebKit/WebKit.h>

@interface WKLoadHtmlVC () <WKNavigationDelegate>

@property (nonatomic,strong) WKWebView *wkweb;
@property (nonatomic,assign) CFTimeInterval startT;

@end

@implementation WKLoadHtmlVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.wkweb];
    [self.wkweb.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:NULL];
    
    [self loadHtmlContent];
    
}


- (void)loadHtmlContent{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"HtmlContent" ofType:@"html"];
    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    CGFloat iw = [UIScreen mainScreen].bounds.size.width - 20;
    NSString *newHtml = @"";
    if ([html rangeOfString:@"<img"].location != NSNotFound) {
        newHtml = [html stringByReplacingOccurrencesOfString:@"<img" withString:[NSString stringWithFormat:@"<img width=\"%f\"",iw]];
    }
    //NSLog(@" \n %@ \n  %@ \n ",html,newHtml);
    self.startT = CFAbsoluteTimeGetCurrent();
    [self.wkweb loadHTMLString:newHtml baseURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    NSLog(@"\n高度值获取 \n%f \n",self.wkweb.scrollView.contentSize.height);
    
}

-(void)dealloc{
    [self.wkweb.scrollView removeObserver:self forKeyPath:@"contentSize"];
}

#pragma mark - observer

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"contentSize"] && object == self.wkweb.scrollView) {
        NSLog(@" \n %s  \n %@  \n 结果：%f\n",__FUNCTION__,change,CFAbsoluteTimeGetCurrent()-self.startT);
        
    }
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@" \n 结果-didFinishNavigation：%f\n",CFAbsoluteTimeGetCurrent()-self.startT);
}

#pragma mark - lazy load

-(WKWebView *)wkweb{
    if (!_wkweb) {
        CGRect rect = self.view.frame;
        rect.origin.x = 10.0;
        rect.size.width -= rect.origin.x * 2.0;
        rect.size.height -= 100.0;
        WKWebViewConfiguration *confg = [[WKWebViewConfiguration alloc] init];
        _wkweb = [[WKWebView alloc] initWithFrame:rect configuration:confg];
        _wkweb.backgroundColor = [UIColor greenColor];
        _wkweb.navigationDelegate = self;
    }
    return _wkweb;
}

@end
