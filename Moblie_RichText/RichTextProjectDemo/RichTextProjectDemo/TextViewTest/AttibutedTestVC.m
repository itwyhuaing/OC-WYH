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
    self.view.backgroundColor = [UIColor whiteColor];

    // 编辑区
    [self.view addSubview:self.jxtv];
    [self.jxtv modifyHeaderEditing:TRUE contentEditing:FALSE];
    
    // 1. 第一种测试：代码设置内容属性与内容
//    [self testContent];
    
    // 2. 第二种测试：代码设置属性，输入内容
//    [self testAttributes];
    
    // 3. 第三种测试：测试图文混排
    [self testMutableAttributedString];
}


// 第一种测试：代码设置内容属性与内容
- (void)testContent{

    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:14],
                                 NSForegroundColorAttributeName:[UIColor redColor]
                                  };
    NSAttributedString *at = [[NSAttributedString alloc] initWithString:@"第一种测试： \n 代码设置内容属性与内容" attributes:attributes];
    self.jxtv.attributedText = at;
}


// 代码设置属性，输入内容
- (void)testAttributes{
    
    NSMutableDictionary *typeingAttributes = [self.jxtv.typingAttributes mutableCopy];
    // 字体大小
    typeingAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:32.0 weight:UIFontWeightBold];
    // 字体颜色
    typeingAttributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    /**
     字体删除线/下划线样式
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
    // 字体下划线样式
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
    typeingAttributes[NSKernAttributeName] = @(3);
    // 字体倾斜
    typeingAttributes[NSObliquenessAttributeName] = @(0.0);
    
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
    paragraphStyle.firstLineHeadIndent = 0.f;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    typeingAttributes[NSParagraphStyleAttributeName] = paragraphStyle;
    
    self.jxtv.typingAttributes = typeingAttributes;
}


// 测试图文混排
- (void)testMutableAttributedString{
    
    //创建Attachment Str
    NSTextAttachment * attach = [[NSTextAttachment alloc] init];
    attach.image = [UIImage imageNamed:@"ZSSimageFromDevice_selected"];
    attach.bounds = CGRectMake(0, 10, 20, 20);
    NSAttributedString * imageStr = [NSAttributedString attributedStringWithAttachment:attach];
    //添加
    NSMutableAttributedString * mutableAttriStr = [[NSMutableAttributedString alloc] initWithString:@"Wenchen   "];
    [mutableAttriStr appendAttributedString:imageStr];
    self.jxtv.attributedText = mutableAttriStr;

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
