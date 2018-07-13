//
//  AttibutedTestVC.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2018/5/17.
//  Copyright © 2018年 hainbwyh. All rights reserved.
//

#import "AttibutedTestVC.h"
#import "NTEditorMainView.h"

@interface AttibutedTestVC () <UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic,strong) NTEditorMainView *jxtv;

@end

@implementation AttibutedTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 编辑区
    [self.view addSubview:self.jxtv];
    [self.jxtv modifyHeaderEditing:TRUE contentEditing:FALSE];
    
    // 1. 第一种测试：代码设置内容属性与内容
    //[self testContent];
    
    // 2. 第二种测试：代码设置属性，输入内容
    [self testAttributes];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)testAttributes{
    NSMutableDictionary *typeingAttributes = [self.jxtv.typingAttributes mutableCopy];
    // 字体大小
    typeingAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:32.0 weight:UIFontWeightBold];
    // 字体颜色
    typeingAttributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
    /**
     字体删除线样式
     NSUnderlineStyleNone
     NSUnderlineStyleSingle
     NSUnderlineStyleThick
     NSUnderlineStyleDouble
     
     NSUnderlinePatternSolid
     NSUnderlinePatternDot
     NSUnderlinePatternDash
     NSUnderlinePatternDashDot
     NSUnderlinePatternDashDotDot
     
     NSUnderlineByWord
     */
    typeingAttributes[NSUnderlineStyleAttributeName] = @(NSUnderlineStyleSingle);
    // 字体下划线颜色
    typeingAttributes[NSUnderlineColorAttributeName] = [UIColor greenColor];
    // 字体删除线样式
    typeingAttributes[NSStrikethroughStyleAttributeName] = @(NSUnderlineStyleSingle);
    // 字体删除线颜色
    typeingAttributes[NSStrikethroughColorAttributeName] = [UIColor cyanColor];
    // 字体描边 :颜色 边线宽度
    typeingAttributes[NSStrokeColorAttributeName] = [UIColor redColor];
    typeingAttributes[NSStrokeWidthAttributeName] = @(2);
    // 字符间隔 : 注意区分于字间距
    typeingAttributes[NSKernAttributeName] = @(9);
    // 字体倾斜
    typeingAttributes[NSObliquenessAttributeName] = @(0.3);
    
    /**
      NSParagraphStyleAttributeName
     lineSpacing;           行间距
     paragraphSpacing;      段间距
     alignment;             对齐方式
     firstLineHeadIndent;   首行缩进
     headIndent;            整体缩进(首行除外)
     tailIndent;
     lineBreakMode;
     minimumLineHeight;
     maximumLineHeight;
     baseWritingDirection;
     lineHeightMultiple;
     paragraphSpacingBefore;
     hyphenationFactor;
     */
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineHeightMultiple = 20.f;
    paragraphStyle.maximumLineHeight = 85.f;
    paragraphStyle.minimumLineHeight = 65.f;
    paragraphStyle.firstLineHeadIndent = 200.f;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    typeingAttributes[NSParagraphStyleAttributeName] = paragraphStyle;
    
    self.jxtv.typingAttributes = typeingAttributes;
}

- (void)testContent{

    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:14],
                                 NSForegroundColorAttributeName:[UIColor redColor]
                                  };
    NSAttributedString *at = [[NSAttributedString alloc] initWithString:@"第一种测试： \n 代码设置内容属性与内容" attributes:attributes];
    self.jxtv.attributedText = at;
}

#pragma mark - lazy load

-(NTEditorMainView *)jxtv{
    if (!_jxtv) {
        CGRect rect = self.view.frame;
        rect.origin.x = 10.0;
        rect.size.width -= rect.origin.x * 2.0;
        rect.size.height -= 100.0;
        _jxtv = [[NTEditorMainView alloc] initWithFrame:rect];
        _jxtv.ntDelegate = self;
    }
    return _jxtv;
}

@end
