//
//  ImgParser.m
//  JXRichTextDemo
//
//  Created by hnbwyh on 2019/4/17.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "ImgParser.h"

@implementation ImgParser

/**
 
 <img src="http://cache.hinabian.com/images/release/b/d/bb87ed887dbe7fff01a6a383895baa0d.png" width=200 height=100 />
 
 */

+(instancetype)currentHTMLParser{
    static ImgParser *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ImgParser alloc] init];
    });
    return instance;
}

- (NSAttributedString *)modifyAttributedStringWithHppleElement:(TFHppleElement *)element {
    NSString *text = element.text;
    NSString *showText = text ? text : @"";
    NSMutableAttributedString *mutableAtString = [[NSMutableAttributedString alloc] initWithString:showText];
    if ([element.tagName isEqualToString:@"img"]) {
        [self attributedString:mutableAtString info:element.attributes];
    }
    return mutableAtString;
}

- (void)attributedString:(NSMutableAttributedString *)atstring info:(NSDictionary *)info {
    NSArray *keys = info.allKeys;
    for (NSString *key in keys) {
        NSTextAttachment *theImageMent;
        if ([key isEqualToString:@"src"]) {
            NSString *value = [info valueForKey:key];
            NSURL    *URL   = [NSURL URLWithString:value];
            NSData *data    = [NSData dataWithContentsOfURL:URL];
            UIImage *img    = [UIImage imageWithData:data];
            NSTextAttachment *imgMent = [[NSTextAttachment alloc] init];
            theImageMent    = imgMent;
            imgMent.image   = img;
            imgMent.bounds  = CGRectMake(0, 0, 100.0, 100 * img.size.height / img.size.width);
            NSAttributedString *imageAttributedString = [NSAttributedString attributedStringWithAttachment:imgMent];
            [atstring appendAttributedString:imageAttributedString];
        }
        
        if ([key isEqualToString:@"width"]) {
            NSString *value = [info valueForKey:key];
            CGFloat width   = value ? value.floatValue : 0.0;
            CGRect rect     = theImageMent.bounds;
            rect.size.width = width;
            theImageMent.bounds = rect;
        }
        
        if ([key isEqualToString:@"height"]) {
            NSString *value = [info valueForKey:key];
            CGFloat height  = value ? value.floatValue : 0.0;
            CGRect rect     = theImageMent.bounds;
            rect.size.height= height;
            theImageMent.bounds = rect;
        }
        
    }
}

@end
