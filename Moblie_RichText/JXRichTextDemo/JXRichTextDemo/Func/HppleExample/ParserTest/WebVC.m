//
//  WebVC.m
//  JXRichTextDemo
//
//  Created by hnbwyh on 2019/4/17.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "WebVC.h"
#import <WebKit/WebKit.h>
#import "NativeTextViewVC.h"

@interface WebVC ()<WKNavigationDelegate>
{
    NSString *htmlContent;
}
@property (nonatomic,strong) WKWebView *wkweb;
@end

@implementation WebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass(self.class);
    self.view.backgroundColor = [UIColor whiteColor];
    self.wkweb.backgroundColor = [UIColor clearColor];
    for (UIView *v in self.wkweb.scrollView.subviews) {
        if ([NSStringFromClass(v.class) isEqualToString:@"WKContentView"]) {
            v.backgroundColor = [UIColor cyanColor];
        }
    }
    
    [self.view addSubview:self.wkweb];
    [self.wkweb.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:NULL];
    
    [self loadHtmlContent];
}


- (void)loadHtmlContent{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"WebVC" ofType:@"html"];
    NSString *cntHtml = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self extractContentWithHtml:cntHtml];
    [self.wkweb loadHTMLString:cntHtml baseURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    
    NSLog(@"\n高度值获取 \n %f  \n",self.wkweb.scrollView.contentSize.height);
    
}

- (void)extractContentWithHtml:(NSString *)html{
    NSRange r1 = [html rangeOfString:@"<p"];
    NSRange r2 = [html rangeOfString:@"</p>"];
    NSInteger start = r1.location;
    NSInteger end   = r2.location + r2.length;
    NSRange theRange = NSMakeRange(start, end - start);
    htmlContent = [html substringWithRange:theRange];
    NSLog(@"");
}

-(void)dealloc{
    [self.wkweb.scrollView removeObserver:self forKeyPath:@"contentSize"];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NativeTextViewVC *vc = [[NativeTextViewVC alloc] init];
    vc.htmlCnt           = htmlContent;
    [self.navigationController pushViewController:vc animated:TRUE];
    
}

#pragma mark - observer

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"contentSize"] && object == self.wkweb.scrollView) {
        //NSLog(@" \n %s  \n %@ \n",__FUNCTION__,change);
        
    }
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    //NSLog(@" \n 结果-didFinishNavigation \n");
}

#pragma mark - lazy load

-(WKWebView *)wkweb{
    if (!_wkweb) {
        CGFloat maxY = CGRectGetMaxY(self.navigationController.navigationBar.frame);
        CGRect rect = [UIScreen mainScreen].bounds;
        rect.origin.x = 0.0;
        rect.origin.y = maxY;
        rect.size.height -= (200.0 + maxY);
        WKWebViewConfiguration *confg = [[WKWebViewConfiguration alloc] init];
        _wkweb = [[WKWebView alloc] initWithFrame:rect configuration:confg];
        _wkweb.navigationDelegate = self;
    }
    return _wkweb;
}

@end
