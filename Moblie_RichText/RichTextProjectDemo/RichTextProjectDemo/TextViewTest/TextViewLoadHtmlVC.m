//
//  TextViewLoadHtmlVC.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2018/5/18.
//  Copyright © 2018年 hainbwyh. All rights reserved.
//

#import "TextViewLoadHtmlVC.h"
#import "NTEditorMainView.h"

@interface TextViewLoadHtmlVC ()<UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic,strong) NTEditorMainView *jxtv;
@property (nonatomic,assign) CFTimeInterval startT;

@end

@implementation TextViewLoadHtmlVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 编辑区
    [self.view addSubview:self.jxtv];
    [self.jxtv modifyHeaderEditing:FALSE contentEditing:FALSE];
    [self.jxtv addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:NULL];
    
    [self loadHtmlContent];
}

- (void)loadHtmlContent{
    self.startT = CFAbsoluteTimeGetCurrent();
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"HtmlContent" ofType:@"html"];
    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    CGFloat iw = [UIScreen mainScreen].bounds.size.width - 20;
    NSString *newHtml = @"";
    if ([html rangeOfString:@"<img"].location != NSNotFound) {
        newHtml = [html stringByReplacingOccurrencesOfString:@"<img" withString:[NSString stringWithFormat:@"<img width=\"%f\"",iw]];
    }
    //NSLog(@" \n %@ \n  %@ \n ",html,newHtml);
    NSAttributedString *attributeString=[[NSAttributedString alloc] initWithData:[newHtml dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:14],
                                 NSForegroundColorAttributeName:[UIColor redColor]
                                 };
    NSMutableAttributedString *ax = [[NSMutableAttributedString alloc] initWithAttributedString:attributeString];
    //[ax addAttributes:attributes range:NSMakeRange(0, attributeString.length)];
    
    self.jxtv.attributedText = ax;
    NSLog(@"\n高度值获取 \n%f \n",self.jxtv.contentSize.height);
    
}

-(void)dealloc{
    [self.jxtv removeObserver:self forKeyPath:@"contentSize"];
}

#pragma mark - observer

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{

    if ([keyPath isEqualToString:@"contentSize"] && object == self.jxtv) {
            NSLog(@" \n %s  \n %@  \n 结果：%f\n",__FUNCTION__,change,CFAbsoluteTimeGetCurrent()-self.startT);
    }
}

#pragma mark - lazy load

-(NTEditorMainView *)jxtv{
    if (!_jxtv) {
        CGRect rect = self.view.frame;
        rect.origin.x = 10.0;
        rect.origin.y = 10.0;
        rect.size.width -= rect.origin.x * 2.0;
        rect.size.height -= 100.0;
        _jxtv = [[NTEditorMainView alloc] initWithFrame:rect];
        _jxtv.ntDelegate = self;
        _jxtv.backgroundColor = [UIColor greenColor];
    }
    return _jxtv;
}

@end
