//
//  ConsoleLogVC.m
//  JSNativeDemo
//
//  Created by hnbwyh on 2019/7/5.
//  Copyright © 2019 ZhiXing. All rights reserved.
//

#import "ConsoleLogVC.h"
#import <WebKit/WebKit.h>
#import "JXWKWeb.h"

@interface ConsoleLogVC () <WKScriptMessageHandler>

@property (strong,nonatomic) JXWKWeb     *wkweb;

@end

@implementation ConsoleLogVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass(self.class);
    self.view.backgroundColor = [UIColor purpleColor];
    CGRect bounds = [UIScreen mainScreen].bounds;
    WKWebViewConfiguration *cfg = [[WKWebViewConfiguration alloc] init];
    self.wkweb = [[JXWKWeb alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(bounds), CGRectGetHeight(bounds)/2.0) configuration:cfg];
    
    // ======
    NSString *js = @"console.log = (function(originFunc){\
                                        return function(info) {\
                                            window.webkit.messageHandlers.log.postMessage(info);\
                                        }\
                                    })(console.log)";
    
    //injected the method when H5 starts to create the DOM tree
    [cfg.userContentController addUserScript:[[WKUserScript alloc] initWithSource:js
                                                                    injectionTime:WKUserScriptInjectionTimeAtDocumentStart
                                                                 forMainFrameOnly:TRUE]];
    // ======
    
    [self.view addSubview:self.wkweb];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"logweb" ofType:@"html"];
    [self.wkweb loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:filePath]]];
    self.view.backgroundColor = [UIColor purpleColor];
    self.wkweb.backgroundColor = [UIColor cyanColor];
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.wkweb.configuration.userContentController addScriptMessageHandler:self name:@"name"];
    [self.wkweb.configuration.userContentController addScriptMessageHandler:self name:@"test"];
}


-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.wkweb.configuration.userContentController removeScriptMessageHandlerForName:@"name"];
}


#pragma mark - WKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"log"]) {
        NSLog(@" 打印：%@",message.body);
    }else if ([message.name isEqualToString:@"test"]) {
        NSLog(@" 打印：%@",message.name);
    }
}

@end
