//
//  WebVC.m
//  DataCacheProject
//
//  Created by hnbwyh on 2018/3/13.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "WebVC.h"
#import <WebKit/WebKit.h>

@interface WebVC () <WKUIDelegate,WKNavigationDelegate>

@end

@implementation WebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGRect rect = CGRectZero;
    rect.size = CGSizeMake(screenSize.width, screenSize.height);
    WKWebViewConfiguration *cfg = [[WKWebViewConfiguration alloc] init];
    WKWebView *web = [[WKWebView alloc] initWithFrame:rect configuration:cfg];
    web.UIDelegate = self;
    web.navigationDelegate = self;
    [self.view addSubview:web];
    NSURL *url = [NSURL URLWithString:@"https://m.hinabian.com/estate.html"];
    NSURLRequest *req = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:10.0];
    [web loadRequest:req];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
