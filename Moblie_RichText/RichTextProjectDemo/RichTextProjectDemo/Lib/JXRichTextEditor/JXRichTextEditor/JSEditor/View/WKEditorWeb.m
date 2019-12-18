//
//  WKEditorWeb.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/12/16.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#import "WKEditorWeb.h"

@interface WKEditorWeb ()<WKScriptMessageHandler>

@end


@implementation WKEditorWeb


- (instancetype)initWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration *)configuration {
    self = [super initWithFrame:frame configuration:configuration];
    if (self) {
        NSString *js = @"console.log = (function(originFunc){\
                                            return function(info) {\
                                                window.webkit.messageHandlers.log.postMessage(info);\
                                            }\
                                        })(console.log)";
        
        //injected the method when H5 starts to create the DOM tree
        [configuration.userContentController addUserScript:[[WKUserScript alloc] initWithSource:js
                                                                                  injectionTime:WKUserScriptInjectionTimeAtDocumentStart
                                                                               forMainFrameOnly:TRUE]];
        //the interaction between Native and JS
        [configuration.userContentController addScriptMessageHandler:self name:@"log"];
    }
    return self;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"log"]) {
        NSLog(@" \n \n 打印：\n %@ \n ",message.body);
    }
}

-(void)dealloc {
    [self.configuration.userContentController removeAllUserScripts];
}

@end
