//
//  NTEditorHeader.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2018/5/9.
//  Copyright © 2018年 hainbwyh. All rights reserved.
//

#import "NTEditorHeader.h"

@interface NTEditorHeader ()

@property (nonatomic, strong) UITextField *titleTextField;
@property (nonatomic, strong) CALayer *underLine;

@end

@implementation NTEditorHeader

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect rect = CGRectZero;
        rect.size = frame.size;
        _titleTextField = [[UITextField alloc] initWithFrame:rect];
        _titleTextField.font = [UIFont boldSystemFontOfSize:13.f];
        _titleTextField.placeholder = @"请输入标题";
        
        rect.size.height = 1.0;
        rect.origin.y = frame.size.height - rect.size.height;
        _underLine = [CALayer layer];
        _underLine.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0].CGColor;
        _underLine.frame = rect;
        
        [self addSubview:_titleTextField];
        [self.layer addSublayer:_underLine];
        
    }
    return self;
}

@end
