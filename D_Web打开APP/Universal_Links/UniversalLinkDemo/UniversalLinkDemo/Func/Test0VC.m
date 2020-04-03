//
//  Test0VC.m
//  UniversalLinkDemo
//
//  Created by hnbwyh on 2020/4/2.
//  Copyright © 2020 JiXia. All rights reserved.
//

#import "Test0VC.h"
#import "UIAdapter.h"
#import <WebKit/WebKit.h>

@interface Test0VC () <WKNavigationDelegate>

@property (strong,nonatomic) WKWebView     *wkweb;

@end

@implementation Test0VC

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect bounds = [UIScreen mainScreen].bounds;
    self.wkweb = [[WKWebView alloc] initWithFrame:CGRectMake(0, [UIAdapter statusHeight] + [UIAdapter navHeight], CGRectGetWidth(bounds), CGRectGetHeight(bounds)/2.0)];
    self.wkweb.navigationDelegate = (id)self;
    [self.view addSubview:self.wkweb];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"meta" ofType:@"html"];
    [self.wkweb loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:filePath]]];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"\n didFinishNavigation \n");
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"\n didFailNavigation \n");
}

@end
