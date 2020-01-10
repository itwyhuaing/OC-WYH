//
//  NTEditorTitleView.m
//  RichTextPro
//
//  Created by hnbwyh on 2019/12/23.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "NTEditorTitleView.h"
#import "NTEditorConfig.h"

@interface NTEditorTitleView () <UITextViewDelegate>
{
    CGFloat baseOffsetH;
}
@property (nonatomic, strong,readwrite) UITextView  *titleTextView;
@property (nonatomic, strong)           CALayer     *underLine;

@end

@implementation NTEditorTitleView

#pragma mark --- init - dealloc

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

-(void)dealloc {
    NSLog(@"%s",__FUNCTION__);
    [self removeObserver:self forKeyPath:@"contentSize"];
}

#pragma mark --- KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    CGRect oldRct = self.titleTextView.bounds;
    CGSize cntSize= self.titleTextView.contentSize;
    CGFloat offset = cntSize.height+3.2 - oldRct.size.height;
    if (offset > 0) {
        self.updateHight ? self.updateHight(offset) : nil;
    }
}

#pragma mark --- UI

- (void)configUI {
    [self addSubview:self.titleTextView];
    [self.layer addSublayer:self.underLine];
    [self.titleTextView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:NULL];
    
    self.backgroundColor = [UIColor redColor];
    self.titleTextView.backgroundColor = [UIColor greenColor];
    self.underLine.backgroundColor     = [UIColor blueColor].CGColor;
}


-(void)layoutSubviews {
    CGRect rect = CGRectMake(0, 0,CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-LAYER_LINE_HEIGHT);
    [self.titleTextView setFrame:rect];
    [self.underLine setFrame:CGRectMake(0, CGRectGetMaxY(rect),CGRectGetWidth(rect), LAYER_LINE_HEIGHT)];
    
    
    NSLog(@"\n \n 子页面 %s \n %@ \n %@ \n %@ \n",__FUNCTION__,self,self.titleTextView,self.underLine);
    
}

-(UITextView *)titleTextView {
    if (!_titleTextView) {
        _titleTextView = [[UITextView alloc] init];
        _titleTextView.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightBold];
    }
    return _titleTextView;
}

-(CALayer *)underLine {
    if (!_underLine) {
        _underLine = [CALayer layer];
        _underLine.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0].CGColor;
    }
    return _underLine;
}

@end
