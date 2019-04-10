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
#import "NTEditorAttributeConfig.h"

@interface JXTextViewVC () <UITextFieldDelegate,UITextViewDelegate,EditorToolBarDelegate>

@property (nonatomic,strong) NTEditorMainView *jxtv;
@property (nonatomic,strong) EditorToolBar *toolBar;
@property (nonatomic,strong) NTEditorAttributeConfig *editorAttributeConfig;

@property (nonatomic,assign) BOOL barShowStatus; /**<工具条是否处于展示状态>*/
@property (nonatomic,assign) CGFloat keyBoardHeight;

@end

@implementation JXTextViewVC

#pragma mark ------ life

- (void)viewDidLoad {
    [super viewDidLoad];
    // 编辑区
    [self.view addSubview:self.jxtv];
    [self.jxtv modifyHeaderEditing:TRUE contentEditing:FALSE];
    
    // 工具条
    [self.view addSubview:self.toolBar];
    NSArray *cnts = @[
                      @"JXimageFromDevice",
                      @"JXbold",
                      @"JXitalic",
                      @"JXstrikethrough",
                      @"JXh1"];
    NSArray *atts = @[
                      @(EditorRichTextCapacityTypeImage),
                      @(EditorRichTextCapacityTypeBold),
                      @(EditorRichTextCapacityTypeItalic),
                      @(EditorRichTextCapacityTypeStrikethrough),
                      @(EditorRichTextCapacityTypeFont)];
    [self.editorAttributeConfig configAttributes:atts];
    [self.toolBar editorToolBarWithContents:cnts];
    [self.toolBar modifyItemSize:CGSizeMake(CGRectGetWidth(self.toolBar.frame)/cnts.count, 44.0) reloadRightNow:FALSE];
    
    
    // 键盘监听
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
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, 88, 44)];
    btn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [btn setTitle:@"获取HTML" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(htmlContent) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
    
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


#pragma mark ------ delegate


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    NSLog(@"\n \n %s \n \n ",__FUNCTION__);
    self.jxtv.editingLocation = NTEditorMainViewEditingLocationTitle;
    [self hiddenToolBar];
    return TRUE;
    
}

#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    NSLog(@"\n \n %s \n \n ",__FUNCTION__);
    self.jxtv.editingLocation = NTEditorMainViewEditingLocationCnt;
    [self showToolBar];
    return TRUE;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    //NSLog(@"\n \n %s \n %ld - %ld \n %@\n ",__FUNCTION__,range.location,range.length,text);
    return TRUE;
}

-(void)textViewDidChangeSelection:(UITextView *)textView{
    NSRange range = NSMakeRange(0, textView.attributedText.length);
    NSLog(@"\n \n %s \n %ld - %ld \n ",__FUNCTION__,range.location,range.length);
}

#pragma mark - EditorToolBarDelegate

-(void)editorToolBar:(EditorToolBar *)bar didSelectItemAtIndexPath:(NSInteger)index{
    NSLog(@"\n \n %s : %ld \n \n",__FUNCTION__,index);
    [self.editorAttributeConfig updateAttributesForEditor:self.jxtv didSelectedIndex:index];
    
}

#pragma mark ------ KVO

- (void)keyBoardWillShowWithNotify:(NSNotification *)notification{
    
    NSLog(@" %s ",__FUNCTION__);
    NSDictionary *info = [notification userInfo];
    NSValue *av = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect kbRect = av.CGRectValue;
    self.keyBoardHeight = kbRect.size.height;

}

- (void)keyBoardDidShowWithNotify:(NSNotification *)notification{
    
}

- (void)keyBoardWillHideWithNotify:(NSNotification *)notification{
    // NSLog(@" %s ",__FUNCTION__);
}


#pragma mark ------ private method

// 展示工具条
- (void)showToolBar{
    NSLog(@"\n \n %s \n \n ",__FUNCTION__);
    CGRect rect = self.toolBar.frame;
    rect.origin.y = CGRectGetHeight(self.view.frame) - self.keyBoardHeight - rect.size.height;
    [self.toolBar setFrame:rect];
    self.barShowStatus = TRUE;
}

// 隐藏工具条
- (void)hiddenToolBar{
    NSLog(@"\n \n %s \n \n ",__FUNCTION__);
    CGRect rect = self.toolBar.frame;
    rect.origin.y = CGRectGetMaxY(self.view.frame);// - rect.size.height;
    [self.toolBar setFrame:rect];
    self.barShowStatus = FALSE;
}

- (void)htmlContent{
    NSLog(@"\n \n %s \n \n ",__FUNCTION__);
    
    // fontWithDescriptor
    UIFont *f0 = [UIFont systemFontOfSize:18.0];
    UIFont *f1 = [UIFont systemFontOfSize:18.0 weight:UIFontWeightThin];
    UIFont *f2 = [UIFont systemFontOfSize:18.0 weight:UIFontWeightBold];
    NSLog(@" \ndescription: \n%@\n%@\n%@\n \n ",f0.description,f1.description,f2.description);
    NSLog(@" \nfontDescriptor: \n%@\n%@\n%@\n \n ",f0.fontDescriptor,f1.fontDescriptor,f2.fontDescriptor);
    
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

-(NTEditorAttributeConfig *)editorAttributeConfig{
    if (!_editorAttributeConfig) {
        _editorAttributeConfig = [[NTEditorAttributeConfig alloc] init];
    }
    return _editorAttributeConfig;
}

@end
