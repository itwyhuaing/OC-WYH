//
//  MsgHandlerVC.m
//  JSNativeDemo
//
//  Created by hnbwyh on 2018/4/10.
//  Copyright © 2018年 ZhiXing. All rights reserved.
//

#import "MsgHandlerVC.h"
#import <WebKit/WebKit.h>

@interface MsgHandlerVC ()<WKScriptMessageHandler>

@property (strong,nonatomic) WKWebView     *wkweb;

@end

@implementation MsgHandlerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass(self.class);
    self.view.backgroundColor = [UIColor purpleColor];
    CGRect bounds = [UIScreen mainScreen].bounds;
    self.wkweb = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(bounds), CGRectGetHeight(bounds)/2.0)];
    [self.view addSubview:self.wkweb];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"WKHandlerWeb" ofType:@"html"];
    [self.wkweb loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:filePath]]];
    self.view.backgroundColor = [UIColor purpleColor];
    self.wkweb.backgroundColor = [UIColor cyanColor];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.wkweb.configuration.userContentController addScriptMessageHandler:self name:@"JSMethod"];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.wkweb.configuration.userContentController removeScriptMessageHandlerForName:@"JSMethod"];
}

#pragma mark - WKScriptMessageHandler

-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"JSMethod"]) {
        NSLog(@"\n %@ \n",message.body);
    }
}

@end
