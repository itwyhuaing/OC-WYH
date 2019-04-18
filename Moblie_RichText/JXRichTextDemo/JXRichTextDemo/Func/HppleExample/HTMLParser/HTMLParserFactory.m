//
//  HTMLParserFactory.m
//  JXRichTextDemo
//
//  Created by hnbwyh on 2019/4/17.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "HTMLParserFactory.h"
#import "PParser.h"
#import "FontParser.h"
#import "ImgParser.h"

/**
 <p></p>
 <p><font></font>文字</p>
 <p><img></p>
 <p><font></font><img></p>
 <p><font></font></p>
 <p><font></font><font></font></p>
 */

@implementation HTMLParserFactory

+(instancetype)currentHTMLParserFactory{
    static HTMLParserFactory *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HTMLParserFactory alloc] init];
    });
    return instance;
}


-(NSAttributedString *)htmlParserFactoryWithHtmlContent:(NSString *)htmlContent {
    NSAttributedString *showText;
    NSData  *data = [htmlContent dataUsingEncoding:NSUTF8StringEncoding];
    TFHpple *doc = [[TFHpple alloc] initWithHTMLData:data];
    // p
    NSArray *elements = [doc searchWithXPathQuery:@"//p"];
    if (elements && elements.count > 0) {
        NSMutableAttributedString *tmpString = [[NSMutableAttributedString alloc] initWithString:@""];
        for (NSInteger idx = 0; idx < elements.count; idx ++) {
            TFHppleElement *p_element = elements[idx];
            [tmpString appendAttributedString:[self htmlContentWithPElement:p_element]];
            [tmpString appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
        }
        showText = tmpString;
    }
    return showText;
}


- (NSAttributedString *)htmlContentWithPElement:(TFHppleElement *)pelement {
    
    NSAttributedString *rlt;
    if ([pelement.tagName isEqualToString:@"p"]) {
        NSMutableAttributedString *tmpString = [[NSMutableAttributedString alloc] initWithString:@""];
        PParser *p_parser = [PParser currentHTMLParser];
        p_parser.attributes = [[HTMLParser currentHTMLParser] composeAttributedDicWithAts:pelement.attributes];
        if ([pelement hasChildren]) {
            NSArray *children = [pelement children];
            for (NSInteger cou = 0; cou < children.count; cou ++) {
                TFHppleElement *theElement = children[cou];
                if ([theElement.tagName isEqualToString:@"img"]) {
                    [tmpString appendAttributedString:[[ImgParser currentHTMLParser] modifyAttributedStringWithHppleElement:theElement]];
                } else if ([theElement.tagName isEqualToString:@"font"]) {
                    [tmpString appendAttributedString:[[FontParser currentHTMLParser] modifyAttributedStringWithHppleElement:theElement]];
                }else if ([theElement.tagName isEqualToString:@"text"]){
                    NSMutableAttributedString *p_tmpString = [[NSMutableAttributedString alloc] initWithString:@""];
                    pelement.text ? [p_tmpString appendAttributedString:[[NSAttributedString alloc] initWithString:pelement.text]] : nil;
                    [tmpString appendAttributedString:[p_parser addAttributesWithAts:p_tmpString attribute:p_parser.attributes]];
                }
            }
            rlt = tmpString;
        }
    }
    return rlt;
}

@end
