//
//  NTEditorMainView.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2018/5/9.
//  Copyright © 2018年 hainbwyh. All rights reserved.
//

#import "NTEditorMainView.h"
#import "NTEditorHeader.h"

@interface NTEditorMainView ()

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
        [self initParameters];
        [self initUI];
    }
    return self;
}

-(void)initParameters{
    self.editingLocation = NTEditorMainViewEditingLocationNone;
}

- (void)initUI{
    CGRect rect = self.frame;
    rect.origin = CGPointZero;
    rect.size.height = 50.0;
    _titleHeader = [[NTEditorHeader alloc] initWithFrame:rect];
    [self addSubview:_titleHeader];
    
    self.textContainerInset = UIEdgeInsetsMake(CGRectGetMaxY(_titleHeader.frame)+6.0, 0, 0, 0);
    self.contentInset       = UIEdgeInsetsMake(0, 0, 280, 0);
    self.layoutManager.allowsNonContiguousLayout = FALSE;
    self.font = [UIFont systemFontOfSize:18.0];

}

#pragma mark ------ delegate


#pragma mark ------ publick method

- (void)setNtDelegate:(id<UITextFieldDelegate,UITextViewDelegate>)ntDelegate{
    self.titleHeader.titleTextField.delegate = ntDelegate;
    self.delegate = ntDelegate;
}

-(void)modifyHeaderEditing:(BOOL)hdEditing contentEditing:(BOOL)cntEditing{
    
    if (cntEditing) {
        [self becomeFirstResponder];
    }else{
        [self resignFirstResponder];
    }
    
    if (hdEditing) {
        [self.titleHeader.titleTextField becomeFirstResponder];
    }else{
        [self.titleHeader.titleTextField resignFirstResponder];
    }
    
}

@end
