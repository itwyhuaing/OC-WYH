//
//  RichTextEditorVC.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/4/9.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#import "RichTextEditorVC.h"

@interface RichTextEditorVC ()
{
    UIFontWeight currentWeight;
}
@property (nonatomic,strong)    UITextView *editor;

@end

@implementation RichTextEditorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configUI];
}


- (void)configUI{
    // 控制按钮
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[@"图片",@"粗体",@"字体28",@"红色",@"白色",@"初始状态",@"获取"]];
    CGFloat maxY            = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    CGRect  screenFrame     = [UIScreen mainScreen].bounds;
    [seg setFrame:CGRectMake(10, maxY, screenFrame.size.width-20.0, 56)];
    [self.view addSubview:seg];
    [seg addTarget:self action:@selector(clickSegControl:) forControlEvents:UIControlEventValueChanged];
    
    // 编辑区
    [self.view addSubview:self.editor];
    [self initStatus];
    self.editor.backgroundColor = [UIColor cyanColor];
    
}



- (void)clickSegControl:(UISegmentedControl *)segCtrl{

    switch (segCtrl.selectedSegmentIndex) {
        case 0:
            {
                [self imageFunction];
            }
            break;
        case 1:
            {
                [self boldFunction];
            }
            break;
        case 2:
            {
                [self fontFunction];
            }
            break;
        case 3:
            {
                [self colorFunction];
            }
            break;
        case 4:
            {
                [self colorFunction2];
            }
            break;
        case 5:
            {
                [self initStatus];
            }
            break;
        case 6:
            {
                [self contentString];
            }
            break;
            
        default:
            break;
    }
    
}

- (void)imageFunction{}

- (void)boldFunction{
    NSMutableDictionary *typeingAttributes = [self.editor.typingAttributes mutableCopy];
    typeingAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:18.0 weight:UIFontWeightBold];
    self.editor.typingAttributes = typeingAttributes;
    currentWeight = UIFontWeightBold;
}

- (void)fontFunction{
    NSMutableDictionary *typeingAttributes = [self.editor.typingAttributes mutableCopy];
    typeingAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:28.0 weight:currentWeight];
    self.editor.typingAttributes = typeingAttributes;
}

- (void)colorFunction{
    NSMutableDictionary *typeingAttributes = [self.editor.typingAttributes mutableCopy];
    typeingAttributes[NSForegroundColorAttributeName] = [UIColor redColor];
    self.editor.typingAttributes = typeingAttributes;
}

- (void)colorFunction2{
    NSMutableDictionary *typeingAttributes = [self.editor.typingAttributes mutableCopy];
    typeingAttributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
    self.editor.typingAttributes = typeingAttributes;
}

- (void)initStatus{
    NSMutableDictionary *typeingAttributes = [self.editor.typingAttributes mutableCopy];
    typeingAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:18.0 weight:UIFontWeightLight];
    typeingAttributes[NSForegroundColorAttributeName] = [UIColor blackColor];
    self.editor.typingAttributes = typeingAttributes;
    currentWeight = UIFontWeightLight;
}

- (void)contentString{
    NSLog(@"\n %@ \n",self.editor.attributedText);
}

-(UITextView *)editor{

    if (!_editor) {
        CGFloat navMaxY            = CGRectGetMaxY(self.navigationController.navigationBar.frame);
        CGRect  screenFrame        = [UIScreen mainScreen].bounds;
        _editor = [[UITextView alloc] initWithFrame:CGRectMake(0, navMaxY + 66.0, screenFrame.size.width, 200.0)];
    }
    return _editor;
    
}

/**
 self.editor.attributedText
 
 普通{
 NSColor = "UIExtendedGrayColorSpace 0 1";
 NSFont = "<UICTFont: 0x100d0c3e0> font-family: \".PingFangSC-Light\"; font-weight: normal; font-style: normal; font-size: 18.00pt";
 NSOriginalFont = "<UICTFont: 0x100c69a60> font-family: \".SFUIText-Light\"; font-weight: normal; font-style: normal; font-size: 18.00pt";
 NSParagraphStyle = "Alignment 4, LineSpacing 0, ParagraphSpacing 0, ParagraphSpacingBefore 0, HeadIndent 0, TailIndent 0, FirstLineHeadIndent 0, LineHeight 0/0, LineHeightMultiple 0, LineBreakMode 0, Tabs (\n    28L,\n    56L,\n    84L,\n    112L,\n    140L,\n    168L,\n    196L,\n    224L,\n    252L,\n    280L,\n    308L,\n    336L\n), DefaultTabInterval 0, Blocks (\n), Lists (\n), BaseWritingDirection 0, HyphenationFactor 0, TighteningForTruncation NO, HeaderLevel 0";
 }粗体{
 NSColor = "UIExtendedGrayColorSpace 0 1";
 NSFont = "<UICTFont: 0x100914580> font-family: \".PingFangSC-Medium\"; font-weight: bold; font-style: normal; font-size: 18.00pt";
 NSOriginalFont = "<UICTFont: 0x100f1bea0> font-family: \".SFUIText-Bold\"; font-weight: bold; font-style: normal; font-size: 18.00pt";
 NSParagraphStyle = "Alignment 4, LineSpacing 0, ParagraphSpacing 0, ParagraphSpacingBefore 0, HeadIndent 0, TailIndent 0, FirstLineHeadIndent 0, LineHeight 0/0, LineHeightMultiple 0, LineBreakMode 0, Tabs (\n    28L,\n    56L,\n    84L,\n    112L,\n    140L,\n    168L,\n    196L,\n    224L,\n    252L,\n    280L,\n    308L,\n    336L\n), DefaultTabInterval 0, Blocks (\n), Lists (\n), BaseWritingDirection 0, HyphenationFactor 0, TighteningForTruncation NO, HeaderLevel 0";
 }粗体{
 NSColor = "UIExtendedGrayColorSpace 0 1";
 NSFont = "<UICTFont: 0x100914150> font-family: \".PingFangSC-Medium\"; font-weight: bold; font-style: normal; font-size: 28.00pt";
 NSOriginalFont = "<UICTFont: 0x100912470> font-family: \".SFUIDisplay-Bold\"; font-weight: bold; font-style: normal; font-size: 28.00pt";
 NSParagraphStyle = "Alignment 4, LineSpacing 0, ParagraphSpacing 0, ParagraphSpacingBefore 0, HeadIndent 0, TailIndent 0, FirstLineHeadIndent 0, LineHeight 0/0, LineHeightMultiple 0, LineBreakMode 0, Tabs (\n    28L,\n    56L,\n    84L,\n    112L,\n    140L,\n    168L,\n    196L,\n    224L,\n    252L,\n    280L,\n    308L,\n    336L\n), DefaultTabInterval 0, Blocks (\n), Lists (\n), BaseWritingDirection 0, HyphenationFactor 0, TighteningForTruncation NO, HeaderLevel 0";
 }28{
 NSColor = "UIExtendedGrayColorSpace 0 1";
 NSFont = "<UICTFont: 0x100912470> font-family: \".SFUIDisplay-Bold\"; font-weight: bold; font-style: normal; font-size: 28.00pt";
 NSParagraphStyle = "Alignment 4, LineSpacing 0, ParagraphSpacing 0, ParagraphSpacingBefore 0, HeadIndent 0, TailIndent 0, FirstLineHeadIndent 0, LineHeight 0/0, LineHeightMultiple 0, LineBreakMode 0, Tabs (\n    28L,\n    56L,\n    84L,\n    112L,\n    140L,\n    168L,\n    196L,\n    224L,\n    252L,\n    280L,\n    308L,\n    336L\n), DefaultTabInterval 0, Blocks (\n), Lists (\n), BaseWritingDirection 0, HyphenationFactor 0, TighteningForTruncation NO, HeaderLevel 0";
 }普通红色{
 NSColor = "UIExtendedSRGBColorSpace 1 0 0 1";
 NSFont = "<UICTFont: 0x100f1e1c0> font-family: \".PingFangSC-Light\"; font-weight: normal; font-style: normal; font-size: 18.00pt";
 NSOriginalFont = "<UICTFont: 0x100c69a60> font-family: \".SFUIText-Light\"; font-weight: normal; font-style: normal; font-size: 18.00pt";
 NSParagraphStyle = "Alignment 4, LineSpacing 0, ParagraphSpacing 0, ParagraphSpacingBefore 0, HeadIndent 0, TailIndent 0, FirstLineHeadIndent 0, LineHeight 0/0, LineHeightMultiple 0, LineBreakMode 0, Tabs (\n    28L,\n    56L,\n    84L,\n    112L,\n    140L,\n    168L,\n    196L,\n    224L,\n    252L,\n    280L,\n    308L,\n    336L\n), DefaultTabInterval 0, Blocks (\n), Lists (\n), BaseWritingDirection 0, HyphenationFactor 0, TighteningForTruncation NO, HeaderLevel 0";
 }普通白色{
 NSColor = "UIExtendedGrayColorSpace 1 1";
 NSFont = "<UICTFont: 0x100d21080> font-family: \".PingFangSC-Light\"; font-weight: normal; font-style: normal; font-size: 18.00pt";
 NSOriginalFont = "<UICTFont: 0x100c69a60> font-family: \".SFUIText-Light\"; font-weight: normal; font-style: normal; font-size: 18.00pt";
 NSParagraphStyle = "Alignment 4, LineSpacing 0, ParagraphSpacing 0, ParagraphSpacingBefore 0, HeadIndent 0, TailIndent 0, FirstLineHeadIndent 0, LineHeight 0/0, LineHeightMultiple 0, LineBreakMode 0, Tabs (\n    28L,\n    56L,\n    84L,\n    112L,\n    140L,\n    168L,\n    196L,\n    224L,\n    252L,\n    280L,\n    308L,\n    336L\n), DefaultTabInterval 0, Blocks (\n), Lists (\n), BaseWritingDirection 0, HyphenationFactor 0, TighteningForTruncation NO, HeaderLevel 0";
 }

 */

@end
