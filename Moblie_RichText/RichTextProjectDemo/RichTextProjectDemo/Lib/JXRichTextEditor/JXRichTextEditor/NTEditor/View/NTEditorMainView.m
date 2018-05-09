//
//  NTEditorMainView.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2018/5/9.
//  Copyright © 2018年 hainbwyh. All rights reserved.
//

#import "NTEditorMainView.h"
#import "NTEditorHeader.h"
#import "EditorToolBar.h"

@interface NTEditorMainView ()

@property (nonatomic,strong) EditorToolBar *toolBar;
@property (nonatomic,strong) NTEditorHeader *titleHeader;

@end

@implementation NTEditorMainView

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
        [self initUI];
    }
    return self;
}

- (void)initUI{
    CGRect rect = self.frame;
    rect.origin = CGPointZero;
    rect.size.height = 50.0;
    _titleHeader = [[NTEditorHeader alloc] initWithFrame:rect];
    [self addSubview:_titleHeader];
    
    self.textContainerInset = UIEdgeInsetsMake(CGRectGetMaxY(_titleHeader.frame)+6.0, 0, 0, 0);
    self.font = [UIFont systemFontOfSize:18.0];
    
    rect.origin.y = 200;
    rect.origin.x = 0;
    rect.size.width = self.frame.size.width;
    rect.size.height = 44.0;
    _toolBar = [[EditorToolBar alloc] initWithFrame:rect];
    [self addSubview:_toolBar];
    
}

@end
