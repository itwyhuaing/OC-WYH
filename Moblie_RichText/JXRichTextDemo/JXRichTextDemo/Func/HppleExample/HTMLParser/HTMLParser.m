//
//  HTMLParser.m
//  JXRichTextDemo
//
//  Created by hnbwyh on 2019/4/17.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "HTMLParser.h"

@interface HTMLParser ()

@end

@implementation HTMLParser

+(instancetype)currentHTMLParser{
    static HTMLParser *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HTMLParser alloc] init];
    });
    return instance;
}

- (NSDictionary *)composeAttributedDicWithAts:(NSDictionary *)ats {
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionary];
    NSString *atsValue  = [ats valueForKey:@"style"];
    NSArray *kvs        = [atsValue componentsSeparatedByString:@";"];
    for (NSInteger cou = 0; cou < kvs.count; cou ++) {
        NSString *theContent = kvs[cou];
        NSArray *cnts = [theContent componentsSeparatedByString:@":"];
        if (cnts && cnts.count == 2) {
            [mutableDic setObject:cnts.lastObject forKey:cnts.firstObject];
        }
    }
    return mutableDic;
}

@end
