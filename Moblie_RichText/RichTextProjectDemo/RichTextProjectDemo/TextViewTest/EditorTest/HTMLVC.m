//
//  HTMLVC.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/4/10.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#import "HTMLVC.h"
#import <WebKit/WebKit.h>

@interface HTMLVC ()<WKNavigationDelegate>

@property (nonatomic,strong) WKWebView *wkweb;

@end

@implementation HTMLVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    self.wkweb.scrollView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    
    [self.view addSubview:self.wkweb];
    [self.wkweb.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:NULL];
    
    [self loadHtmlContent];
    
}


- (void)loadHtmlContent{
    
    if (self.cntHtml == nil || self.cntHtml.length <= 0) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"cnt" ofType:@"html"];
        self.cntHtml = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    }
    [self.wkweb loadHTMLString:self.cntHtml baseURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    
    NSLog(@"\n高度值获取 \n %f  \n %@ \n",self.wkweb.scrollView.contentSize.height,self.cntHtml);
    
}

-(void)dealloc{
    [self.wkweb.scrollView removeObserver:self forKeyPath:@"contentSize"];
}

#pragma mark - observer

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"contentSize"] && object == self.wkweb.scrollView) {
        //NSLog(@" \n %s  \n %@ \n",__FUNCTION__,change);
        
    }
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@" \n 结果-didFinishNavigation \n");
}

#pragma mark - lazy load

-(WKWebView *)wkweb{
    if (!_wkweb) {
        CGRect rect = self.view.frame;
        rect.origin.x = 0.0;
        rect.origin.y = 100.0;
        rect.size.height -= 100.0;
        WKWebViewConfiguration *confg = [[WKWebViewConfiguration alloc] init];
        _wkweb = [[WKWebView alloc] initWithFrame:rect configuration:confg];
        _wkweb.backgroundColor = [UIColor cyanColor];
        _wkweb.navigationDelegate = self;
    }
    return _wkweb;
}

@end
