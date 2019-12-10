//
//  ZSSRichTextEditor.m
//  RichTextProject
//
//  Created by hnbwyh on 2017/9/27.
//  Copyright © 2017年 hnbwyh. All rights reserved.
//

#import "ZSSRichTextEditor.h"
#import "JSEditorView.h"
#import "JSEditorToolBar.h"
#import "JSEditorHandle.h"

@interface ZSSRichTextEditor () <JSEditorViewDelegate>

@property (nonatomic,strong) JSEditorView       *editorView;
@property (nonatomic,strong) JSEditorToolBar    *toolBarHolder;
@property (nonatomic,strong) JSEditorHandle     *editorHandle;

@end

@implementation ZSSRichTextEditor

#pragma mark ------ life

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutUI];
    [self.editorHandle setWkWebViewShowKeybord];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ------ JSEditorViewDelegate

-(void)jsEditorView:(JSEditorView *)jsEditor willShowKeyboardWithHeight:(CGFloat)height {
    CGRect rect = self.toolBarHolder.frame;
    rect.origin.y -= height;
    [self.toolBarHolder setFrame:rect];
}

-(void)jsEditorView:(JSEditorView *)jsEditor willHideKeyboardWithHeight:(CGFloat)height {
    CGRect rect = self.toolBarHolder.frame;
    rect.origin.y += height;
    [self.toolBarHolder setFrame:rect];
}

-(void)jsEditorView:(JSEditorView *)jsEditor navigationActionWithFuncs:(NSString *)funcs {
    [self.toolBarHolder updateToolBarWithButtonName:funcs];
}

#pragma mark ------ UI

- (void)layoutUI {
    [self.view addSubview:self.editorView];
    [self.view addSubview:self.toolBarHolder];
}

#pragma mark ------ lazy load

-(JSEditorView *)editorView {
    if (!_editorView) {
        _editorView = [[JSEditorView alloc] initWithFrame:CGRectMake(0,
                                                                     0,
                                                                     SCREEN_WIDTH,
                                                                     SCREEN_HEIGHT)];
        _editorView.delegate = (id)self;
    }
    return _editorView;
}

-(JSEditorToolBar *)toolBarHolder {
    if (!_toolBarHolder) {
        _toolBarHolder = [[JSEditorToolBar alloc] initWithFrame:CGRectMake(0,
                                                                CGRectGetMaxY(self.view.frame) - TOOL_BAR_HEIGHT - BOTTOM_HEIGHT_SUIT_IPHONE_X,
                                                                SCREEN_WIDTH,
                                                                TOOL_BAR_HEIGHT)];
        _toolBarHolder.toolBarBlk = ^(JSEditorToolBarFuncLocation location, OperateIntention status) {
            
        };
    }
    return _toolBarHolder;
}

-(JSEditorHandle *)editorHandle {
    if (!_editorHandle) {
        _editorHandle = [[JSEditorHandle alloc] init];
    }
    return _editorHandle;
}

@end
