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
#import "JSEditorDataModel.h"
#import "JSEditorHandleJs.h"
#import "JSEditorPhotosPicker.h"
#import "JSEditorPhotosUploader.h"

@interface ZSSRichTextEditor () <JSEditorViewKeyBoardDelegate,JSEditorViewNavigationDelegate>

@property (nonatomic,strong) JSEditorView                   *editorView;
@property (nonatomic,strong) JSEditorToolBar                *toolBarHolder;
@property (nonatomic,strong) JSEditorHandleJs               *handlerJs;
@property (nonatomic,strong) JSEditorPhotosPicker           *photosPicker;
@property (nonatomic,strong) JSEditorPhotosUploader         *uploader;

@end

@implementation ZSSRichTextEditor

#pragma mark ------ life

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutUI];
    [self.handlerJs setWkWebViewShowKeybord];
    [self handleBlock];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)dealloc {
    NSLog(@"\n\n %s \n\n",__FUNCTION__);
}


#pragma mark ------ handle block

- (void)handleBlock {
    __weak typeof(self)weakSelf = self;
    self.toolBarHolder.toolBarBlk = ^(JSEditorToolBarFuncType location, OperateIntention status) {
        // 控制编辑区格式
        [weakSelf.handlerJs formatEditableWeb:weakSelf.editorView.wkEditor funcLocation:location intention:status completion:^(id  _Nonnull info, NSError * _Nonnull error) {
            NSLog(@"\n \n 点击工具条 : %@ \n error :  %@ \n",info,error);
            if (location == JSEditorToolBarInsertImage) {
                [weakSelf.photosPicker pickPhotos];
            }
        }];
    };
    
    // 选择图片回调
    self.photosPicker.pickerBlock = ^(NSArray<PhotoModel *> * _Nonnull data) {
        [weakSelf.uploader uploadImageForEditor:weakSelf.editorView.wkEditor data:data completion:^(id  _Nonnull info) {
            NSLog(@"\n 选择图片回调 - %@ \n",info);
        }];
        [weakSelf dismissViewControllerAnimated:TRUE completion:nil];
    };
}

#pragma mark ------ JSEditorViewKeyBoardDelegate,JSEditorViewNavigationDelegate

-(void)jsEditorView:(JSEditorView *)jsEditor willShowWithKeyRectEnd:(CGRect)rect {
    CGRect rt = self.toolBarHolder.frame;
    rt.origin.y = CGRectGetMinY(rect) - CGRectGetHeight(rt);
    [self.toolBarHolder setFrame:rt];
    self.toolBarHolder.yStatus = JSEditorToolBarYHight;
}

-(void)jsEditorView:(JSEditorView *)jsEditor willHideWithKeyRectEnd:(CGRect)rect {
    CGRect rt = self.toolBarHolder.frame;
    rt.origin.y = CGRectGetMinY(rect) - CGRectGetHeight(rt) - BOTTOM_HEIGHT_SUIT_IPHONE_X;
    [self.toolBarHolder setFrame:rt];
    self.toolBarHolder.yStatus = JSEditorToolBarYLow;
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
        CGRect rect = CGRectMake(0,
        CGRectGetMaxY(self.view.frame) - TOOL_BAR_HEIGHT - BOTTOM_HEIGHT_SUIT_IPHONE_X,
        SCREEN_WIDTH,
        TOOL_BAR_HEIGHT);
        _toolBarHolder = [[JSEditorToolBar alloc] initWithFrame:rect];
        NSArray *onIconNames = @[@"ZSSkeyboard_down.png",@"ZSSimageFromDevice.png",
                                 @"ZSSbold_selected.png",@"ZSSitalic_selected.png",
                                 @"ZSSstrikethrough_selected.png",@"ZSSh1_selected.png",
                                 @"ZSSh2_selected.png",@"ZSSh3_selected.png",
                                 @"ZSSh4_selected.png"];
        NSArray *offIconNames = @[@"ZSSkeyboard.png",@"ZSSimageFromDevice.png",
                                  @"ZSSbold.png",@"ZSSitalic.png",
                                  @"ZSSstrikethrough.png",@"ZSSh1.png",
                                  @"ZSSh2.png",@"ZSSh3.png",
                                  @"ZSSh4.png"];
        NSArray *funcTypes   = @[@(JSEditorToolBarKeyBaord),@(JSEditorToolBarInsertImage),
                                @(JSEditorToolBarBold),@(JSEditorToolBarItalic),
                                @(JSEditorToolBarStrikethrough),@(JSEditorToolBarH1),
                                @(JSEditorToolBarH2),@(JSEditorToolBarH3),
                                @(JSEditorToolBarH4)];
        NSMutableArray *data = [NSMutableArray new];
        for (NSInteger cou = 0; cou < onIconNames.count; cou ++) {
            NSNumber *typeNum = funcTypes[cou];
            ToolBarItem *item = [ToolBarItem new];
            item.onIconName = onIconNames[cou];
            item.offIconName= offIconNames[cou];
            item.isOn       = FALSE;
            item.funcType   = typeNum.integerValue;
            [data addObject:item];
        }
        _toolBarHolder = [[JSEditorToolBar alloc] initWithFrame:rect items:data];
        _toolBarHolder.isLog = TRUE;
    }
    return _toolBarHolder;
}

-(JSEditorHandleJs *)handlerJs {
    if (!_handlerJs) {
        _handlerJs = [[JSEditorHandleJs alloc] init];
        _handlerJs.isLog = TRUE;
    }
    return _handlerJs;
}

-(JSEditorPhotosPicker *)photosPicker {
    if (!_photosPicker) {
        _photosPicker = [[JSEditorPhotosPicker alloc] initWithPreVC:self];
    }
    return _photosPicker;
}

-(JSEditorPhotosUploader *)uploader {
    if (!_uploader) {
        _uploader = [JSEditorPhotosUploader new];
    }
    return _uploader;
}

@end
