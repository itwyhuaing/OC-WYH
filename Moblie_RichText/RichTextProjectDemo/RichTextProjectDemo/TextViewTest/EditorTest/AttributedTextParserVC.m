//
//  AttributedTextParserVC.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/4/10.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#import "AttributedTextParserVC.h"
#import "HTMLVC.h"
#import "HTMLFactory.h"

@interface AttributedTextParserVC ()

@property (nonatomic,strong) UITextView *editor;

@end

@implementation AttributedTextParserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configUI];
}


- (void)configUI{
    // 展示区
    [self.view addSubview:self.editor];
    self.editor.backgroundColor = [UIColor cyanColor];
    NSString *cnt = @"常规红色粗体28黑色粗体斜体蓝色测试放假\n第二行";
    NSMutableAttributedString *rltAttributedString = [[NSMutableAttributedString alloc] initWithString:cnt];
    [rltAttributedString addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],
                                         NSFontAttributeName:[UIFont systemFontOfSize:19.0 weight:UIFontWeightBold]
                                         }
                                 range:NSMakeRange(2, 4)];
    [rltAttributedString addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],
                                         NSFontAttributeName:[UIFont systemFontOfSize:28.0 weight:UIFontWeightLight]
                                         }
                                 range:NSMakeRange(6, 4)];
    [rltAttributedString addAttributes:@{
                                         NSFontAttributeName:[UIFont systemFontOfSize:19.0 weight:UIFontWeightBold],
                                         NSObliquenessAttributeName:@(0.3),
                                         NSForegroundColorAttributeName:[UIColor blueColor]
                                         } range:NSMakeRange(10, 6)];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    //paragraphStyle.lineHeightMultiple = 20.f;
    //paragraphStyle.maximumLineHeight = 85.f;
    //paragraphStyle.minimumLineHeight = 65.f;
    paragraphStyle.firstLineHeadIndent = 10.f;
    paragraphStyle.lineSpacing  = 6.0f;
    paragraphStyle.alignment    = NSTextAlignmentCenter;
    [rltAttributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, cnt.length)];
    [rltAttributedString addAttribute:NSKernAttributeName value:@(10) range:NSMakeRange(0, cnt.length)];
    self.editor.attributedText = rltAttributedString;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    NSMutableString *htmlContent = [NSMutableString string];
    NSRange effectiveRange = NSMakeRange(0, 0);
    while (NSMaxRange(effectiveRange) < self.editor.text.length) {
        NSDictionary *attributes = [self.editor.attributedText attributesAtIndex:effectiveRange.location effectiveRange:&effectiveRange];
        NSString *text = [self.editor.attributedText.string substringWithRange:effectiveRange];
        effectiveRange = NSMakeRange(NSMaxRange(effectiveRange), 0);
        NSTextAttachment *attachment = attributes[@"NSAttachment"];
        
        [HTMLFactory htmlFactoryWithTextAttributes:attributes];
        //break;
        
        if (attachment) { // 图片
            
        }else{  // 文字
            
            NSParagraphStyle *paraStyle  = attributes[@"NSParagraphStyle"];
            UIFont  *font = attributes[@"NSFont"];
            UIColor *clr  = attributes[@"NSColor"];
            NSString *kern = [NSString stringWithFormat:@"%@",attributes[@"NSKern"]];
            NSString *obli = [NSString stringWithFormat:@"%@",attributes[@"NSObliqueness"]];
            
            if (paraStyle && ![htmlContent hasPrefix:@"<p"]) { // <p>
                [htmlContent appendFormat:@"<p style=\"text-indent:%fem;line-height:%fpx;letter-spacing:%f;text-align:%@\">",paraStyle.firstLineHeadIndent /5.0,paraStyle.lineSpacing * 9.0,kern.floatValue * 3.0,@"center"];
            }
            
            NSString *font_style = @"";
            if (font) {
                font_style = [NSString stringWithFormat:@"font-size:%f",font.pointSize * 2.0];
            }
            
            NSString *clr_style = @"";
            if (clr) {
                clr_style = [NSString stringWithFormat:@"color:%@",[self hexStringWithColor:clr]];
            }
            
            if (obli != nil && ![obli isEqualToString:@"(null)"]) {
                [htmlContent appendFormat:@"<font style=\"%@;%@;\"><i>%@</i></font>",font_style,clr_style,text];
            }else{
                [htmlContent appendFormat:@"<font style=\"%@;%@;\">%@</font>",font_style,clr_style,text];
            }
            
            if (paraStyle && NSMaxRange(effectiveRange) >= self.editor.text.length
                && [htmlContent hasPrefix:@"<p"] && ![htmlContent hasSuffix:@"</p>"]) {
                [htmlContent appendString:@"</p>"];
            }
            
        }

    }
    
//    HTMLVC *vc = [[HTMLVC alloc] init];
//    vc.cntHtml = htmlContent;
//    [self.navigationController pushViewController:vc animated:TRUE];
    
}

- (NSString *)hexStringWithColor:(UIColor *)color {
    
    NSString *colorString = [[CIColor colorWithCGColor:color.CGColor] stringRepresentation];
    NSArray *parts = [colorString componentsSeparatedByString:@" "];
    
    NSMutableString *hexString = [NSMutableString stringWithString:@"#"];
    for (int i = 0; i < 3; i ++) {
        [hexString appendString:[NSString stringWithFormat:@"%02X", (int)([parts[i] floatValue] * 255)]];
    }
    return [hexString copy];
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
