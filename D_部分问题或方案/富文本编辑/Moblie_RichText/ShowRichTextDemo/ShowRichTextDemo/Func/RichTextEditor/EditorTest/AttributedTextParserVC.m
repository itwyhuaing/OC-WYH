//
//  AttributedTextParserVC.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/4/10.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#import "AttributedTextParserVC.h"
#import "HTMLFactory.h"
#import "ShowWebVC.h"

@interface AttributedTextParserVC ()

@property (nonatomic,strong) UITextView *editor;

@end

@implementation AttributedTextParserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    [self configUI];
}


- (void)configUI{
    // 展示区
    [self.view addSubview:self.editor];
    self.editor.backgroundColor = [UIColor cyanColor];
    NSString *cnt = @"常规黑色粗体斜体测试数据中心少壮不努力老大体伤悲放假";
    NSMutableAttributedString *rltAttributedString = [[NSMutableAttributedString alloc] initWithString:cnt];
    [rltAttributedString addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],
                                         NSFontAttributeName:[UIFont systemFontOfSize:18.0 weight:UIFontWeightLight],
                                         NSKernAttributeName:@(3.0)
                                         }
                                 range:NSMakeRange(0, rltAttributedString.length)];
    [rltAttributedString addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],
                                         NSFontAttributeName:[UIFont systemFontOfSize:28.0 weight:UIFontWeightLight]
                                         }
                                 range:NSMakeRange(rltAttributedString.length - 8, 8)];
//    [rltAttributedString addAttributes:@{
//                                         NSFontAttributeName:[UIFont systemFontOfSize:19.0 weight:UIFontWeightBold],
//                                         NSObliquenessAttributeName:@(0.3),
//                                         NSForegroundColorAttributeName:[UIColor blueColor]
//                                         } range:NSMakeRange(10, 6)];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.firstLineHeadIndent = 20.f;
    paragraphStyle.lineSpacing         = 0.0;
    paragraphStyle.alignment           = NSTextAlignmentLeft;
    [rltAttributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, cnt.length)];
    self.editor.attributedText = rltAttributedString;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    NSAttributedString *ats = self.editor.attributedText;
    NSString *bodyContent = [HTMLFactory htmlFactoryWithAttributedString:ats];
    //NSLog(@"\n\n 测试点 - 原生富文本：\n %@ ",ats);
    ShowWebVC *vc = [[ShowWebVC alloc] init];
    [vc showWebWithHTMLBody:bodyContent isWkWeb:TRUE];
    [self.navigationController pushViewController:vc animated:TRUE];
    
}

- (UITextView *)editor{
    if (!_editor) {
        CGFloat maxY = CGRectGetMaxY(self.navigationController.navigationBar.frame);
        CGRect  screenBounds = [UIScreen mainScreen].bounds;
        _editor = [[UITextView alloc] initWithFrame:CGRectMake(0, maxY, screenBounds.size.width, 100)];
    }
    return _editor;
}

@end

/** 11
 常规黑色粗体斜体测试数据中心少壮不努{
 NSColor = "UIExtendedGrayColorSpace 0 1";
 NSFont = "<UICTFont: 0x7ffa12620ed0> font-family: \".PingFangSC-Light\"; font-weight: normal; font-style: normal; font-size: 18.00pt";
 NSKern = 3;
 NSOriginalFont = "<UICTFont: 0x7ffa1261f8c0> font-family: \".SFUIText-Light\"; font-weight: normal; font-style: normal; font-size: 18.00pt";
 NSParagraphStyle = "Alignment 0, LineSpacing 0, ParagraphSpacing 0, ParagraphSpacingBefore 0, HeadIndent 0, TailIndent 0, FirstLineHeadIndent 20, LineHeight 0/0, LineHeightMultiple 0, LineBreakMode 0, Tabs (\n    28L,\n    56L,\n    84L,\n    112L,\n    140L,\n    168L,\n    196L,\n    224L,\n    252L,\n    280L,\n    308L,\n    336L\n), DefaultTabInterval 0, Blocks (\n), Lists (\n), BaseWritingDirection -1, HyphenationFactor 0, TighteningForTruncation NO, HeaderLevel 0";
 }力老大体伤悲放假{
 NSColor = "UIExtendedGrayColorSpace 0 1";
 NSFont = "<UICTFont: 0x7ffa12624df0> font-family: \".PingFangSC-Light\"; font-weight: normal; font-style: normal; font-size: 28.00pt";
 NSKern = 3;
 NSOriginalFont = "<UICTFont: 0x7ffa12620120> font-family: \".SFUIDisplay-Light\"; font-weight: normal; font-style: normal; font-size: 28.00pt";
 NSParagraphStyle = "Alignment 0, LineSpacing 0, ParagraphSpacing 0, ParagraphSpacingBefore 0, HeadIndent 0, TailIndent 0, FirstLineHeadIndent 20, LineHeight 0/0, LineHeightMultiple 0, LineBreakMode 0, Tabs (\n    28L,\n    56L,\n    84L,\n    112L,\n    140L,\n    168L,\n    196L,\n    224L,\n    252L,\n    280L,\n    308L,\n    336L\n), DefaultTabInterval 0, Blocks (\n), Lists (\n), BaseWritingDirection -1, HyphenationFactor 0, TighteningForTruncation NO, HeaderLevel 0";
 }
 */


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
