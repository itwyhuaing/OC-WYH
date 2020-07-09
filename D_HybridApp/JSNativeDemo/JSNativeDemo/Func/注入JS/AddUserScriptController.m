//
//  AddUserScriptController.m
//  JSNativeDemo
//
//  Created by hnbwyh on 2020/7/6.
//  Copyright © 2020 ZhiXing. All rights reserved.
//

#import "AddUserScriptController.h"
#import <WebKit/WebKit.h>

@interface AddUserScriptController () <WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler> //WKScriptMessageHandler

@property (nonatomic,strong) WKWebView *wkweb;

@end

@implementation AddUserScriptController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass(self.class);
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // ====== WKWebView
    WKWebViewConfiguration *cfg = [[WKWebViewConfiguration alloc] init];
    _wkweb = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:cfg];
    //_wkweb.allowsBackForwardNavigationGestures =
    //_wkweb.UIDelegate = (id)self;
    //_wkweb.navigationDelegate = (id)self;
    
    // js - 1
    NSString *jsPath = [[NSBundle mainBundle] pathForResource:@"jx.txt" ofType:nil];
    NSString *js = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
    WKUserScript *usrScript = [[WKUserScript alloc] initWithSource:js injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:TRUE];
    [cfg.userContentController addUserScript:usrScript];
    // js - 2
    NSString *jsPath2 = [[NSBundle mainBundle] pathForResource:@"jxlog.txt" ofType:nil];
    NSString *js2 = [NSString stringWithContentsOfFile:jsPath2 encoding:NSUTF8StringEncoding error:nil];
    WKUserScript *usrScript2 = [[WKUserScript alloc] initWithSource:js2 injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:TRUE];
    [cfg.userContentController addUserScript:usrScript2];
    
    // js - 3 
    [cfg.userContentController addScriptMessageHandler:(id)self name:@"showCamera"];

    
    _wkweb.backgroundColor = [UIColor orangeColor];
    // ======
    
    [self.view addSubview:self.wkweb];
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"addscript.html" ofType:nil];
    NSURL    *URLString = [NSURL fileURLWithPath:path];
    [self.wkweb loadFileURL:URLString allowingReadAccessToURL:URLString];

    
}


-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"showCamera"]) {
        NSLog(@"\n\n 拦截： \n  %@ \n\n",message.name);
        [self openCamera];
    }
}

- (void)openCamera {
    NSLog(@"\n\n %s \n\n",__FUNCTION__);
}

@end

