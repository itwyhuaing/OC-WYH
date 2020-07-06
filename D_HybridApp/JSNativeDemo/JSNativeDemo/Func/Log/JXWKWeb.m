//
//  JXWKWeb.m
//  JSNativeDemo
//
//  Created by hnbwyh on 2019/7/5.
//  Copyright © 2019 ZhiXing. All rights reserved.
//

#import "JXWKWeb.h"

@interface JXWKWeb ()<WKScriptMessageHandler>

@end



@implementation JXWKWeb

//- (instancetype)initWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration *)configuration {
//    self = [super initWithFrame:frame configuration:configuration];
//    if (self) {
//        //rewrite the method of console.log
////        NSString *js = @"console.log = (function(originFunc){\
////                                            return function(info) {\
////                                                window.webkit.messageHandlers.log.postMessage(info);\
////                                                originFunc.call(console,info);\
////                                            }\
////                                        })(console.log)";
//        NSString *js = @"console.log = (function(originFunc){\
//                                            return function(info) {\
//                                                window.webkit.messageHandlers.log.postMessage(info);\
//                                            }\
//                                        })(console.log)";
//        
//        //injected the method when H5 starts to create the DOM tree
//        [configuration.userContentController addUserScript:[[WKUserScript alloc] initWithSource:js
//                                                                                  injectionTime:WKUserScriptInjectionTimeAtDocumentStart
//                                                                               forMainFrameOnly:TRUE]];
//        //the interaction between Native and JS
//        [configuration.userContentController addScriptMessageHandler:self name:@"log"];
//    }
//    return self;
//}
//
//
//- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
//    if ([message.name isEqualToString:@"log"]) {
//        NSLog(@" 打印：%@",message.body);
//    }
//}

@end
