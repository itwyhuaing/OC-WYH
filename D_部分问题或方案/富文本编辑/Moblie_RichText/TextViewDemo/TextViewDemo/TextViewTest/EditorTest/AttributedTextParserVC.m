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
    NSString *cnt = @"常规\n红色粗体28黑色粗体斜体蓝色测试数据中心少壮不努力老大体伤悲放假";
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
    paragraphStyle.alignment    = NSTextAlignmentLeft;
    [rltAttributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, cnt.length)];
    [rltAttributedString addAttribute:NSKernAttributeName value:@(10) range:NSMakeRange(0, cnt.length)];
    self.editor.attributedText = rltAttributedString;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    NSString *html = [HTMLFactory htmlFactoryWithAttributedString:self.editor.attributedText];
    HTMLVC *vc = [[HTMLVC alloc] init];
    vc.cntHtml = html;
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
