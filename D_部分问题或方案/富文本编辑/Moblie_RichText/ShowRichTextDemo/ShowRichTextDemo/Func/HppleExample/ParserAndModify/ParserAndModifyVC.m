//
//  ParserAndModifyVC.m
//  ShowRichTextDemo
//
//  Created by hnbwyh on 2020/12/15.
//  Copyright © 2020 JiXia. All rights reserved.
//

#import "ParserAndModifyVC.h"
#import "TFHpple.h"

@interface ParserAndModifyVC ()

@property (nonatomic,copy) NSString *cnt;

@end

@implementation ParserAndModifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass(self.class);
    
    NSString *themDetailPath = [[NSBundle mainBundle] pathForResource:@"TFHppleParser" ofType:@"html"];
    NSData *themDetailData = [NSData dataWithContentsOfFile:themDetailPath];
    NSString *htmlContent = [[NSString alloc] initWithData:themDetailData encoding:NSUTF8StringEncoding];
    _cnt = [[NSMutableString alloc] initWithString:htmlContent];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self htmlParser];
}

- (void)htmlParser {
    NSData  *data = [_cnt dataUsingEncoding:NSUTF8StringEncoding];
    TFHpple *doc = [[TFHpple alloc] initWithHTMLData:data];
    NSArray *elements = [doc searchWithXPathQuery:@"//img"];
    [self parserImageElements:elements];
}

- (void)parserImageElements:(NSArray *)eles {
    NSLog(@"======替换之前:\n%@\n",_cnt);
    NSString *h1 = @"http://01";
    NSString *h2 = @"http://02";
    NSString *rlt;
    for (TFHppleElement *ele in eles) {
        //[self logTheElement:ele mark:@"测试"];
        NSDictionary *attributes = [ele attributes];
        
        // base64-data
        NSString *data = [attributes objectForKey:@"src"];
        //src="data:image/jpeg;base64,/9j/4AAf//Z"
        NSString *data_src = [NSString stringWithFormat:@"src=\"%@\"",data];
        // http
        NSString *http_src;
        // id
        NSString *idt = [attributes objectForKey:@"id"];
        if ([idt isEqualToString:@"insertImageID1608004143"]){
            http_src = [NSString stringWithFormat:@"src=\"%@\"",h1];
            rlt = [_cnt stringByReplacingOccurrencesOfString:data_src withString:http_src];
        }
        if ([idt isEqualToString:@"insertImageID1608004243"]) {
            http_src = [NSString stringWithFormat:@"src=\"%@\"",h2];
            rlt = [rlt stringByReplacingOccurrencesOfString:data_src withString:http_src];
        }
        NSLog(@"======准备替换:\n%@\n%@\n\n",data_src,http_src);
        
    }
    NSLog(@"======替换之后:\n%@\n",rlt);
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

@end
