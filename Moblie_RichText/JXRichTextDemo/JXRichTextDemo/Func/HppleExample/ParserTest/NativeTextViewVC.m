//
//  NativeTextViewVC.m
//  JXRichTextDemo
//
//  Created by hnbwyh on 2019/4/17.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "NativeTextViewVC.h"
#import "TFHpple.h"
#import "HTMLParserFactory.h"
#import "PParser.h"
#import "FontParser.h"
#import "ImgParser.h"

@interface NativeTextViewVC ()

@property (nonatomic,strong)        UITextView              *editor;

@end

@implementation NativeTextViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass(self.class);
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.editor];
    self.editor.backgroundColor = [UIColor cyanColor];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.editor.attributedText = [[HTMLParserFactory currentHTMLParserFactory] htmlParserFactoryWithHtmlContent:self.htmlCnt];
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
