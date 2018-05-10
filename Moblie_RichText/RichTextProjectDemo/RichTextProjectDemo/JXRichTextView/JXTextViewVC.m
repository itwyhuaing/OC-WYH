//
//  JXTextViewVC.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2018/5/8.
//  Copyright © 2018年 hainbwyh. All rights reserved.
//

#import "JXTextViewVC.h"
#import "NTEditorMainView.h"
#import "EditorToolBar.h"

@interface JXTextViewVC () <UITextFieldDelegate,UITextViewDelegate,EditorToolBarDelegate>

@property (nonatomic,strong) NTEditorMainView *jxtv;
@property (nonatomic,strong) EditorToolBar *toolBar;

@property (nonatomic,assign) BOOL headerEditing; /**<标题是否处于编辑状态>*/
@property (nonatomic,assign) BOOL barShowStatus; /**<工具条是否处于展示状态>*/
@property (nonatomic,assign) CGFloat keyBoardHeight;

@end

@implementation JXTextViewVC

#pragma mark ------ life

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.jxtv];
    [self.jxtv modifyHeaderEditing:TRUE contentEditing:FALSE];
    [self.view addSubview:self.toolBar];
    NSArray *cnts = @[@"JXkeyboard_down",
                      @"JXimageFromDevice",
                      @"JXbold",@"JXitalic",
                      @"JXstrikethrough",
                      @"JXh1",@"JXh2",@"JXh3",@"JXh4"];
    [self.toolBar editorToolBarWithContents:cnts];
    [self.toolBar modifyItemSize:CGSizeMake(CGRectGetWidth(self.toolBar.frame)/cnts.count, 44.0) reloadRightNow:FALSE];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyBoardWillShowWithNotify:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyBoardDidShowWithNotify:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyBoardWillHideWithNotify:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = TRUE;
    self.view.backgroundColor = [UIColor whiteColor];
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}

-(void)dealloc{
    NSLog(@" %s ",__FUNCTION__);
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark ------
#pragma mark ------


#pragma mark ------ delegate

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@" %s ",__FUNCTION__);
    self.headerEditing = TRUE;
    [self hiddenToolBar];
    return TRUE;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    NSLog(@" %s ",__FUNCTION__);
    self.headerEditing = FALSE;
    return TRUE;
}

#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    NSLog(@" %s ",__FUNCTION__);
    return TRUE;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    NSLog(@" %s ",__FUNCTION__);
    [self hiddenToolBar];
    return TRUE;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    [self showToolBar];
}

#pragma mark - EditorToolBarDelegate

-(void)editorToolBar:(EditorToolBar *)bar didSelectItemAtIndexPath:(NSInteger)index{
    if (self.barShowStatus) { // 高处位置
        [self hiddenToolBar];
        [self.jxtv modifyHeaderEditing:FALSE contentEditing:FALSE];
    } else {
        [self showToolBar];
        [self.jxtv modifyHeaderEditing:FALSE contentEditing:TRUE];
    }
    NSLog(@"\n %s : %ld\n",__FUNCTION__,index);
    
}

#pragma mark ------ private method

- (void)keyBoardWillShowWithNotify:(NSNotification *)notification{
    NSLog(@" %s ",__FUNCTION__);
    NSDictionary *info = [notification userInfo];
    NSValue *av = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect kbRect = av.CGRectValue;
    CGRect barRect = self.toolBar.frame;
    self.keyBoardHeight = kbRect.size.height;
    if (kbRect.origin.y < CGRectGetMaxY(barRect) && !self.headerEditing) {
        //[self showToolBar];
        //NSLog(@" \n kbRect.size.height:%f \n kbRect.origin.y:%f \n barRect.origin.y:%f \n",kbRect.size.height,kbRect.origin.y,self.toolBar.frame.origin.y);
    }
    
    
}

- (void)keyBoardDidShowWithNotify:(NSNotification *)notification{
}

- (void)keyBoardWillHideWithNotify:(NSNotification *)notification{
    NSLog(@" %s ",__FUNCTION__);
}

// 展示工具条
- (void)showToolBar{
    NSLog(@" %s ",__FUNCTION__);
    CGRect rect = self.toolBar.frame;
    rect.origin.y = CGRectGetHeight(self.view.frame) - self.keyBoardHeight - rect.size.height;
    [self.toolBar setFrame:rect];
    self.barShowStatus = TRUE;
}

// 隐藏工具条
- (void)hiddenToolBar{
    NSLog(@" %s ",__FUNCTION__);
    CGRect rect = self.toolBar.frame;
    rect.origin.y = CGRectGetMaxY(self.view.frame) - rect.size.height;
    [self.toolBar setFrame:rect];
    self.barShowStatus = FALSE;
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

-(EditorToolBar *)toolBar{
    if (!_toolBar) {
        CGRect rect = self.view.frame;
        rect.origin.y = CGRectGetHeight(rect);
        rect.size.height = 44.0;
        _toolBar = [[EditorToolBar alloc] initWithFrame:rect];
        _toolBar.delegate = self;
    }
    return _toolBar;
}

@end
