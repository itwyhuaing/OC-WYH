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

@interface ZSSRichTextEditor () <JSEditorViewKeyBoardDelegate,JSEditorViewNavigationDelegate>

@property (nonatomic,strong) JSEditorView       *editorView;
@property (nonatomic,strong) JSEditorToolBar    *toolBarHolder;
@property (nonatomic,strong) JSEditorHandle     *editorHandle;

@end

@implementation ZSSRichTextEditor

#pragma mark ------ life

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutUI];
    //[self.editorHandle setWkWebViewShowKeybord];
    __weak typeof(self)weakSelf = self;
    self.toolBarHolder.toolBarBlk = ^(JSEditorToolBarFuncLocation location, OperateIntention status) {
        [weakSelf.editorHandle formatEditableWeb:weakSelf.editorView.wkEditor funcLocation:location completion:^(id  _Nonnull info, NSError * _Nonnull error) {
            NSLog(@"\n 点击工具条 :\n %@ \n error : \n %@ \n",info,error);
        }];
    };
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)dealloc {
    NSLog(@"\n\n %s \n\n",__FUNCTION__);
}

#pragma mark ------ JSEditorViewKeyBoardDelegate,JSEditorViewNavigationDelegate

-(void)jsEditorView:(JSEditorView *)jsEditor willShowWithKeyRectEnd:(CGRect)rect {
    CGRect rt = self.toolBarHolder.frame;
    rt.origin.y = CGRectGetMinY(rect) - CGRectGetHeight(rt);
    [self.toolBarHolder setFrame:rt];
}

-(void)jsEditorView:(JSEditorView *)jsEditor willHideWithKeyRectEnd:(CGRect)rect {
    CGRect rt = self.toolBarHolder.frame;
    rt.origin.y = CGRectGetMinY(rect) - CGRectGetHeight(rt) - BOTTOM_HEIGHT_SUIT_IPHONE_X;
    [self.toolBarHolder setFrame:rt];
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
        _editorView.navigationDelegate = (id)self;
        _editorView.isLog = TRUE;
    }
    return _editorView;
}

-(JSEditorToolBar *)toolBarHolder {
    if (!_toolBarHolder) {
        _toolBarHolder = [[JSEditorToolBar alloc] initWithFrame:CGRectMake(0,
                                                                CGRectGetMaxY(self.view.frame) - TOOL_BAR_HEIGHT - BOTTOM_HEIGHT_SUIT_IPHONE_X,
                                                                SCREEN_WIDTH,
                                                                TOOL_BAR_HEIGHT)];
        _toolBarHolder.isLog = TRUE;
    }
    return _toolBarHolder;
}

-(JSEditorHandle *)editorHandle {
    if (!_editorHandle) {
        _editorHandle = [[JSEditorHandle alloc] init];
        _editorHandle.isLog = TRUE;
    }
    return _editorHandle;
}

@end
