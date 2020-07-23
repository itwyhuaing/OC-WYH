//
//  AttributedTest2VC.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2018/5/22.
//  Copyright © 2018年 hainbwyh. All rights reserved.
//

#import "AttributedTest2VC.h"
#import "NTEditorMainView.h"

@interface AttributedTest2VC () <UITextFieldDelegate,UITextViewDelegate>
@property (nonatomic,strong) NTEditorMainView *jxtv;
@end

@implementation AttributedTest2VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 编辑区
    [self.view addSubview:self.jxtv];
    [self.jxtv modifyHeaderEditing:TRUE contentEditing:FALSE];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, 88, 44)];
    btn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [btn setTitle:@"点击修改" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
    
    // 初始展示
    [self displayForNormalStatus];
    
}

#pragma mark ------ private method

- (void)clickBtn:(UIButton *)btn{
    btn.selected = !btn.selected;
    btn.selected ? [self displayForSelectedStatus] : [self displayForNormalStatus];
}

- (void)displayForSelectedStatus{
    
    CGAffineTransform mt = CGAffineTransformMake(1, 0, tanf(30*(CGFloat)M_PI/180), 1, 0, 0);
    UIFontDescriptor *dp = [UIFontDescriptor fontDescriptorWithName:[UIFont systemFontOfSize:14.0].fontName matrix:mt];
    UIFont *ft = [UIFont fontWithDescriptor:dp size:14.0];
    NSDictionary *attributes = @{
                                 NSFontAttributeName:ft,
                                 NSForegroundColorAttributeName:[UIColor redColor]
                                 };
    NSAttributedString *text = [[NSAttributedString alloc] initWithString:@"进一步了解 UIFont 等设置属性的内部实现细节，在具体修改内部值之后，重新赋值展示" attributes:attributes];
    
    /* ft.fontDescriptor.fontAttributes
     {
     NSCTFontMatrixAttribute = <00000000 0000f03f 00000000 00000000 00000040 a779e23f 00000000 0000f03f 00000000 00000000 00000000 00000000>;
     NSFontNameAttribute = ".SFUIText";
     NSFontSizeAttribute = 14;
     }

     */
    
    self.jxtv.attributedText = text;
}

- (void)displayForNormalStatus{
    
    CGAffineTransform mt = CGAffineTransformMake(1, 0, tanf(0*(CGFloat)M_PI/180), 1, 0, 0);
    UIFontDescriptor *dp = [UIFontDescriptor fontDescriptorWithName:[UIFont systemFontOfSize:14.0].fontName matrix:mt];
    UIFont *ft = [UIFont fontWithDescriptor:dp size:14.0];
    NSDictionary *attributes = @{
                                 NSFontAttributeName:ft,
                                 NSForegroundColorAttributeName:[UIColor redColor]
                                 };
    NSAttributedString *text = [[NSAttributedString alloc] initWithString:@"进一步了解 UIFont 等设置属性的内部实现细节，在具体修改内部值之后，重新赋值展示" attributes:attributes];
    
    self.jxtv.attributedText = text;
    
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
