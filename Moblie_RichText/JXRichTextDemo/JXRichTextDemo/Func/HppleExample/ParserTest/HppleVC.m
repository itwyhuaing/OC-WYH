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
{
    NSInteger location;
}

@property (nonatomic,strong) NSMutableArray<TFHppleElement *> *rlt;

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
    NSString *html = @"<p><font><b>第1段第1句。</b></font><font>第1段第2句。</font></p><p><font><s>第2段第1句。</s></font><font><u><b>第2段第2句。</b></u></font></p>"; // @"<p><font>第1段第1句。</font><font>第1段测试数据</font></p>";//
    NSData  *data = [html dataUsingEncoding:NSUTF8StringEncoding];
    TFHpple *doc = [[TFHpple alloc] initWithHTMLData:data];
    NSArray *elements = [doc searchWithXPathQuery:@"//p"];
    if (elements && elements.count > 0) {
        for (TFHppleElement *elt in elements) {
            [self logTheElement:elt mark:@"00"];
            [self parserElement:elt];
        }
    }
    NSLog(@"");
}


- (void)parserElement:(TFHppleElement *)element{
    location ++;
    while ([element hasChildren]) {
        
        NSArray *children = [element children];
        if (children) {
            for (TFHppleElement *elt in children) {
                [self logTheElement:elt mark:[NSString stringWithFormat:@"%ld",location]];
                //NSLog(@"\n\n %ld \n %@ \n %@ \n\n",location,elt.tagName,elt.text);
                if (elt.text && (![elt.text isEqualToString:@"(null)"] || ![elt.text isEqualToString:@"null"])) {
                    [self.rlt addObject:elt];
                }
                if ([elt.tagName isEqualToString:@"text"]) {
                    return;
                }else{
                    [self parserElement:elt];
                }
            }
        }
        
        break;
    }
    NSLog(@"=== 结果 ===");
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

#pragma mark --- setter

-(void)setHtmlContent:(NSString *)htmlContent{
    if (htmlContent && htmlContent.length > 0) {
         _htmlContent = htmlContent;
    }
}

-(NSMutableArray *)rlt{
    if (!_rlt) {
        _rlt = [[NSMutableArray alloc] init];
    }
    return _rlt;
}

@end
