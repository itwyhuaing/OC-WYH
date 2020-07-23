
//
//  HTMLTestVC.m
//  JXRichTextDemo
//
//  Created by hnbwyh on 2019/4/19.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "HTMLTestVC.h"
#import <WebKit/WebKit.h>

@interface HTMLTestVC ()
@property (nonatomic,strong) UIWebView *uiweb;
@property (nonatomic,strong) WKWebView *wkweb;
@end

@implementation HTMLTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self showWebWithTheWeb:FALSE];
}

- (void)showWebWithTheWeb:(BOOL)isWkWeb {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"HTMLTestVC.html" ofType:@""];
    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"\n\n %@ \n\n",html);
    if (isWkWeb) {
        [self.wkweb loadHTMLString:html baseURL:[NSURL URLWithString:@""]];
    }else{
        [self.uiweb loadHTMLString:html baseURL:[NSURL URLWithString:@""]];
    }
    
}

-(UIWebView *)uiweb{
    if (!_uiweb) {
        CGRect rect = [UIScreen mainScreen].bounds;
        CGFloat nav_maxY = CGRectGetMaxY(self.navigationController.navigationBar.frame);
        rect.origin.x = 0.0;
        rect.origin.y = nav_maxY;
        rect.size.height -= (nav_maxY + 200);
        _uiweb = [[UIWebView alloc] initWithFrame:rect];
        [self.view addSubview:_uiweb];
    }
    return _uiweb;
}

-(WKWebView *)wkweb{
    if (!_wkweb) {
        CGRect rect = [UIScreen mainScreen].bounds;
        CGFloat nav_maxY = CGRectGetMaxY(self.navigationController.navigationBar.frame);
        rect.origin.x = 0.0;
        rect.origin.y = nav_maxY;
        rect.size.height -= (nav_maxY + 200);
        WKWebViewConfiguration *confg = [[WKWebViewConfiguration alloc] init];
        _wkweb = [[WKWebView alloc] initWithFrame:rect configuration:confg];
        [self.view addSubview:_wkweb];
    }
    return _wkweb;
}

@end
