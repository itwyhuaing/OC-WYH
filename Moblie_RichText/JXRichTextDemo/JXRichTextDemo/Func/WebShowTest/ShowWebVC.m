//
//  ShowWebVC.m
//  JXRichTextDemo
//
//  Created by hnbwyh on 2019/4/19.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "ShowWebVC.h"
#import <WebKit/WebKit.h>
#import "TextViewShowVC.h"

@interface ShowWebVC ()
{
    NSString *htmlContent;
}

@property (nonatomic,strong) UIWebView *uiweb;
@property (nonatomic,strong) WKWebView *wkweb;

@end

@implementation ShowWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)showWebWithHTMLBody:(NSString *)bodyContent isWkWeb:(BOOL)isWkWeb{
    if (bodyContent) {
        bodyContent = bodyContent;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"ShowWebVC.html" ofType:@""];
        NSString *tmpString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        NSString *html = [tmpString stringByReplacingOccurrencesOfString:@"<!--      bodyContent-->" withString:bodyContent];
        htmlContent = html;
        NSLog(@"\n\n %@ \n\n",html);
        if (isWkWeb) {
            [self.wkweb loadHTMLString:html baseURL:[NSURL URLWithString:@""]];
        }else{
            [self.uiweb loadHTMLString:html baseURL:[NSURL URLWithString:@""]];
        }
    }
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    TextViewShowVC *vc = [[TextViewShowVC alloc] init];
    vc.htmlContent = htmlContent;
    [self.navigationController pushViewController:vc animated:TRUE];
    
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
