//
//  ZSSRichTextEditor.m
//  RichTextProject
//
//  Created by hnbwyh on 2017/9/27.
//  Copyright © 2017年 hnbwyh. All rights reserved.
//

#import "ZSSRichTextEditor.h"
#import <WebKit/WebKit.h>
#import <objc/runtime.h>


//#import <objc/runtime.h>
//#import <UIKit/UIKit.h>
//#import "ZSSBarButtonItem.h"
//#import "HRColorUtil.h"
//#import "ZSSTextView.h"
//
//@import JavaScriptCore;

#define kToolBarHeight 44.0

@interface ZSSRichTextEditor () <WKUIDelegate,WKNavigationDelegate>
/**rain数据
 *
 */
{
    BOOL toolBarDownStatus;
}

/**rain
 * 视图图层
 */
@property (nonatomic,strong) WKWebView *wkEditor;
@property (nonatomic,strong) UIView *toolBarHolder;
@property (nonatomic,strong) UIImageView *keyImageView;
@property (nonatomic,strong) UIScrollView *toolBarScroll;

/**rain
 * 功能区按钮
 */
@property (nonatomic,strong) UIButton *imageFromDeviceBtn;
@property (nonatomic,strong) UIButton *boldBtn;
@property (nonatomic,strong) UIButton *italicBtn;
@property (nonatomic,strong) UIButton *strikeThroughBtn;
@property (nonatomic,strong) UIButton *h1Btn;
@property (nonatomic,strong) UIButton *h2Btn;
@property (nonatomic,strong) UIButton *h3Btn;
@property (nonatomic,strong) UIButton *h4Btn;

/**rain数据
 *
 */
@property (nonatomic,strong) NSMutableArray *funBtns;
@property (nonatomic,strong) NSMutableArray *funImageNames;

@end


@implementation ZSSRichTextEditor

#pragma mark ------ life

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLocalData];
    [self loadEditorView];
    [self createToolBar];
    [self setWkWebViewShowKeybord];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShowOrHide:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShowOrHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark ------ show UI

- (void)loadEditorView{
    NSBundle* bundle = [NSBundle mainBundle];
    
//    NSString *filePath = [bundle pathForResource:@"editor" ofType:@"html"];
//    NSData *htmlData = [NSData dataWithContentsOfFile:filePath];
//    NSString *htmlString = [[NSString alloc] initWithData:htmlData encoding:NSUTF8StringEncoding];
//    
//    NSString *jquery = [bundle pathForResource:@"jQuery" ofType:@"js"];
//    NSString *jqueryString = [[NSString alloc] initWithData:[NSData dataWithContentsOfFile:jquery] encoding:NSUTF8StringEncoding];
//    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<!-- jQuery -->" withString:jqueryString];
//    
//    NSString *beautifier = [bundle pathForResource:@"JSBeautifier" ofType:@"js"];
//    NSString *beautifierString = [[NSString alloc] initWithData:[NSData dataWithContentsOfFile:beautifier] encoding:NSUTF8StringEncoding];
//    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<!-- jsbeautifier -->" withString:beautifierString];
//    
//    NSString *source = [bundle pathForResource:@"ZSSRichTextEditor" ofType:@"js"];
//    NSString *jsString = [[NSString alloc] initWithData:[NSData dataWithContentsOfFile:source] encoding:NSUTF8StringEncoding];
//    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<!--editor-->" withString:jsString];
//    
//    [self.wkEditor loadHTMLString:htmlString baseURL:nil];
    
    NSString *htmlPath = [bundle pathForResource:@"editor" ofType:@"html"];
    [self.wkEditor loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:htmlPath]]];
    
}

- (void)createToolBar{
    // alloc
    self.toolBarHolder = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                  CGRectGetMaxY(self.view.frame) - kToolBarHeight,
                                                                  [UIScreen mainScreen].bounds.size.width,
                                                                  kToolBarHeight)];
    
    self.keyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                      0,
                                                                      CGRectGetHeight(self.toolBarHolder.frame),
                                                                      CGRectGetHeight(self.toolBarHolder.frame))];
    
    self.toolBarScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.keyImageView.frame),
                                                                        0,
                                                                        [UIScreen mainScreen].bounds.size.width - CGRectGetHeight(self.toolBarHolder.frame),
                                                                        CGRectGetHeight(self.toolBarHolder.frame))];
    // 属性设置
    NSString *tmpImgName = @"ZSSkeyboard_down.png";
    self.keyImageView.image = [UIImage imageNamed:tmpImgName];
    self.keyImageView.contentMode = UIViewContentModeScaleAspectFill;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissOrShowKeyboard)];
    self.keyImageView.userInteractionEnabled = YES;
    [self.keyImageView addGestureRecognizer:tap];
    
    // 描边
    self.toolBarHolder.layer.borderWidth = 0.3;
    self.toolBarHolder.layer.borderColor = [UIColor colorWithRed:201.0/255.0 green:201.0/255.0 blue:201.0/255.0 alpha:1.0].CGColor;
    
    // 层级
    [self.view addSubview:self.toolBarHolder];
    [self.toolBarHolder addSubview:self.keyImageView];
    [self.toolBarHolder addSubview:self.toolBarScroll];
    
    // 测试
    self.toolBarHolder.backgroundColor = [UIColor whiteColor];
    //self.toolBarScroll.backgroundColor = [UIColor redColor];
    //self.keyImageView.backgroundColor = [UIColor purpleColor];
    
    [self addFunctionBtnItem];
}


- (void)addFunctionBtnItem{
    
    CGFloat funSize_w = ([UIScreen mainScreen].bounds.size.width - CGRectGetWidth(self.keyImageView.frame)
                         - self.funImageNames.count * 10.0)/self.funImageNames.count;
    CGRect rect = CGRectZero;
    rect.size = CGSizeMake(funSize_w, 44.0);
    rect.origin.x = 10;
    _imageFromDeviceBtn = [self createButtonWithFrame:rect imgName:@"ZSSimageFromDevice.png"];
    [_imageFromDeviceBtn addTarget:self action:@selector(insertImageFromDevice:) forControlEvents:UIControlEventTouchUpInside];
    
    rect.origin.x = CGRectGetMaxX(_imageFromDeviceBtn.frame) + 10.0;
    _boldBtn = [self createButtonWithFrame:rect imgName:@"ZSSbold.png"];
    [_boldBtn addTarget:self action:@selector(setBold:) forControlEvents:UIControlEventTouchUpInside];
    
    rect.origin.x = CGRectGetMaxX(_boldBtn.frame) + 10.0;
    _italicBtn = [self createButtonWithFrame:rect imgName:@"ZSSitalic.png"];
    [_italicBtn addTarget:self action:@selector(setItalic:) forControlEvents:UIControlEventTouchUpInside];
    
    rect.origin.x = CGRectGetMaxX(_italicBtn.frame) + 10.0;
    _strikeThroughBtn = [self createButtonWithFrame:rect imgName:@"ZSSstrikethrough.png"];
    [_strikeThroughBtn addTarget:self action:@selector(setStrikethrough:) forControlEvents:UIControlEventTouchUpInside];
    
    rect.origin.x = CGRectGetMaxX(_strikeThroughBtn.frame) + 10.0;
    _h1Btn = [self createButtonWithFrame:rect imgName:@"ZSSh1.png"];
    [_h1Btn addTarget:self action:@selector(heading1:) forControlEvents:UIControlEventTouchUpInside];
    
    rect.origin.x = CGRectGetMaxX(_h1Btn.frame) + 10.0;
    _h2Btn = [self createButtonWithFrame:rect imgName:@"ZSSh2.png"];
    [_h2Btn addTarget:self action:@selector(heading2:) forControlEvents:UIControlEventTouchUpInside];
    
    rect.origin.x = CGRectGetMaxX(_h2Btn.frame) + 10.0;
    _h3Btn = [self createButtonWithFrame:rect imgName:@"ZSSh3.png"];
    [_h3Btn addTarget:self action:@selector(heading3:) forControlEvents:UIControlEventTouchUpInside];
    
    rect.origin.x = CGRectGetMaxX(_h3Btn.frame) + 10.0;
    _h4Btn = [self createButtonWithFrame:rect imgName:@"ZSSh4.png"];
    [_h4Btn addTarget:self action:@selector(heading4:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (UIButton *)createButtonWithFrame:(CGRect)rect imgName:(NSString *)imgName{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [btn setFrame:rect];
    [self.toolBarScroll addSubview:btn];
    //btn.backgroundColor = [UIColor colorWithRed:(arc4random()%200)/255.0 green:(arc4random()%200)/255.0 blue:(arc4random()%200)/255.0 alpha:1.0];
    
    return btn;
}

#pragma mark ------ data

- (void)initLocalData{
    NSArray *imgNames = @[@"ZSSimageFromDevice.png",@"ZSSbold.png",@"ZSSitalic.png",@"ZSSstrikethrough.png",@"ZSSh1.png",@"ZSSh2.png",@"ZSSh3.png",@"ZSSh4.png"];
    _funImageNames = [[NSMutableArray alloc] initWithArray:imgNames];
    
    toolBarDownStatus = TRUE;
}

#pragma mark ------
#pragma mark ------
#pragma mark ------ delegate

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSLog(@" ===decidePolicyForNavigationAction=== ");
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@" ===didStartProvisionalNavigation=== ");
}

-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@" ===didFailNavigation=== ");
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@" ===didFinishNavigation=== ");
    
    NSString *js = @"alerShow()";
    [self.wkEditor evaluateJavaScript:js completionHandler:^(id _Nullable info, NSError * _Nullable error) {
        NSLog(@" \n \n alerShow :%@ \n \n",info);
    }];
    
}

#pragma mark ------

#pragma mark ------ native - js


- (void)focusTextEditor {
    
    NSString *js = [NSString stringWithFormat:@"zss_editor.focusEditor();"];
    [self.wkEditor evaluateJavaScript:js completionHandler:^(id _Nullable info, NSError * _Nullable error) {
        NSLog(@" \n \n focusTextEditor : %@ \n error:%@\n",info,error);
    }];
}

- (void)blurTextEditor {
    NSString *js = [NSString stringWithFormat:@"zss_editor.blurEditor();"];
    [self.wkEditor evaluateJavaScript:js completionHandler:^(id _Nullable info, NSError * _Nullable error) {
        NSLog(@" \n \n blurTextEditor : %@ \n error:%@\n",info,error);
    }];
}

-(void)insertImageFromDevice:(UIButton *)btn{
    
}

-(void)setBold:(UIButton *)btn{
    
}

-(void)setItalic:(UIButton *)btn{
    
}

-(void)setStrikethrough:(UIButton *)btn{
    
}

-(void)heading1:(UIButton *)btn{
    
}

-(void)heading2:(UIButton *)btn{
    
}

-(void)heading3:(UIButton *)btn{
    
}

-(void)heading4:(UIButton *)btn{
    
}

#pragma mark ------ private method

- (void)dismissOrShowKeyboard{
    NSLog(@" dismissOrShowKeyboard ");
    if (toolBarDownStatus) {
        [self focusTextEditor];
    } else {
        [self blurTextEditor];
    }
}

- (void)keyboardWillShowOrHide:(NSNotification *)notify{
    NSLog(@" keybord ");
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    NSDictionary *info = notify.userInfo;
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    int curve = [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
    CGRect keyRectEnd = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //CGFloat sizeOfToolBar = self.toolBarHolder.frame.size.height;
    CGFloat keyboardHeight = UIInterfaceOrientationIsLandscape(orientation) ? ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.000000) ? keyRectEnd.size.height : keyRectEnd.size.width : keyRectEnd.size.height;
    UIViewAnimationOptions animationOptions = curve << 16;
    
    //const int extraHeight = 0;// 10;
    if ([notify.name isEqualToString:UIKeyboardWillShowNotification]) {
        [UIView animateWithDuration:duration delay:0 options:animationOptions animations:^{
            
        } completion:^(BOOL finished) {
            [self upDateToolBarFrameOriginY:CGRectGetMaxY(self.view.frame) - keyboardHeight - kToolBarHeight];
            toolBarDownStatus = FALSE;
        }];
        
    } else {
        [UIView animateWithDuration:duration delay:0 options:animationOptions animations:^{
            
        } completion:^(BOOL finished) {
            [self upDateToolBarFrameOriginY:CGRectGetMaxY(self.view.frame) - kToolBarHeight];
            toolBarDownStatus = TRUE;
        }];
    }
    
}

- (void)upDateToolBarFrameOriginY:(CGFloat)y{
    CGRect rect = self.toolBarHolder.frame;
    rect.origin.y = y;
    [self.toolBarHolder setFrame:rect];
}

#pragma mark ------ WKWebView 处理 JS focus() 函数问题
/**
 可参考1：https://stackoverflow.com/questions/32407185/wkwebview-cant-open-keyboard-for-input-field
 可参考2：http://www.jianshu.com/p/c7bd2af5005b
 **/

static void (*originalIMP)(id self, SEL _cmd, void* arg0, BOOL arg1, BOOL arg2, id arg3) = NULL;
void interceptIMP (id self, SEL _cmd, void* arg0, BOOL arg1, BOOL arg2, id arg3) {
    originalIMP(self, _cmd, arg0, TRUE, arg2, arg3);
}

- (void)setWkWebViewShowKeybord {
    Class cls = NSClassFromString(@"WKContentView");
    SEL originalSelector = NSSelectorFromString(@"_startAssistingNode:userIsInteracting:blurPreviousNode:userObject:");
    Method originalMethod = class_getInstanceMethod(cls, originalSelector);
    IMP impOvverride = (IMP) interceptIMP;
    originalIMP = (void *)method_getImplementation(originalMethod);
    method_setImplementation(originalMethod, impOvverride);
}


#pragma mark ------ 懒加载

-(WKWebView *)wkEditor{
    if (!_wkEditor) {
        CGRect rect = CGRectZero;
        rect.size = [UIScreen mainScreen].bounds.size;
        rect.size.height -= 64;
        _wkEditor = [[WKWebView alloc] initWithFrame:rect];
        _wkEditor.UIDelegate = self;
        _wkEditor.navigationDelegate = self;
        [self.view addSubview:_wkEditor];
    }
    return _wkEditor;
}
@end
