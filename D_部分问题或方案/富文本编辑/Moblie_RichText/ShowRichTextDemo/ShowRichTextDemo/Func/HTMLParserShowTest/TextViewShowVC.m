//
//  TextViewShowVC.m
//  JXRichTextDemo
//
//  Created by hnbwyh on 2019/4/19.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "TextViewShowVC.h"
#import "HTMLParserFactory.h"

@interface TextViewShowVC ()

@property (nonatomic,strong)        UITextView              *showTextView;

@end

@implementation TextViewShowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //NSLog(@"\n\n 测试点 - HTML : \n %@ \n\n",self.htmlContent);
    NSAttributedString *ats = [[HTMLParserFactory currentHTMLParserFactory] htmlParserFactoryWithHtmlContent:self.htmlContent];
    //NSLog(@"\n\n 解析出原生富文本数据 :  \n %@ \n\n",ats);
    self.showTextView.attributedText = ats;
}


- (UITextView *)showTextView{
    if (!_showTextView) {
        CGFloat maxY = CGRectGetMaxY(self.navigationController.navigationBar.frame);
        CGRect rect = [UIScreen mainScreen].bounds;
        rect.origin.y = maxY;
        rect.size.height -= (maxY + 200);
        _showTextView = [[UITextView alloc] initWithFrame:rect];
        [self.view addSubview:_showTextView];
    }
    return _showTextView;
}

@end

/** 22
 
 常规黑色粗体斜体测试数据中心少壮不努{
 NSColor = "UIExtendedGrayColorSpace 0 1";
 NSFont = "<UICTFont: 0x7ffa1261f8c0> font-family: \".SFUIText-Light\"; font-weight: normal; font-style: normal; font-size: 18.00pt";
 NSKern = 3;
 NSParagraphStyle = "Alignment 0, LineSpacing 0, ParagraphSpacing 0, ParagraphSpacingBefore 0, HeadIndent 0, TailIndent 0, FirstLineHeadIndent 20, LineHeight 0/0, LineHeightMultiple 0, LineBreakMode 0, Tabs (\n    28L,\n    56L,\n    84L,\n    112L,\n    140L,\n    168L,\n    196L,\n    224L,\n    252L,\n    280L,\n    308L,\n    336L\n), DefaultTabInterval 0, Blocks (\n), Lists (\n), BaseWritingDirection -1, HyphenationFactor 0, TighteningForTruncation NO, HeaderLevel 0";
 }力老大体伤悲放假{
 NSColor = "UIExtendedGrayColorSpace 0 1";
 NSFont = "<UICTFont: 0x7ffa12620120> font-family: \".SFUIDisplay-Light\"; font-weight: normal; font-style: normal; font-size: 28.00pt";
 NSKern = 3;
 NSParagraphStyle = "Alignment 0, LineSpacing 0, ParagraphSpacing 0, ParagraphSpacingBefore 0, HeadIndent 0, TailIndent 0, FirstLineHeadIndent 20, LineHeight 0/0, LineHeightMultiple 0, LineBreakMode 0, Tabs (\n    28L,\n    56L,\n    84L,\n    112L,\n    140L,\n    168L,\n    196L,\n    224L,\n    252L,\n    280L,\n    308L,\n    336L\n), DefaultTabInterval 0, Blocks (\n), Lists (\n), BaseWritingDirection -1, HyphenationFactor 0, TighteningForTruncation NO, HeaderLevel 0";
 }
 */
