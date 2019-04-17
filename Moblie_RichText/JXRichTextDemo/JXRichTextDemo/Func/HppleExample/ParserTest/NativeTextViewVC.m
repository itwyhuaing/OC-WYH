//
//  NativeTextViewVC.m
//  JXRichTextDemo
//
//  Created by hnbwyh on 2019/4/17.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "NativeTextViewVC.h"
#import "TFHpple.h"

@interface NativeTextViewVC ()

@property (nonatomic,strong) UITextView *editor;

@end

@implementation NativeTextViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass(self.class);
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.editor];
    self.editor.backgroundColor = [UIColor cyanColor];
    [self parserPTag];
}

- (void)parserPTag {
    NSData  *data = [self.htmlCnt dataUsingEncoding:NSUTF8StringEncoding];
    TFHpple *doc = [[TFHpple alloc] initWithHTMLData:data];
    NSArray *elements = [doc searchWithXPathQuery:@"//p"];
    for (TFHppleElement *elt in elements) {
        //[self logTheElement:elt mark:@"00"];
        
        NSString            *showText   = elt.text ? elt.text : @"";
        NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:showText];
        NSDictionary *atsDic = [self composeDicWithAts:elt.attributes];
        // 组装 attributedText
        [self modifyAttributedStringWithDic:atsDic cnt:mutableAttributedString tagName:elt.tagName];
        self.editor.attributedText = mutableAttributedString;
        
    }
}

- (void)parserFontTagWith:(NSString *)html {
    
}

- (void)logTheElement:(TFHppleElement *)element mark:(NSString *)mark{
    NSLog(@"\n ------ %@ ------ \n",mark);
    NSLog(@"tagName     : %@",[element tagName]);
    NSLog(@"raw         : %@",[element raw]);
    NSLog(@"content     : %@",[element content]);
    NSLog(@"text        : %@",[element text]);
    NSLog(@"isTextNode  : %d",[element isTextNode]);
    NSLog(@"attributes  : %@",[element attributes]);
    NSLog(@"\n \n");
}


- (NSDictionary *)composeDicWithAts:(NSDictionary *)ats {
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

- (void)modifyAttributedStringWithDic:(NSDictionary *)dic cnt:(NSMutableAttributedString *)atdString tagName:(NSString *)tagName{
    
    NSArray *keys = dic.allKeys;
    // p
    if ([tagName isEqualToString:@"p"]) {
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        for (NSString *key in keys) {
            if ([key isEqualToString:@"text-indent"]) {
                NSString *value = [dic valueForKey:key];
                paraStyle.firstLineHeadIndent = 10;
            }
            if ([key isEqualToString:@"font-size"]) {
                NSString *value = [dic valueForKey:key];
                [atdString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0] range:NSMakeRange(0, atdString.length)];
            }
            if ([key isEqualToString:@"color"]) {
                NSString *value = [dic valueForKey:key];
                [atdString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, atdString.length)];
            }
        }
        [atdString addAttribute:NSParagraphStyleAttributeName value:paraStyle range:NSMakeRange(0, atdString.length)];
    }

    // font
    
    
}


- (UITextView *)editor{
    if (!_editor) {
        CGFloat maxY = CGRectGetMaxY(self.navigationController.navigationBar.frame);
        CGRect rect = [UIScreen mainScreen].bounds;
        rect.origin.y = maxY;
        rect.size.height -= (maxY + 200);
        _editor = [[UITextView alloc] initWithFrame:rect];
    }
    return _editor;
}

@end
