//
//  HppleVC.m
//  JXRichTextDemo
//
//  Created by hnbwyh on 2019/4/15.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "HppleVC.h"
#import "TFHpple.h"

@interface HppleVC ()

@end

@implementation HppleVC

#pragma mark --- life cycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        _htmlContent = @"<p style=\"letter-spacing:30px;text-align:center;font-size:24px;color:blue;\">保持知足常乐的心态才是淬炼心智</p><p>净化心灵的最佳途径。<font style=\"font-size:18px;color:red;\"><b>一切快乐的享受都属于精神，</b><i>这种快乐把忍受变为享受，</i><s>是精神对于物质的胜利，</s><u>这便是人生哲学。</u></font></p>";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass(self.class);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self htmlParser];
}

#pragma mark --- parser

- (void)htmlParser {
    NSData *data = [self.htmlContent dataUsingEncoding:NSUTF8StringEncoding];
    TFHpple *doc = [[TFHpple alloc] initWithHTMLData:data];
    NSArray *elements = [doc searchWithXPathQuery:@"//p"];
    if (elements) {
        for (NSInteger cou = 0; cou < elements.count; cou ++) {
            TFHppleElement *element = elements[cou];
            [self logTheElement:element];
            if ([element hasChildren]) {
                NSArray *children = [element children];
                if (children) {
                    for (NSInteger index = 0; index < children.count; index ++) {
                        TFHppleElement *ele = children[index];
                        [self logTheElement:ele];
                    }
                }
            }
        }
    }
}

- (void)logTheElement:(TFHppleElement *)element{
    NSLog(@"\n \n");
    NSLog(@"tagName     : %@",[element tagName]);
    NSLog(@"raw         : %@",[element raw]);
    NSLog(@"content     : %@",[element content]);
    NSLog(@"attributes  : %@",[element attributes]);
    NSLog(@"\n \n");
}

#pragma mark --- setter

-(void)setHtmlContent:(NSString *)htmlContent{
    if (htmlContent && htmlContent.length > 0) {
         _htmlContent = htmlContent;
    }
}

@end
