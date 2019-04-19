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
    self.showTextView.attributedText = [[HTMLParserFactory currentHTMLParserFactory] htmlParserFactoryWithHtmlContent:self.htmlContent];
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
