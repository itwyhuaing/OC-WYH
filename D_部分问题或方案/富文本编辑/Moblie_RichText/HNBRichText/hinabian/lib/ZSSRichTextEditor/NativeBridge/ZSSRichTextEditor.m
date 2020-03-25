//
//  ZSSRichTextEditorViewController.m
//  ZSSRichTextEditor
//
//  Created by Nicholas Hubbard on 11/30/13.
//  Copyright (c) 2013 Zed Said Studio. All rights reserved.
//

#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import "ZSSRichTextEditor.h"
#import "ZSSBarButtonItem.h"
#import "HRColorUtil.h"
#import "ZSSTextView.h"

// Rain
#import "HNBTribePickerView.h"
#import "RecentPhotoView.h"
#import "DataFetcher.h"
//#import "Tribe.h"
#import "TribeModel.h"
#import "ActionSheetStringPicker.h"
#import "UpLoadImageProgressTip.h"
#import "HNBFileManager.h"

@import JavaScriptCore;


/**
 
 UIWebView modifications for hiding the inputAccessoryView
 
 **/
@interface UIWebView (HackishAccessoryHiding)
@property (nonatomic, assign) BOOL hidesInputAccessoryView;
@end

@implementation UIWebView (HackishAccessoryHiding)

static const char * const hackishFixClassName = "UIWebBrowserViewMinusAccessoryView";
static Class hackishFixClass = Nil;

- (UIView *)hackishlyFoundBrowserView {
    UIScrollView *scrollView = self.scrollView;
    
    UIView *browserView = nil;
    for (UIView *subview in scrollView.subviews) {
        if ([NSStringFromClass([subview class]) hasPrefix:@"UIWebBrowserView"]) {
            browserView = subview;
            break;
        }
    }
    return browserView;
}

- (id)methodReturningNil {
    return nil;
}

- (void)ensureHackishSubclassExistsOfBrowserViewClass:(Class)browserViewClass {
    if (!hackishFixClass) {
        Class newClass = objc_allocateClassPair(browserViewClass, hackishFixClassName, 0);
        newClass = objc_allocateClassPair(browserViewClass, hackishFixClassName, 0);
        IMP nilImp = [self methodForSelector:@selector(methodReturningNil)];
        class_addMethod(newClass, @selector(inputAccessoryView), nilImp, "@@:");
        objc_registerClassPair(newClass);
        
        hackishFixClass = newClass;
    }
}

- (BOOL) hidesInputAccessoryView {
    UIView *browserView = [self hackishlyFoundBrowserView];
    return [browserView class] == hackishFixClass;
}

- (void) setHidesInputAccessoryView:(BOOL)value {
    UIView *browserView = [self hackishlyFoundBrowserView];
    if (browserView == nil) {
        return;
    }
    [self ensureHackishSubclassExistsOfBrowserViewClass:[browserView class]];
    
    if (value) {
        object_setClass(browserView, hackishFixClass);
    }
    else {
        Class normalClass = objc_getClass("UIWebBrowserView");
        object_setClass(browserView, normalClass);
    }
    [browserView reloadInputViews];
}

@end


@interface ZSSRichTextEditor () <HNBTribePickerViewDelegate>
{
    RecentPhotoView *_recentPHView;
    NSString *_loadingLocalURL;
    NSString *_deleteLocalURL;
    NSString *_reloadLocalURL;
    CFAbsoluteTime startLoad;
}
/*
 *  Scroll view containing the toolbar
 */
@property (nonatomic, strong) UIScrollView *toolBarScroll;

/*
 *  Toolbar containing ZSSBarButtonItems
 */
@property (nonatomic, strong) UIToolbar *toolbar;

/*
 *  Holder for all of the toolbar components
 */
@property (nonatomic, strong) UIView *toolbarHolder;

/*
 *  String for the HTML
 */
@property (nonatomic, strong) NSString *htmlString;

/*
 *  UIWebView for writing/editing/displaying the content
 */
@property (nonatomic, strong) UIWebView *editorView;

/*
 *  ZSSTextView for displaying the source code for what is displayed in the editor view
 */
@property (nonatomic, strong) ZSSTextView *sourceView;

/*
 *  CGRect for holding the frame for the editor view
 */
@property (nonatomic) CGRect editorViewFrame;

/*
 *  BOOL for holding if the resources are loaded or not
 */
@property (nonatomic) BOOL resourcesLoaded;

/*
 *  Array holding the enabled editor items
 */
@property (nonatomic, strong) NSArray *editorItemsEnabled;

/*
 *  Alert View used when inserting links/images
 */
@property (nonatomic, strong) UIAlertView *alertView;

/*
 *  NSString holding the selected links URL value
 */
@property (nonatomic, strong) NSString *selectedLinkURL;

/*
 *  NSString holding the selected links title value
 */
@property (nonatomic, strong) NSString *selectedLinkTitle;

/*
 *  NSString holding the selected image URL value
 */
@property (nonatomic, strong) NSString *selectedImageURL;

/*
 *  NSString holding the selected image Alt value
 */
@property (nonatomic, strong) NSString *selectedImageAlt;

/*
 *  CGFloat holdign the selected image scale value
 */
@property (nonatomic, assign) CGFloat selectedImageScale;

/*
 *  NSString holding the base64 value of the current image
 */
@property (nonatomic, strong) NSString *imageBase64String;

/*
 *  Bar button item for the keyboard dismiss button in the toolbar
 */
@property (nonatomic, strong) UIBarButtonItem *keyboardItem;

/*
 *  Array for custom bar button items
 */
@property (nonatomic, strong) NSMutableArray *customBarButtonItems;

/*
 *  Array for custom ZSSBarButtonItems
 */
@property (nonatomic, strong) NSMutableArray *customZSSBarButtonItems;

/*
 *  NSString holding the html
 */
@property (nonatomic, strong) NSString *internalHTML;

/*
 *  NSString title
 */
@property (nonatomic, strong) NSString *inneralTitle;

/*
 *  NSString holding the css
 */
@property (nonatomic, strong) NSString *customCSS;

/*
 *  BOOL for if the editor is loaded or not
 */
@property (nonatomic) BOOL editorLoaded;

/*
 *  Image Picker for selecting photos from users photo library
 */
@property (nonatomic, strong) UIImagePickerController *imagePicker;

/*
 *  Method for getting a version of the html without quotes
 */
- (NSString *)removeQuotesFromHTML:(NSString *)html;

/*
 *  Method for getting a tidied version of the html
 */
- (NSString *)tidyHTML:(NSString *)html;

/*
 * Method for enablign toolbar items
 */
- (void)enableToolbarItems:(BOOL)enable;

/*
 *  Setter for isIpad BOOL
 */
- (BOOL)isIpad;


/**rain
 * 发帖视图是否已经展示
 */
@property (nonatomic,assign) BOOL isAppeared;

/**rain
 * 是否点击标题区域
 */
@property (nonatomic,assign) BOOL isTitleArea;

/**rain
 * 功能按钮数组
 */
@property (nonatomic,strong) NSMutableArray *btnContainer;

/**rain
 * 圈子选择入口
 */
@property (nonatomic,strong) HNBTribePickerView *tribePiker;

/**rain
 * toolBar 是否已回归底部
 */
@property (nonatomic,assign) BOOL toolBarIsDown;

/**rain
 * 键盘弹出收起指示图
 */
@property (nonatomic,strong) UIImageView *keyBImageView;

/**rain
 * 上一次的内容
 */
@property (nonatomic,copy) NSString *lastContent;

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

/**rain
 * 插入图片前的状态
 */
@property (nonatomic,assign) InsertImageClickedType insertType;

/**rain
 *圈子选择数据
 */
@property (strong, nonatomic) NSMutableArray           *tribeArray;//圈子

@end


@implementation ZSSRichTextEditor

//Scale image from device
static CGFloat kJPEGCompression = 0.8;
static CGFloat kDefaultScale = 0.5;

#define kItemBtnWidth (SCREEN_WIDTH - 10*9.0 - 44.0)/8.0  // 除数 为 数组个数
#define kTribePickerViewHeight 49.0
#define kToolBarHolderHeight 44.0
#define kToolBarHolderGapKeyBord 10.0

#pragma mark ------------------ init life

-(instancetype)init{

    if (self = [super init]) {
        _entryOrigin = PostingEntryOriginWritingNewTribeThem;
        _failureModels = [[NSMutableArray alloc] init];
    }
    return self;
    
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    startLoad = CFAbsoluteTimeGetCurrent();
    //Initialise variables
    self.editorLoaded = NO;
    self.receiveEditorDidChangeEvents = NO;
    self.alwaysShowToolbar = YES;
    self.shouldShowKeyboard = NO;
    self.formatHTML = YES;
    _insertType = InsertImageClickedTypeNone;
    _selectedTotal = 0;
    _sucUpLoadCount = 0;
    _failureUpLoadCount = 0;
    _isTitleArea = FALSE;
    _maxImagesCount = 30;
    
    //Frame for the source view and editor view
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    //Source View
    [self createSourceViewWithFrame:frame];
    
    //Editor View
    [self createEditorViewWithFrame:frame];
    
    //Scrolling View
    [self createToolBarScroll];
    //Toolbar with icons
    //[self createToolbar];
    //Parent holding view
    [self createParentHoldingView];
    
     if (![self isIpad]) {
        self.keyBImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        NSString *tmpImgName = self.shouldShowKeyboard ? @"ZSSkeyboard_down.png" : @"ZSSkeyboard.png";
        self.keyBImageView.image = [UIImage imageNamed:tmpImgName]; //
        self.keyBImageView.contentMode = UIViewContentModeScaleAspectFill;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissOrShowKeyboard)];
        self.keyBImageView.userInteractionEnabled = YES;
        [self.keyBImageView addGestureRecognizer:tap];
        [self.toolbarHolder addSubview:self.keyBImageView];
     }

    //Build the toolbar
//    self.enabledToolbarItems = @[ZSSRichTextEditorToolbarInsertImageFromDevice,ZSSRichTextEditorToolbarBold,ZSSRichTextEditorToolbarItalic,ZSSRichTextEditorToolbarStrikeThrough,ZSSRichTextEditorToolbarH1,ZSSRichTextEditorToolbarH2,ZSSRichTextEditorToolbarH3,ZSSRichTextEditorToolbarH4];
    
    // tribe pick view
    [self.view addSubview:self.tribePiker];
    [self.tribePiker updateDisplayTribeName:self.chosedTribeName];
    
    // 子线程准备图片路径
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        NSBundle *mainBundle = [NSBundle mainBundle];
        NSString *loadingPath = [mainBundle pathForResource:@"uploadimageloading" ofType:@"gif"];
        NSString *delePath = [mainBundle pathForResource:@"delete@2x" ofType:@"png"];
        NSString *reloadPath = [mainBundle pathForResource:@"reload@2x" ofType:@"png"];
        NSURL *loadingURL = [NSURL fileURLWithPath:loadingPath];
        NSURL *deleURL = [NSURL fileURLWithPath:delePath];
        NSURL *reloadURL = [NSURL fileURLWithPath:reloadPath];
        _loadingLocalURL = [NSString stringWithFormat:@"%@",loadingURL];
        _deleteLocalURL = [NSString stringWithFormat:@"%@",deleURL];
        _reloadLocalURL = [NSString stringWithFormat:@"%@",reloadURL];
        dispatch_async(dispatch_get_main_queue(), ^{
            // recent image picker
            [self createRecentImagesPicker];
        });
    });
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    //Add observers for keyboard showing or hiding notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowOrHide:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowOrHide:) name:UIKeyboardWillHideNotification object:nil];

    // HNB 个性化定制的导航栏
    //设置导航栏颜色
    [self.navigationController.navigationBar setBackgroundImage:[UIColor createImageWithColor:[UIColor DDNavBarBlue]] forBarMetrics:UIBarMetricsDefault];
    //设置tint颜色值
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //设置导航栏字体大小
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont boldSystemFontOfSize:NAV_TITLE_FONT_SIZE],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //显示原生的NavigationBar
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    //关闭透明度
    self.navigationController.navigationBar.translucent = NO;
    
    //隐藏自带的返回按钮
    [self.navigationItem hidesBackButton];
    _isAppeared = TRUE;
    
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}


- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    //Remove observers for keyboard showing or hiding notifications
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
    // 移除顶部传图进度提示视图
    [self removeTopNavProgressTip];
    _isAppeared = FALSE;
    
}


#pragma mark ------------------ Resources Section

- (void)loadResources {
    //Define correct bundle for loading resources
    NSBundle* bundle = [NSBundle bundleForClass:[ZSSRichTextEditor class]];
    
    //Create a string with the contents of editor.html
    NSString *filePath = [bundle pathForResource:@"editor" ofType:@"html"];
    NSData *htmlData = [NSData dataWithContentsOfFile:filePath];
    NSString *htmlString = [[NSString alloc] initWithData:htmlData encoding:NSUTF8StringEncoding];
    
    //Add jQuery.js to the html file
    NSString *jquery = [bundle pathForResource:@"jQuery" ofType:@"js"];
    NSString *jqueryString = [[NSString alloc] initWithData:[NSData dataWithContentsOfFile:jquery] encoding:NSUTF8StringEncoding];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<!-- jQuery -->" withString:jqueryString];
    
    //Add JSBeautifier.js to the html file
    NSString *beautifier = [bundle pathForResource:@"JSBeautifier" ofType:@"js"];
    NSString *beautifierString = [[NSString alloc] initWithData:[NSData dataWithContentsOfFile:beautifier] encoding:NSUTF8StringEncoding];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<!-- jsbeautifier -->" withString:beautifierString];
    
    //Add ZSSRichTextEditor.js to the html file
    NSString *source = [bundle pathForResource:@"ZSSRichTextEditor" ofType:@"js"];
    NSString *jsString = [[NSString alloc] initWithData:[NSData dataWithContentsOfFile:source] encoding:NSUTF8StringEncoding];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<!--editor-->" withString:jsString];
    
    [self.editorView loadHTMLString:htmlString baseURL:self.baseURL];
    self.resourcesLoaded = YES;
    
    
}


#pragma mark ------------------ Set Up View Section

- (void)createSourceViewWithFrame:(CGRect)frame {
    
    self.sourceView = [[ZSSTextView alloc] initWithFrame:frame];
    self.sourceView.hidden = YES;
    self.sourceView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.sourceView.autocorrectionType = UITextAutocorrectionTypeNo;
    self.sourceView.font = [UIFont fontWithName:@"Courier" size:13.0];
    self.sourceView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.sourceView.autoresizesSubviews = YES;
    self.sourceView.delegate = self;
    [self.view addSubview:self.sourceView];
    self.sourceView.backgroundColor = [UIColor colorFromHexString:@"#fbfbfb"];
    
}

- (void)createEditorViewWithFrame:(CGRect)frame {
    
    self.editorView = [[UIWebView alloc] initWithFrame:frame];
    self.editorView.delegate = self;
    self.editorView.hidesInputAccessoryView = YES;
    self.editorView.keyboardDisplayRequiresUserAction = NO;
    self.editorView.scalesPageToFit = YES;
    self.editorView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    self.editorView.dataDetectorTypes = UIDataDetectorTypeNone;
    self.editorView.scrollView.bounces = NO;
    self.editorView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.editorView];
    self.editorView.backgroundColor = [UIColor colorFromHexString:@"#fbfbfb"];
    
    if (!self.resourcesLoaded) {
        [self loadResources];
    }
}

- (void)setUpImagePicker {
    
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePicker.allowsEditing = YES;
    self.selectedImageScale = kDefaultScale; //by default scale to half the size
    
}

/**
- (void)createToolBarScroll {

    self.toolBarScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(44, 0, [self isIpad] ? self.view.frame.size.width : self.view.frame.size.width - 44, 44)];
    self.toolBarScroll.showsHorizontalScrollIndicator = YES;

}

- (void)createToolbar {
    
    self.toolbar = [[UIToolbar alloc] initWithFrame:CGRectZero];
    self.toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.toolBarScroll addSubview:self.toolbar];
    self.toolBarScroll.autoresizingMask = self.toolbar.autoresizingMask;
    
}


- (void)createParentHoldingView {
    
    //Background Toolbar
    UIToolbar *backgroundToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    backgroundToolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    //Parent holding view
    self.toolbarHolder = [[UIView alloc] init];
    
    if (_alwaysShowToolbar) {
        self.toolbarHolder.frame = CGRectMake(0,
                                              SCREEN_HEIGHT - SCREEN_NAVHEIGHT - SCREEN_STATUSHEIGHT - kToolBarHolderHeight - kTribePickerViewHeight,
                                              self.view.frame.size.width,
                                              kToolBarHolderHeight);
    } else {
        self.toolbarHolder.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, kToolBarHolderHeight);
    }
    self.toolBarIsDown = TRUE;
    self.toolbarHolder.autoresizingMask = self.toolbar.autoresizingMask;
    [self.toolbarHolder addSubview:self.toolBarScroll];
    [self.toolbarHolder insertSubview:backgroundToolbar atIndex:0];
    [self.view addSubview:self.toolbarHolder];
    
    self.toolbarHolder.backgroundColor = [UIColor yellowColor];
    self.toolBarScroll.backgroundColor = [UIColor blueColor];
    
    

// self.toolbar       (UIToolbar)
// self.toolBarScroll
//
// self.toolBarScroll
// backgroundToolbar  (UIToolbar)
// self.toolbarHolder
//
// self.toolbarHolder
// self.view
 
}*/

- (void)createToolBarScroll {
    
    self.toolBarScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(44, 0, [self isIpad] ? self.view.frame.size.width : self.view.frame.size.width - 44, 44)];
    self.toolBarScroll.showsHorizontalScrollIndicator = YES;
    
    // 新增功能按钮时修改以下两个函数数据
    
    [self addFunctionBtnItem];
    self.toolBarScroll.contentSize = self.toolBarScroll.frame.size;
}

- (void)createParentHoldingView {
    
    //Parent holding view
    self.toolbarHolder = [[UIView alloc] init];
    
    if (_alwaysShowToolbar) {
        self.toolbarHolder.frame = CGRectMake(0,
                                              SCREEN_HEIGHT - SCREEN_NAVHEIGHT - SCREEN_STATUSHEIGHT - kToolBarHolderHeight - kTribePickerViewHeight,
                                              self.view.frame.size.width,
                                              kToolBarHolderHeight);
    } else {
        self.toolbarHolder.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, kToolBarHolderHeight);
    }
    self.toolBarIsDown = TRUE;
    self.toolbarHolder.autoresizingMask = self.toolbar.autoresizingMask;
    [self.toolbarHolder addSubview:self.toolBarScroll];
    [self.view addSubview:self.toolbarHolder];
    
    self.toolbarHolder.layer.borderWidth = 0.3;
    self.toolbarHolder.layer.borderColor = [UIColor colorWithRed:201.0/255.0 green:201.0/255.0 blue:201.0/255.0 alpha:1.0].CGColor;
    
    self.toolBarScroll.backgroundColor = [UIColor whiteColor];
    self.toolbarHolder.backgroundColor = [UIColor whiteColor];
    
}

- (void)addFunctionBtnItem{
    CGRect rect = CGRectZero;
    rect.size = CGSizeMake(kItemBtnWidth, 44.0);
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
//    btn.backgroundColor = [UIColor colorWithRed:(arc4random()%200)/255.0 green:(arc4random()%200)/255.0 blue:(arc4random()%200)/255.0 alpha:1.0];
    [self.toolBarScroll addSubview:btn];
    return btn;
}

- (void)setEnabledToolbarItems:(NSArray *)enabledToolbarItems {
    
    _enabledToolbarItems = enabledToolbarItems;
    [self buildToolbar];
    
}


- (void)setToolbarItemTintColor:(UIColor *)toolbarItemTintColor {
    
    _toolbarItemTintColor = toolbarItemTintColor;
    
    // Update the color
    for (ZSSBarButtonItem *item in self.toolbar.items) {
        item.tintColor = [self barButtonItemDefaultColor];
    }
    self.keyboardItem.tintColor = toolbarItemTintColor;
    
}


- (void)setToolbarItemSelectedTintColor:(UIColor *)toolbarItemSelectedTintColor {
    
    _toolbarItemSelectedTintColor = toolbarItemSelectedTintColor;
    
}

- (NSArray *)itemsForToolbar {
    
    //Define correct bundle for loading resources
    //NSBundle* bundle = [NSBundle bundleForClass:[ZSSRichTextEditor class]];
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    // None
    if(_enabledToolbarItems && [_enabledToolbarItems containsObject:ZSSRichTextEditorToolbarNone])
    {
        return items;
    }
    
    BOOL customOrder = NO;
    if (_enabledToolbarItems && ![_enabledToolbarItems containsObject:ZSSRichTextEditorToolbarAll]){
        customOrder = YES;
        for(int i=0; i < _enabledToolbarItems.count;i++){
            [items addObject:@""];
        }
    }

    self.btnContainer = [[NSMutableArray alloc] init];
    
    // Image From Device
    if ((_enabledToolbarItems && [_enabledToolbarItems containsObject:ZSSRichTextEditorToolbarInsertImageFromDevice]) || (_enabledToolbarItems && [_enabledToolbarItems containsObject:ZSSRichTextEditorToolbarAll])) {
        _imageFromDeviceBtn = [self createFunctionButtonWithNormalImageName:@"ZSSimageFromDevice.png"];
        [_imageFromDeviceBtn addTarget:self action:@selector(insertImageFromDevice:) forControlEvents:UIControlEventTouchUpInside];
        ZSSBarButtonItem *insertImageFromDevice = [[ZSSBarButtonItem alloc] initWithCustomView:_imageFromDeviceBtn];
        insertImageFromDevice.label = @"imageFromDevice";
        insertImageFromDevice.index = 7;
        if (customOrder) {
            [items replaceObjectAtIndex:[_enabledToolbarItems indexOfObject:ZSSRichTextEditorToolbarInsertImageFromDevice] withObject:insertImageFromDevice];
        } else {
            [items addObject:insertImageFromDevice];
        }
    }
    
    // Bold
    if ((_enabledToolbarItems && [_enabledToolbarItems containsObject:ZSSRichTextEditorToolbarBold]) || (_enabledToolbarItems && [_enabledToolbarItems containsObject:ZSSRichTextEditorToolbarAll])) {
        _boldBtn = [self createFunctionButtonWithNormalImageName:@"ZSSbold.png"];
        [_boldBtn addTarget:self action:@selector(setBold:) forControlEvents:UIControlEventTouchUpInside];
        ZSSBarButtonItem *bold = [[ZSSBarButtonItem alloc] initWithCustomView:_boldBtn];
        bold.label = @"bold";
        bold.index = 0;
        if (customOrder) {
            [items replaceObjectAtIndex:[_enabledToolbarItems indexOfObject:ZSSRichTextEditorToolbarBold] withObject:bold];
        } else {
            [items addObject:bold];
        }
       
    }
    
    // Italic
    if ((_enabledToolbarItems && [_enabledToolbarItems containsObject:ZSSRichTextEditorToolbarItalic]) || (_enabledToolbarItems && [_enabledToolbarItems containsObject:ZSSRichTextEditorToolbarAll])) {
        _italicBtn = [self createFunctionButtonWithNormalImageName:@"ZSSitalic.png"];
        [_italicBtn addTarget:self action:@selector(setItalic:) forControlEvents:UIControlEventTouchUpInside];
        ZSSBarButtonItem *italic = [[ZSSBarButtonItem alloc] initWithCustomView:_italicBtn];
        italic.label = @"italic";
        italic.index = 1;
        if (customOrder) {
            [items replaceObjectAtIndex:[_enabledToolbarItems indexOfObject:ZSSRichTextEditorToolbarItalic] withObject:italic];
        } else {
            [items addObject:italic];
        }
       
    }
    
    // Strike Through
    if ((_enabledToolbarItems && [_enabledToolbarItems containsObject:ZSSRichTextEditorToolbarStrikeThrough]) || (_enabledToolbarItems && [_enabledToolbarItems containsObject:ZSSRichTextEditorToolbarAll])) {
        _strikeThroughBtn = [self createFunctionButtonWithNormalImageName:@"ZSSstrikethrough.png"];
        [_strikeThroughBtn addTarget:self action:@selector(setStrikethrough:) forControlEvents:UIControlEventTouchUpInside];
        ZSSBarButtonItem *strikeThrough = [[ZSSBarButtonItem alloc] initWithCustomView:_strikeThroughBtn];
        strikeThrough.label = @"strikeThrough";
        strikeThrough.index = 2;
        if (customOrder) {
            [items replaceObjectAtIndex:[_enabledToolbarItems indexOfObject:ZSSRichTextEditorToolbarStrikeThrough] withObject:strikeThrough];
        } else {
            [items addObject:strikeThrough];
        }
     
    }
    
    // Header 1
    if ((_enabledToolbarItems && [_enabledToolbarItems containsObject:ZSSRichTextEditorToolbarH1]) || (_enabledToolbarItems && [_enabledToolbarItems containsObject:ZSSRichTextEditorToolbarAll])) {
        _h1Btn = [self createFunctionButtonWithNormalImageName:@"ZSSh1.png"];
        [_h1Btn addTarget:self action:@selector(heading1:) forControlEvents:UIControlEventTouchUpInside];
        ZSSBarButtonItem *h1 = [[ZSSBarButtonItem alloc] initWithCustomView:_h1Btn];
        h1.label = @"h1";
        h1.index = 3;
        if (customOrder) {
            [items replaceObjectAtIndex:[_enabledToolbarItems indexOfObject:ZSSRichTextEditorToolbarH1] withObject:h1];
        } else {
            [items addObject:h1];
        }
     
    }
    
    // Header 2
    if ((_enabledToolbarItems && [_enabledToolbarItems containsObject:ZSSRichTextEditorToolbarH2]) || (_enabledToolbarItems && [_enabledToolbarItems containsObject:ZSSRichTextEditorToolbarAll])) {
        _h2Btn = [self createFunctionButtonWithNormalImageName:@"ZSSh2.png"];
        [_h2Btn addTarget:self action:@selector(heading2:) forControlEvents:UIControlEventTouchUpInside];
        ZSSBarButtonItem *h2 = [[ZSSBarButtonItem alloc] initWithCustomView:_h2Btn];
        h2.label = @"h2";
        h2.index = 4;
        if (customOrder) {
            [items replaceObjectAtIndex:[_enabledToolbarItems indexOfObject:ZSSRichTextEditorToolbarH2] withObject:h2];
        } else {
            [items addObject:h2];
        }
      
    }
    
    // Header 3
    if ((_enabledToolbarItems && [_enabledToolbarItems containsObject:ZSSRichTextEditorToolbarH3]) || (_enabledToolbarItems && [_enabledToolbarItems containsObject:ZSSRichTextEditorToolbarAll])) {
        _h3Btn = [self createFunctionButtonWithNormalImageName:@"ZSSh3.png"];
        [_h3Btn addTarget:self action:@selector(heading3:) forControlEvents:UIControlEventTouchUpInside];
        ZSSBarButtonItem *h3 = [[ZSSBarButtonItem alloc] initWithCustomView:_h3Btn];
        h3.label = @"h3";
        h3.index = 5;
        if (customOrder) {
            [items replaceObjectAtIndex:[_enabledToolbarItems indexOfObject:ZSSRichTextEditorToolbarH3] withObject:h3];
        } else {
            [items addObject:h3];
        }
      
    }
    
    // Heading 4
    if ((_enabledToolbarItems && [_enabledToolbarItems containsObject:ZSSRichTextEditorToolbarH4]) || (_enabledToolbarItems && [_enabledToolbarItems containsObject:ZSSRichTextEditorToolbarAll])) {
        _h4Btn = [self createFunctionButtonWithNormalImageName:@"ZSSh4.png"];
        [_h4Btn addTarget:self action:@selector(heading4:) forControlEvents:UIControlEventTouchUpInside];
        ZSSBarButtonItem *h4 = [[ZSSBarButtonItem alloc] initWithCustomView:_h4Btn];
        h4.label = @"h4";
        h4.index = 6;
        if (customOrder) {
            [items replaceObjectAtIndex:[_enabledToolbarItems indexOfObject:ZSSRichTextEditorToolbarH4] withObject:h4];
        } else {
            [items addObject:h4];
        }
       
    }
    
    return [NSArray arrayWithArray:items];
}

- (UIButton *)createFunctionButtonWithNormalImageName:(NSString *)imgName {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(0, 0, kItemBtnWidth, 44)];
    return btn;
}



- (void)buildToolbar {
    
    // Check to see if we have any toolbar items, if not, add them all
    NSArray *items = [self itemsForToolbar];
    if (items.count == 0 && !(_enabledToolbarItems && [_enabledToolbarItems containsObject:ZSSRichTextEditorToolbarNone])) {
        _enabledToolbarItems = @[ZSSRichTextEditorToolbarAll];
        items = [self itemsForToolbar];
    }
    
    if (self.customZSSBarButtonItems != nil) {
        items = [items arrayByAddingObjectsFromArray:self.customZSSBarButtonItems];
    }
    
    // get the width before we add custom buttons
    //CGFloat toolbarWidth = items.count == 0 ? 0.0f : (CGFloat)(items.count * 39) - 10;
    CGFloat toolbarWidth = items.count == 0 ? 0.0f : SCREEN_WIDTH - 44.0;
    
    if(self.customBarButtonItems != nil)
    {
        items = [items arrayByAddingObjectsFromArray:self.customBarButtonItems];
        for(ZSSBarButtonItem *buttonItem in self.customBarButtonItems)
        {
            toolbarWidth += buttonItem.customView.frame.size.width + 11.0f;
        }
    }
    
    self.toolbar.items = items;
    for (ZSSBarButtonItem *item in items) {
        item.tintColor = [self barButtonItemDefaultColor];
    }
    
    self.toolbar.frame = CGRectMake(0, 0, toolbarWidth, 44);
    self.toolBarScroll.contentSize = CGSizeMake(self.toolbar.frame.size.width, 44);
    
}


#pragma mark ------------------ 编辑功能 ， JS 与 Native 交互区域


#pragma mark 需求：插入图片

- (void)insertImageFromDevice:(UIButton *)btn {
    
    ////NSLog(@" %s ",__FUNCTION__);
    if (![HNBUtils isConnectionAvailable]) {
        [[HNBToast shareManager] toastWithOnView:nil msg:@"无网络" afterDelay:DELAY_TIME style:HNBToastHudFailure];
        return;
    }
    /**
     以下几种情况不准许选择图片上传
     1. 正在传图过程中
     2. 有未成功上传的图片
     **/
    
    BOOL isMask = [self queryImageMaskTagForCurrentDOM];
    if (isMask) {
        [[HNBToast shareManager] toastWithOnView:nil msg:@"有图片尚未成功上传" afterDelay:DELAY_TIME style:HNBToastHudFailure];
        return;
    }
    
    NSInteger curImagesCount = [self queryImagesCountForCurrentDOM];
    if (curImagesCount >= _maxImagesCount) {
        [[HNBToast shareManager] toastWithOnView:nil msg:[NSString stringWithFormat:@"最多添加%ld张",_maxImagesCount] afterDelay:DELAY_TIME style:HNBToastHudOnlyText];
        return;
    }
    
    /*数据上报*/
    //[HNBClick event:@"190031" Content:nil];
    // 0. 标记隐藏键盘来源
    /** 键盘处理
     1. 高处选中 - 键盘区域隐藏但toolBar 不变
     2. 高处取消 - 最近图片选择器隐藏，键盘弹出
     3. 低处选中 - 键盘不变，但 toolBar 升起
     4. 低处取消 - 无此可能性
     */
    btn.selected = !btn.selected;
    if (!_toolBarIsDown && btn.selected) { // 高处选中
        _insertType = InsertImageClickedTypeHS;
        [self.editorView stringByEvaluatingJavaScriptFromString:@"zss_editor.prepareInsert();"];
        [_recentPHView showRecentPhoto];
        [_recentPHView setLimitedChose:_maxImagesCount - curImagesCount];
        [self.view endEditing:YES];
    }else if (!_toolBarIsDown && !btn.selected)  { // 高处取消
        _insertType = InsertImageClickedTypeHC;
        [self focusTextEditor];
    }else if (_toolBarIsDown && btn.selected){ // 低处选中
        _insertType = InsertImageClickedTypeDS;
        [self focusTextEditor];
        // 重复高处选中步骤
        _insertType = InsertImageClickedTypeHS;
        [self.editorView stringByEvaluatingJavaScriptFromString:@"zss_editor.prepareInsert();"];
        [_recentPHView showRecentPhoto];
        [_recentPHView setLimitedChose:_maxImagesCount - curImagesCount];
        [self.view endEditing:YES];
    }else if (_toolBarIsDown && !btn.selected){ // 低处取消
        _insertType = InsertImageClickedTypeDC;
        [_recentPHView hideRecentPhoto];
        [self.view endEditing:YES];
    }
    
}

#pragma mark 需求：字体加粗

- (void)setBold:(UIButton *)btn {
    //[HNBClick event:@"190041" Content:nil];
    _boldBtn.selected = !_boldBtn.selected;
    //NSLog(@" \n %s _toolBarIsDown:%d \n \n .selected %d",__FUNCTION__,_toolBarIsDown,_boldBtn.selected);
    //    if (_toolBarIsDown) {
    //        [self focusTextEditor];
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            NSString *trigger = @"zss_editor.setBold();";
    //            [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
    //        });
    //    } else {
    //        NSString *trigger = @"zss_editor.setBold();";
    //        [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
    //    }
    
    
    if (_toolBarIsDown) {
        [self focusTextEditor];
    }
    NSString *trigger = @"zss_editor.setBold();";
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
    
}

#pragma mark 需求：斜体

- (void)setItalic:(UIButton *)btn {
    //[HNBClick event:@"190042" Content:nil];
    _italicBtn.selected = !_italicBtn.selected;
    ////NSLog(@" \n %s _toolBarIsDown:%d \n \n .selected %d",__FUNCTION__,_toolBarIsDown,_italicBtn.selected);
    //    if (_toolBarIsDown) {
    //        [self focusTextEditor];
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            NSString *trigger = @"zss_editor.setItalic();";
    //            [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
    //        });
    //    } else {
    //        NSString *trigger = @"zss_editor.setItalic();";
    //        [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
    //    }
    if (_toolBarIsDown) {
        [self focusTextEditor];
    }
    NSString *trigger = @"zss_editor.setItalic();";
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
    
}

#pragma mark 需求：删除线

- (void)setStrikethrough:(UIButton *)btn {
    //[HNBClick event:@"190043" Content:nil];
    _strikeThroughBtn.selected = !_strikeThroughBtn.selected;
    ////NSLog(@" \n %s _toolBarIsDown:%d \n \n .selected %d",__FUNCTION__,_toolBarIsDown,_strikeThroughBtn.selected);
    //    if (_toolBarIsDown) {
    //        [self focusTextEditor];
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            NSString *trigger = @"zss_editor.setStrikeThrough();";
    //            [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
    //        });
    //    } else {
    //        NSString *trigger = @"zss_editor.setStrikeThrough();";
    //        [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
    //    }
    
    if (_toolBarIsDown) {
        [self focusTextEditor];
    }
    NSString *trigger = @"zss_editor.setStrikeThrough();";
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
    
    
}


#pragma mark 需求：H1 H2 H3 H4

- (void)heading1:(UIButton *)btn {
    //[HNBClick event:@"190044" Content:nil];
    _h1Btn.selected = !_h1Btn.selected;
    ////NSLog(@" \n %s _toolBarIsDown:%d \n \n .selected %d",__FUNCTION__,_toolBarIsDown,_h1Btn.selected);
    //    if (_toolBarIsDown) {
    //        [self focusTextEditor];
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            NSString *trigger = @"zss_editor.setHeading('h1');";
    //            [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
    //        });
    //    } else {
    //        NSString *trigger = @"zss_editor.setHeading('h1');";
    //        [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
    //    }
    if (_toolBarIsDown) {
        [self focusTextEditor];
    }
    NSString *trigger = @"zss_editor.setHeading('h1');";
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
    
}


- (void)heading2:(UIButton *)btn {
    //[HNBClick event:@"190045" Content:nil];
    _h2Btn.selected = !_h2Btn.selected;
    ////NSLog(@" \n %s _toolBarIsDown:%d \n \n .selected %d",__FUNCTION__,_toolBarIsDown,_h2Btn.selected);
    //    if (_toolBarIsDown) {
    //        [self focusTextEditor];
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            NSString *trigger = @"zss_editor.setHeading('h2');";
    //            [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
    //        });
    //    } else {
    //        NSString *trigger = @"zss_editor.setHeading('h2');";
    //        [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
    //    }
    if (_toolBarIsDown) {
        [self focusTextEditor];
    }
    NSString *trigger = @"zss_editor.setHeading('h2');";
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
    
}


- (void)heading3:(UIButton *)btn {
    //[HNBClick event:@"190046" Content:nil];
    _h3Btn.selected = !_h3Btn.selected;
    ////NSLog(@" \n %s _toolBarIsDown:%d \n \n .selected %d",__FUNCTION__,_toolBarIsDown,_h3Btn.selected);
    //    if (_toolBarIsDown) {
    //        [self focusTextEditor];
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            NSString *trigger = @"zss_editor.setHeading('h3');";
    //            [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
    //        });
    //    } else {
    //        NSString *trigger = @"zss_editor.setHeading('h3');";
    //        [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
    //    }
    if (_toolBarIsDown) {
        [self focusTextEditor];
    }
    NSString *trigger = @"zss_editor.setHeading('h3');";
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
    
}


- (void)heading4:(UIButton *)btn {
    //[HNBClick event:@"190047" Content:nil];
    _h4Btn.selected = !_h4Btn.selected;
    ////NSLog(@" \n %s _toolBarIsDown:%d \n \n .selected %d",__FUNCTION__,_toolBarIsDown,_h4Btn.selected);
    //    if (_toolBarIsDown) {
    //        [self focusTextEditor];
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            NSString *trigger = @"zss_editor.setHeading('h4');";
    //            [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
    //        });
    //    } else {
    //        NSString *trigger = @"zss_editor.setHeading('h4');";
    //        [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
    //    }
    if (_toolBarIsDown) {
        [self focusTextEditor];
    }
    NSString *trigger = @"zss_editor.setHeading('h4');";
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
}


#pragma mark 更新回调设置被选中状态

- (void)updateToolBarWithButtonName:(NSString *)name {
    
    // Items that are enabled
    NSArray *itemNames = [name componentsSeparatedByString:@","];
    
    // Special case for link
    NSMutableArray *itemsModified = [[NSMutableArray alloc] init];
    for (NSString *linkItem in itemNames) {
        NSString *updatedItem = linkItem;
        if ([linkItem hasPrefix:@"link:"]) {
            updatedItem = @"link";
            self.selectedLinkURL = [linkItem stringByReplacingOccurrencesOfString:@"link:" withString:@""];
        } else if ([linkItem hasPrefix:@"link-title:"]) {
            self.selectedLinkTitle = [self stringByDecodingURLFormat:[linkItem stringByReplacingOccurrencesOfString:@"link-title:" withString:@""]];
        } else if ([linkItem hasPrefix:@"image:"]) {
            updatedItem = @"image";
            self.selectedImageURL = [linkItem stringByReplacingOccurrencesOfString:@"image:" withString:@""];
        } else if ([linkItem hasPrefix:@"image-alt:"]) {
            self.selectedImageAlt = [self stringByDecodingURLFormat:[linkItem stringByReplacingOccurrencesOfString:@"image-alt:" withString:@""]];
        } else {
            self.selectedImageURL = nil;
            self.selectedImageAlt = nil;
            self.selectedLinkURL = nil;
            self.selectedLinkTitle = nil;
        }
        [itemsModified addObject:updatedItem];
    }
    itemNames = [NSArray arrayWithArray:itemsModified];
    
    self.editorItemsEnabled = itemNames;
    
    // Highlight items
    //    NSArray *items = self.toolbar.items;
    //    for (ZSSBarButtonItem *item in items) {
    //        if ([itemNames containsObject:item.label]) {
    //            item.tintColor = [self barButtonItemSelectedDefaultColor];
    //        } else {
    //            item.tintColor = [self barButtonItemDefaultColor];
    //        }
    //    }
    
    for (NSInteger cou = 0;cou < itemNames.count;cou ++) {
        if([itemNames containsObject:@"strikeThrough"]){
            [_strikeThroughBtn setImage:[UIImage imageNamed:@"ZSSstrikethrough_selected.png"] forState:UIControlStateNormal];
        }else{
            [_strikeThroughBtn setImage:[UIImage imageNamed:@"ZSSstrikethrough.png"] forState:UIControlStateNormal];
        }
        
        if([itemNames containsObject:@"bold"]){
            [_boldBtn setImage:[UIImage imageNamed:@"ZSSbold_selected.png"] forState:UIControlStateNormal];
        }else{
            [_boldBtn setImage:[UIImage imageNamed:@"ZSSbold.png"] forState:UIControlStateNormal];
        }
        
        if([itemNames containsObject:@"italic"]){
            [_italicBtn setImage:[UIImage imageNamed:@"ZSSitalic_selected.png"] forState:UIControlStateNormal];
        }else{
            [_italicBtn setImage:[UIImage imageNamed:@"ZSSitalic.png"] forState:UIControlStateNormal];
        }
        
        if([itemNames containsObject:@"h1"]){
            [_h1Btn setImage:[UIImage imageNamed:@"ZSSh1_selected.png"] forState:UIControlStateNormal];
        }else{
            [_h1Btn setImage:[UIImage imageNamed:@"ZSSh1.png"] forState:UIControlStateNormal];
        }
        
        if([itemNames containsObject:@"h2"]){
            [_h2Btn setImage:[UIImage imageNamed:@"ZSSh2_selected.png"] forState:UIControlStateNormal];
        }else{
            [_h2Btn setImage:[UIImage imageNamed:@"ZSSh2.png"] forState:UIControlStateNormal];
        }
        
        if([itemNames containsObject:@"h3"]){
            [_h3Btn setImage:[UIImage imageNamed:@"ZSSh3_selected.png"] forState:UIControlStateNormal];
        }else{
            [_h3Btn setImage:[UIImage imageNamed:@"ZSSh3.png"] forState:UIControlStateNormal];
        }
        
        if([itemNames containsObject:@"h4"]){
            [_h4Btn setImage:[UIImage imageNamed:@"ZSSh4_selected.png"] forState:UIControlStateNormal];
        }else{
            [_h4Btn setImage:[UIImage imageNamed:@"ZSSh4.png"] forState:UIControlStateNormal];
        }
        
    }
    
}

#pragma mark - UITextView Delegate

- (void)textViewDidChange:(UITextView *)textView {
    CGRect line = [textView caretRectForPosition:textView.selectedTextRange.start];
    CGFloat overflow = line.origin.y + line.size.height - ( textView.contentOffset.y + textView.bounds.size.height - textView.contentInset.bottom - textView.contentInset.top );
    if ( overflow > 0 ) {
        // We are at the bottom of the visible text and introduced a line feed, scroll down (iOS 7 does not do it)
        // Scroll caret to visible area
        CGPoint offset = textView.contentOffset;
        offset.y += overflow + 7; // leave 7 pixels margin
        // Cannot animate with setContentOffset:animated: or caret will not appear
        [UIView animateWithDuration:.2 animations:^{
            [textView setContentOffset:offset];
        }];
    }
    
}


#pragma mark  Keyboard status

- (void)keyboardWillShowOrHide:(NSNotification *)notification {
    
    // Orientation
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    // User Info
    NSDictionary *info = notification.userInfo;
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    int curve = [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
    CGRect keyboardEnd = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // Toolbar Sizes
    CGFloat sizeOfToolbar = self.toolbarHolder.frame.size.height;
    
    // Keyboard Size
    //Checks if IOS8, gets correct keyboard height
    CGFloat keyboardHeight = UIInterfaceOrientationIsLandscape(orientation) ? ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.000000) ? keyboardEnd.size.height : keyboardEnd.size.width : keyboardEnd.size.height;
    
    // Correct Curve
    UIViewAnimationOptions animationOptions = curve << 16;
    
    const int extraHeight = 0;//kToolBarHolderGapKeyBord;
    
    if ([notification.name isEqualToString:UIKeyboardWillShowNotification]) { // 显示
        
        [UIView animateWithDuration:duration delay:0 options:animationOptions animations:^{
            
            // 最近与键盘二者只显示一个
            [_recentPHView hideRecentPhoto];
            
            // Toolbar
            CGRect frame = self.toolbarHolder.frame;
            frame.origin.y = self.view.frame.size.height - (keyboardHeight + sizeOfToolbar);
            self.toolbarHolder.frame = frame;
            _toolBarIsDown = FALSE;
            //NSLog(@" 显示11 ====== > %@ --- %f --- %f",self.toolbarHolder,keyboardHeight,sizeOfToolbar);
            
            // Editor View
            CGRect editorFrame = self.editorView.frame;
            editorFrame.size.height = (self.view.frame.size.height - keyboardHeight) - sizeOfToolbar - extraHeight;
            self.editorView.frame = editorFrame;
            self.editorViewFrame = self.editorView.frame;
            self.editorView.scrollView.contentInset = UIEdgeInsetsZero;
            self.editorView.scrollView.scrollIndicatorInsets = UIEdgeInsetsZero;
            
            // Source View
            CGRect sourceFrame = self.sourceView.frame;
            sourceFrame.size.height = (self.view.frame.size.height - keyboardHeight) - sizeOfToolbar - extraHeight;
            self.sourceView.frame = sourceFrame;
            
            // Provide editor with keyboard height and editor view height
            [self setFooterHeight:(keyboardHeight - 8)];
            [self setContentHeight: self.editorViewFrame.size.height];
            
            //self.toolbarHolder.hidden = _isTitleArea;
            _imageFromDeviceBtn.userInteractionEnabled = !_isTitleArea;
            _boldBtn.userInteractionEnabled = !_isTitleArea;
            _italicBtn.userInteractionEnabled = !_isTitleArea;
            _strikeThroughBtn.userInteractionEnabled = !_isTitleArea;
            _h1Btn.userInteractionEnabled = !_isTitleArea;
            _h2Btn.userInteractionEnabled = !_isTitleArea;
            _h3Btn.userInteractionEnabled = !_isTitleArea;
            _h4Btn.userInteractionEnabled = !_isTitleArea;
            _isTitleArea = FALSE;
            
        } completion:^(BOOL finished) {
            [self downStatusForKeyBIndictorImage];
            //NSLog(@" 显示22 ====== > %@ --- %f --- %f",self.toolbarHolder,keyboardHeight,sizeOfToolbar);
        }];
        
        ////NSLog(@" 显示键盘 ");
        
    } else { // 隐藏
        
        ////NSLog(@" 隐藏键盘 ");
        
        [UIView animateWithDuration:duration delay:0 options:animationOptions animations:^{
            
            CGRect frame = self.toolbarHolder.frame;
            
            if (_alwaysShowToolbar) {
                frame.origin.y = self.view.frame.size.height - sizeOfToolbar - CGRectGetHeight(self.tribePiker.frame);
            } else {
                frame.origin.y = self.view.frame.size.height + keyboardHeight;
            }
            
            self.toolbarHolder.frame = frame;
            _toolBarIsDown = TRUE;
            //NSLog(@" 隐藏11 ====== > %@",self.toolbarHolder);
            // Editor View
            CGRect editorFrame = self.editorView.frame;
            
            if (_alwaysShowToolbar) {
                editorFrame.size.height = ((self.view.frame.size.height - sizeOfToolbar) - extraHeight);
            } else {
                editorFrame.size.height = self.view.frame.size.height;
            }
            
            self.editorView.frame = editorFrame;
            self.editorViewFrame = self.editorView.frame;
            self.editorView.scrollView.contentInset = UIEdgeInsetsZero;
            self.editorView.scrollView.scrollIndicatorInsets = UIEdgeInsetsZero;
            
            // Source View
            CGRect sourceFrame = self.sourceView.frame;
            
            if (_alwaysShowToolbar) {
                sourceFrame.size.height = ((self.view.frame.size.height - sizeOfToolbar) - extraHeight);
            } else {
                sourceFrame.size.height = self.view.frame.size.height;
            }
            
            self.sourceView.frame = sourceFrame;
            
            [self setFooterHeight:0];
            [self setContentHeight:self.editorViewFrame.size.height];
            
            
            // 再将 Toolbar 在高处显示出来
            if (_insertType == InsertImageClickedTypeHS) {
                
                CGRect frame = self.toolbarHolder.frame;
                frame.origin.y = CGRectGetMinY(_recentPHView.frame) - sizeOfToolbar;
                self.toolbarHolder.frame = frame;
                _toolBarIsDown = FALSE;
            }
            
        } completion:^(BOOL finished) {
            [self downStatusForKeyBIndictorImage];
            //NSLog(@" 隐藏22 ====== > %@",self.toolbarHolder);
        }];
        
    }
    
}


#pragma mark - UIWebView Delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    
    NSString *urlString = [[request URL] absoluteString];
    ////NSLog(@" getText : \n %@ \n \n", [self getText]);
    ////NSLog(@" getHTML : \n %@ \n \n", [self getHTML]);
    //NSLog(@"urlString : \n %@ \n \n", urlString);
    
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        return NO;
    } else if ([urlString rangeOfString:@"callback://0/"].location != NSNotFound) {
        
        // We recieved the callback
        NSString *className = [urlString stringByReplacingOccurrencesOfString:@"callback://0/" withString:@""];
        [self updateToolBarWithButtonName:className];
        
        //
        NSString *curString = [self getHTML];
        if (curString.length < _lastContent.length) { // 删除操作
            
            ////NSLog(@" \n \ncurString: %lu \n _lastContent :%lu \n \n",(unsigned long)curString.length,(unsigned long)_lastContent.length);
            
            if ([curString rangeOfString:@"deleteImgID"].location == NSNotFound && self.failureModels.count > 0) {
                [self.failureModels removeAllObjects];
                [self removeTopNavProgressTip];
            }
            if (curString.length <= 0) { // 删除为空
                // 1
                //                [self setHTML:curString title:curTitle];
                //                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                //                    [self loadResources];
                //                    dispatch_async(dispatch_get_main_queue(), ^{
                //                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //                            [self focusTextEditor];
                //                        });
                //                    });
                //                });
                
                // 2
                //                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //                    [self focusTextEditor];
                //                    if (curTitle.length > 0 || curTitle != nil) {
                //                        [self setHTML:curString title:curTitle];
                //                    }
                //                });
                
                // 3
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    NSString *curTitle = [self getHTMLTitle];
                    [self loadResources];
                    if (curTitle.length > 0 || curTitle != nil) {
                        [self setHTML:curString title:curTitle];
                    }
                });
                
            }
        }
        _lastContent = curString;
        
    } else if ([urlString rangeOfString:@"debug://"].location != NSNotFound) {
        
        //////NSLog(@"Debug Found");
        
        // We recieved the callback
        //NSString *debug = [urlString stringByReplacingOccurrencesOfString:@"debug://" withString:@""];
        //debug = [debug stringByReplacingPercentEscapesUsingEncoding:NSStringEncodingConversionAllowLossy];
        //////NSLog(@"%@", debug);
        
    } else if ([urlString rangeOfString:@"scroll://"].location != NSNotFound) {
        
        NSInteger position = [[urlString stringByReplacingOccurrencesOfString:@"scroll://" withString:@""] integerValue];
        [self editorDidScrollWithPosition:position];
        
    }else if([urlString rangeOfString:@"reloadimageid://"].location != NSNotFound){ // 点击图片重新上传按钮 reloadImageid
        NSArray *strArr = [urlString componentsSeparatedByString:@"://"];
        NSString *imgFlag = [strArr lastObject];
        
        // 寻找对应的 model
        HNBAssetModel *curModel = [self queryModelAccordingBasicTag:imgFlag dataBase:self.failureModels];
        // 发起图片上传
        if (curModel && [HNBUtils isConnectionAvailable]) {
            [self reloadingImageGrayWithElementID:imgFlag loading:_loadingLocalURL];
            [self upLoadImage:curModel isReload:TRUE];
            //////NSLog(@" \n 数字333 \n %@ \n \n",[self getHTML]);
        }
        
    }else if([urlString rangeOfString:@"deleteimageid://"].location != NSNotFound){ // 点击图片删除按钮 deleteimageid
        NSArray *strArr = [urlString componentsSeparatedByString:@"://"];
        NSString *imgFlag = [strArr lastObject];
        
        // 寻找对应的 model
        HNBAssetModel *curModel = [self queryModelAccordingBasicTag:imgFlag dataBase:self.failureModels];
        // 删除数组中的对应模型
        if (curModel) {
            [self.failureModels removeObject:curModel];
        }
        
        if (self.failureModels.count <= 0) {
            [self removeTopNavProgressTip];
        }
        
        [self updateFailureStateDisplay];
        
    }else if([urlString rangeOfString:@"removeimagewithmask"].location != NSNotFound){
        [self updateFailureStateDisplay];
    }
    
    return YES;
    
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.editorLoaded = YES;
    
    if (!self.internalHTML) {
        self.internalHTML = @"";
    }
    [self updateHTML];
    
    if(self.placeholder) {
        [self setPlaceholderText];
    }
    
    if (self.customCSS) {
        [self updateCSS];
    }
    
    if (self.shouldShowKeyboard) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self focusTextEditor];
        });
    }
    
    /*
     
     Callback for when text is changed, solution posted by richardortiz84 https://github.com/nnhubbard/ZSSRichTextEditor/issues/5
     
     */
    JSContext *ctx = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    ctx[@"contentUpdateCallback"] = ^(JSValue *msg) {
        
        if (_receiveEditorDidChangeEvents) {
            
            [self editorDidChangeWithText:[self getText] andHTML:[self getHTML]];
            
        }
        
        [self checkForMentionOrHashtagInText:[self getText]];
        
    };
    [ctx evaluateScript:@"document.getElementById('zss_editor_content').addEventListener('input', contentUpdateCallback, false);"];
    
    ctx[@"hideToolbar"] = ^(){
        //NSArray *args = [JSContext currentArguments];
        _isTitleArea = TRUE;
        [self touchTitleSection];
    };
    //    ctx[@"showToolbar"] = ^(){
    //        NSArray *args = [JSContext currentArguments];
    //        NSLog(@"showToolbar : %@",args);
    //        self.toolbarHolder.hidden = FALSE;
    //    };
    
}

#pragma mark --------------------- HNB - method

- (void)dismissOrShowKeyboard {
    
    if (!_toolBarIsDown) {
        
        if (_recentPHView && !_recentPHView.hidden) {
            [_recentPHView hideRecentPhoto];
            _insertType = KeyBArrowClickedTypeHDown;
            // 再将 Toolbar 在低处显示出来
            CGRect frame = self.toolbarHolder.frame;
            frame.origin.y = CGRectGetMinY(self.tribePiker.frame) - CGRectGetHeight(self.toolbarHolder.frame);
            self.toolbarHolder.frame = frame;
            _toolBarIsDown = TRUE;
            [self downStatusForKeyBIndictorImage];
            
        }else{
            //[self.view endEditing:YES];
            [self blurTextEditor];
        }
        
    }else{
        
        [self focusTextEditor];
        
    }
    
}

- (void)downStatusForKeyBIndictorImage{
    
    // 箭头图片更新
    NSString *imgName = !_toolBarIsDown ? @"ZSSkeyboard_down.png" : @"ZSSkeyboard.png";
    [self.keyBImageView setImage:[UIImage imageNamed:imgName]];
    
    // 图片选择器选中状态更新
    if (_recentPHView.hidden) {
        [_imageFromDeviceBtn setImage:[UIImage imageNamed:@"ZSSimageFromDevice.png"] forState:UIControlStateNormal];
        _imageFromDeviceBtn.selected = NO;
    } else {
        [_imageFromDeviceBtn setImage:[UIImage imageNamed:@"ZSSimageFromDevice_selected.png"] forState:UIControlStateNormal];
        _imageFromDeviceBtn.selected = YES;
    }
    
    // 来源置空
    _insertType = InsertImageClickedTypeNone;
    
}

- (void)createRecentImagesPicker{
    float height = 322;
    if (IS_IPHONE_X) {
        /*适配Iphone_X*/
        _recentPHView = [[RecentPhotoView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-height - SUIT_IPHONE_X_HEIGHT - 32, SCREEN_WIDTH, height) superViewController:self];
    }else{
        _recentPHView = [[RecentPhotoView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-height, SCREEN_WIDTH, height) superViewController:self];
    }
    [self.view addSubview:_recentPHView];
    __weak typeof(self)weakSelf = self;
    __weak typeof(_loadingLocalURL)weakLoadingLocalURL = _loadingLocalURL;
    
    _recentPHView.didFinishPickingPhoto = ^(NSArray<HNBAssetModel *> *modelArr){
        /*数据上报*/
        //[HNBClick event:@"190032" Content:nil];
        
        _selectedTotal = modelArr.count;
        [UpLoadImageProgressTip defaultInstance].currentState = UpLoadImageProgressTipSuccess;
        if (_sucUpLoadCount == 0 && _isAppeared) {
            // 相册回退有延迟
            [[UpLoadImageProgressTip defaultInstance] updateUpLoadImageProgressTipText:[NSString stringWithFormat:@"已上传0/%ld张图片",(long)modelArr.count]];
        }
        if (modelArr != nil && modelArr.count > 0) {
            for (NSInteger index = 0; index < modelArr.count; index ++) {
                
                HNBAssetModel *model = modelArr[index];
                UIImage *curImage = (UIImage *)model.image;
                CGSize imgSize = curImage.size;
                CGFloat tmpWidth = imgSize.width > (SCREEN_WIDTH - 15*2.0 - 24 * 2.0) ? (SCREEN_WIDTH - 15*2.0 - 24 * 2.0) : imgSize.width;
                CGFloat tmpHeight = imgSize.height / imgSize.width * tmpWidth;
                CGFloat side_gap = (SCREEN_WIDTH - 220.0)/2.0;
                
                [weakSelf insertImageWithURLString:[NSString stringWithFormat:@"%@",[NSURL fileURLWithPath:model.localURL]]
                                             width:[NSString stringWithFormat:@"%f",tmpWidth]
                                            height:[NSString stringWithFormat:@"%f",tmpHeight]
                                           sideGap:[NSString stringWithFormat:@"%f",side_gap]
                                           imageID:[NSString stringWithFormat:@"%ld",(long)model.basicTag]
                                           loading:weakLoadingLocalURL];
                if (index < modelArr.count - 1) {
                    [weakSelf.editorView stringByEvaluatingJavaScriptFromString:@"zss_editor.prepareInsert();"];
                }
                // 并发子线程上传图片
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [weakSelf upLoadImage:model isReload:FALSE];
                });
                
            }
        }
        
        
    };
    [_recentPHView hideRecentPhoto];
}

#pragma mark ------ HNBTribePickerViewDelegate 圈子选择

-(void)didSelectedHNBTribePickerView:(id)origin{
    
    /*<编辑旧帖、在具体圈子入口处进入、参与话题讨论 ，不准许选择圈子>*/
    if (self.entryOrigin == PostingEntryOriginTribeDetailNewThem ||
        self.entryOrigin == PostingEntryOriginEditingOldTribeThem ||
        self.entryOrigin == PostingEntryOriginJoinTopicDiscuss) {
        return;
    }
    
    /*数据上报*/
    //[HNBClick event:@"190021" Content:nil];
    [self initTribeData];
    
    NSMutableArray *tribesArry = [[NSMutableArray alloc] init];
    for (TribeModel * f in self.tribeArray) {
        [tribesArry addObject:f.name];
    }
    
    [ActionSheetStringPicker showPickerWithTitle:@"请选择圈子"
                                            rows:tribesArry
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           
                                           if (tribesArry.count <= 0) {
                                               /*数据防护，没有数据时不赋值*/
                                               ////NSLog(@"NO Tribe Data");
                                           }else{
                                               TribeModel * f = _tribeArray[selectedIndex];
                                               ////NSLog(@" f.name:%@ \nf.id: %@ \n",f.name,f.id);
                                               self.choseTribeCode = f.Id;
                                               self.chosedTribeName = f.name;
                                               [self.tribePiker updateDisplayTribeName:f.name];
                                           }
                                           
                                       } cancelBlock:^(ActionSheetStringPicker *picker) {
                                           
                                           ////NSLog(@"Block Picker Canceled");
                                           
                                       } origin:origin];
    
    
}

/* 圈子选择器数据初始化 */
- (void) initTribeData
{
    NSArray *names = @[@"美国",@"英国",@"法国",@"德国",@"荷兰",@"瑞士",@"华盛顿",@"纽约",@"新泽西",@"爱尔兰"];
    NSArray *ids = @[@"200819",@"200820",@"200821",@"200822",@"200823",@"200824",@"200825",@"200826",@"200827",@"200828",@"200829",@"200890",@"200889",@"200868"];
    self.tribeArray = [[NSMutableArray alloc] init];
    for (NSInteger cou = 0; cou < 9; cou ++) {
        TribeModel *f = [[TribeModel alloc] init];
        f.name = names[cou];
        f.Id = ids[cou];
        f.timestamp = @"158899689659.860";
        [self.tribeArray addObject:f];
    }
    
}

#pragma mark ------ 查找算法

- (HNBAssetModel *)queryModelAccordingBasicTag:(NSString *)basicTag dataBase:(NSArray *)dataBase{
    __block HNBAssetModel *f = nil;
    [dataBase enumerateObjectsUsingBlock:^(HNBAssetModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([basicTag isEqualToString:[NSString stringWithFormat:@"%ld",(long)obj.basicTag]]) {
            f = obj;
        }
    }];
    return f;
}

#pragma mark ------ 图片上传

- (void)upLoadImage:(HNBAssetModel *)model isReload:(BOOL)isReload{
    
    [DataFetcher hnbRichTextUpdatePostImage:model WithSucceedHandler:^(id JSON) {
        
        int errCode= [[JSON valueForKey:@"state"] intValue];
        if (errCode == 0) {
            
            id dataDic = [JSON valueForKey:@"data"];
            NSString *real_url = [dataDic valueForKey:@"real_url"];
            [self updateImageSrc:real_url imageID:[NSString stringWithFormat:@"%ld",(long)model.basicTag]];
            //NSLog(@" updateImageSrc ===== > \n %@ \n \n \n",[self getHTML]);
            // 删除对应图片缓存
            [HNBFileManager removeRichTextImageFromPath:model.localURL];
            //NSLog(@" \n === > \n 路径： %@ 移除情况: %d \n",model.localURL,isClear);
            // 传图成功后移除 mask
            [self removeGrayMaskWithElementID:[NSString stringWithFormat:@"%ld",(long)model.basicTag]];
            
            // 检查失败模型数组
            if ([self.failureModels containsObject:model]) {
                [self.failureModels removeObject:model];
                if (self.failureModels.count <= 0) {
                    [self removeTopNavProgressTip];
                }
            }
            
            // 更新数字
            if (!isReload) {
                _sucUpLoadCount ++;
                [self updataProgressTip];
            }else{
                [self updateFailureStateDisplay];
            }
            
        }
        
    } withFailHandler:^(id error) {
        
        if (![self.failureModels containsObject:model]) {
            [self.failureModels addObject:model];
        }
        [self modifyGrayMaskWithElementID:[NSString stringWithFormat:@"%ld",(long)model.basicTag] delete:_deleteLocalURL reload:_reloadLocalURL];
        
        // 更新数字
        if (!isReload) {
            _failureUpLoadCount ++;
            [self updataProgressTip];
        }else{
            [self updateFailureStateDisplay];
        }
        
    }];
    
    
}

- (void)updataProgressTip{
    
    if (_isAppeared) {
        
        BOOL isCompletion = _sucUpLoadCount + _failureUpLoadCount == _selectedTotal ? TRUE : FALSE;
        if (isCompletion && _failureUpLoadCount > 0) {
            if ([UpLoadImageProgressTip defaultInstance].currentState != UpLoadImageProgressTipRemove) {
                [UpLoadImageProgressTip defaultInstance].currentState = UpLoadImageProgressTipFailure;
            }
            [self updateFailureStateDisplay];
        }else{
            [[UpLoadImageProgressTip defaultInstance] updateUpLoadImageProgressTipText:[NSString stringWithFormat:@"已上传%ld/%ld张图片",(long)_sucUpLoadCount,(long)_selectedTotal]];
        }
        
        // 上传过程中有删除操作 - _failureUpLoadCount > 0 但该图片已被删除
        if (![self queryImageMaskTagForCurrentDOM]) {
            [self.failureModels removeAllObjects];
            [self removeTopNavProgressTip];
        }
        
    }
    
}


- (void)updateFailureStateDisplay{
    // NSLog(@" \n \n currentState :%d  \n \n",[UpLoadImageProgressTip defaultInstance].currentState);
    if ([UpLoadImageProgressTip defaultInstance].currentState == UpLoadImageProgressTipFailure) {
        NSInteger failurCount = [self queryDeleteMaskCountForCurrentDOM];
        if (failurCount > 0) {
            [[UpLoadImageProgressTip defaultInstance] updateUpLoadImageProgressTipText:[NSString stringWithFormat:@"%ld张图上传失败，请重试...",(long)failurCount]];
        } else {
            [self removeTopNavProgressTip];
        }
    }
    
}

- (void)removeTopNavProgressTip{
    [[UpLoadImageProgressTip defaultInstance] removeUpLoadImageProgressTip];
    _selectedTotal = 0;
    _sucUpLoadCount = 0;
    _failureUpLoadCount = 0;
}

#pragma mark ------ 懒加载

- (HNBTribePickerView *)tribePiker{
    
    if (_tribePiker == nil) {
        CGRect rect = CGRectZero;
        rect.size.width = self.view.frame.size.width;
        rect.size.height = kTribePickerViewHeight;
        /*适配IPhoneX*/
        rect.origin.y = SCREEN_HEIGHT - rect.size.height - SCREEN_STATUSHEIGHT - SCREEN_NAVHEIGHT - SUIT_IPHONE_X_HEIGHT;
        _tribePiker = [[HNBTribePickerView alloc] initWithFrame:rect];
        self.tribePiker.delegate = self;
    }
    return _tribePiker;
    
}

#pragma mark ------ js 交互

- (void)insertImageWithURLString:(NSString *)url width:(NSString *)w height:(NSString *)h sideGap:(NSString *)sg imageID:(NSString *)imgID loading:(NSString *)loadingURL{
    NSString *trigger = [NSString stringWithFormat:@"zss_editor.insertImage(\"%@\", \"%@\", \"%@\", \"%@\",\"%@\",\"%@\");", url, w,h,imgID,loadingURL,sg];
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
}

- (void)insertImageBase64String:(NSString *)imageBase64String width:(NSString *)w height:(NSString *)h imageID:(NSString *)imgID{
    NSString *trigger = [NSString stringWithFormat:@"zss_editor.insertImageBase64String(\"%@\", \"%@\", \"%@\", \"%@\");", imageBase64String, w,h,imgID];
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
}

- (void)updateImageSrc:(NSString *)imgURL imageID:(NSString *)imgID{
    NSString *trigger = [NSString stringWithFormat:@"zss_editor.updateImageSrc(\"%@\", \"%@\");", imgURL,imgID];
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
}

- (NSString *)getHTMLTitle{
    
    NSString *trigger = [NSString stringWithFormat:@"zss_editor.getTitle();"];
    NSString *cont = [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
    
    return cont;
}

- (void)modifyGrayMaskWithElementID:(NSString *)eleID delete:(NSString *)deleteURL reload:(NSString *)reload{
    NSString *trigger = [NSString stringWithFormat:@"zss_editor.modifyGrayMaskWithElementID(\"%@\",\"%@\",\"%@\");",eleID,deleteURL,reload];
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
}

- (void)removeGrayMaskWithElementID:(NSString *)eleID{
    
    NSString *trigger = [NSString stringWithFormat:@"zss_editor.removeGrayMaskWithElementID(\"%@\");",eleID];
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
    
}

- (void)reloadingImageGrayWithElementID:(NSString *)eleID loading:(NSString *)loadingURL{
    
    NSString *trigger = [NSString stringWithFormat:@"zss_editor.reloadingImageGrayWithElementID(\"%@\", \"%@\");",eleID,loadingURL];
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
}

- (void)updateExtraHeightWithKeyBoardHeight:(CGFloat)kHeight{
    NSString *kH = [NSString stringWithFormat:@"%f",kHeight];
    NSString *js = [NSString stringWithFormat:@"zss_editor.updateExtraHeightWithKeyBoardHeight(\"%@\")",kH];
    [self.editorView stringByEvaluatingJavaScriptFromString:js];
}

-(BOOL)queryImageUploadingTagForCurrentDOM{
    NSString *js = @"zss_editor.queryImageUploadingTagForCurrentDOM()";
    NSString *rlt = [self.editorView stringByEvaluatingJavaScriptFromString:js];
    if (![rlt isEqualToString:@"0"]) {
        return TRUE;
    }
    return FALSE;
}


-(BOOL)queryImageMaskTagForCurrentDOM{
    NSString *js = @"zss_editor.queryImageMaskTagForCurrentDOM()";
    NSString *rlt = [self.editorView stringByEvaluatingJavaScriptFromString:js];
    //    NSLog(@" ------ > \n \n queryImageMaskTagForCurrentDOM - rlt:%@ \n \n",rlt);
    if (![rlt isEqualToString:@"0"]) {
        return TRUE;
    }
    return FALSE;
}

- (NSInteger)queryImagesCountForCurrentDOM{
    NSString *js = @"zss_editor.queryImagesCountForCurrentDOM()";
    NSString *rlt = [self.editorView stringByEvaluatingJavaScriptFromString:js];
    NSInteger imgsCount = [rlt integerValue];
    //NSLog(@" 当前的图片数 %ld",imgsCount);
    return imgsCount;
}

- (NSInteger)queryDeleteMaskCountForCurrentDOM{
    NSString *js = @"zss_editor.queryDeleteMaskCountForCurrentDOM()";
    NSString *rlt = [self.editorView stringByEvaluatingJavaScriptFromString:js];
    NSInteger deleteCount = [rlt integerValue];
    //NSLog(@" \n \n deleteCount %ld  \n \n ",deleteCount);
    return deleteCount;
}

- (NSInteger)queryUploadingMaskCountForCurrentDOM{
    NSString *js = @"zss_editor.queryUploadingMaskCountForCurrentDOM()";
    NSString *rlt = [self.editorView stringByEvaluatingJavaScriptFromString:js];
    NSInteger uploadingCount = [rlt integerValue];
    //NSLog(@" \n \n uploadingCount %ld  \n \n ",uploadingCount);
    return uploadingCount;
}

-(NSString *)tidyEditorContentForServer{
    
    NSString *js = @"zss_editor.tidyEditorContentForServer()";
    NSString *tidyContent = [self.editorView stringByEvaluatingJavaScriptFromString:js];
    tidyContent = [self removeQuotesFromHTML:tidyContent];
    tidyContent = [self tidyHTML:tidyContent];
    tidyContent = [self clearUpHTMLContent:tidyContent];
    return tidyContent;
}

- (NSString *)getOriginalDOM{
    NSString *js = @"zss_editor.getOriginalDOM()";
    NSString *orgdom = [self.editorView stringByEvaluatingJavaScriptFromString:js];
    return orgdom;
}

- (NSString *)getTidyedDOMAfterDelateHiddedHTML{
    NSString *js = @"zss_editor.getTidyedDOMAfterDelateHiddedHTML()";
    NSString *orgdom = [self.editorView stringByEvaluatingJavaScriptFromString:js];
    return orgdom;
}

- (void)titleContentEditable:(NSString *)able{
    NSString *js = [NSString stringWithFormat:@"zss_editor.titleContentEditable(\"%@\");",able];
    [self.editorView stringByEvaluatingJavaScriptFromString:js];
}

#pragma mark ------ private method
// 发布按钮
- (void)postSubmit{
    [[UpLoadImageProgressTip defaultInstance] removeUpLoadImageProgressTip];
}


- (NSString *)clearUpHTMLContent:(NSString *)cont{
    // 内容 - 处理服务器冗余代码
    if ([cont isEqualToString:@"<br />"]) {
        return @"";
    }
    return cont;
    
}

-(void)queryAndExtractFailureModels{
    NSArray *dataSource = [HNBFileManager readArrAPPNetInterfaceDataWithCacheKey:LOCAL_DRAFT_FAILRE_IMAGEMODEL];
    if (dataSource != nil && dataSource.count > 0) {
        for (NSInteger cou = 0; cou < dataSource.count; cou ++) {
            NSDictionary *dict = dataSource[cou];
            HNBAssetModel *f = [[HNBAssetModel alloc] init];
            NSNumber *tmpNumber = (NSNumber *)[dict valueForKey:@"basicTag"];
            NSString *imagePath = (NSString *)[dict valueForKey:@"imagePath"];
            f.basicTag = [tmpNumber integerValue];
            f.image = [UIImage imageWithContentsOfFile:imagePath];
            [self.failureModels addObject:f];
        }
    }
    
}

- (void)touchTitleSection{
    NSLog(@" %s ",__FUNCTION__);
}

#pragma mark - 非需求
#pragma mark Editor Modification Section

- (void)setCSS:(NSString *)css {
    
    self.customCSS = css;
    
    if (self.editorLoaded) {
        [self updateCSS];
    }
    
}

- (void)updateCSS {
    
    if (self.customCSS != NULL && [self.customCSS length] != 0) {
        
        NSString *js = [NSString stringWithFormat:@"zss_editor.setCustomCSS(\"%@\");", self.customCSS];
        [self.editorView stringByEvaluatingJavaScriptFromString:js];
        
    }
    
}

- (void)setPlaceholderText {
    
    //Call the setPlaceholder javascript method if a placeholder has been set
    if (self.placeholder != NULL && [self.placeholder length] != 0) {
    
        NSString *js = [NSString stringWithFormat:@"zss_editor.setPlaceholder(\"%@\");", self.placeholder];
        [self.editorView stringByEvaluatingJavaScriptFromString:js];
        
    }
    
}

- (void)setFooterHeight:(float)footerHeight {
    
    //Call the setFooterHeight javascript method
    NSString *js = [NSString stringWithFormat:@"zss_editor.setFooterHeight(\"%f\");", footerHeight];
    [self.editorView stringByEvaluatingJavaScriptFromString:js];
    
}

- (void)setContentHeight:(float)contentHeight {
    
    //Call the contentHeight javascript method
    NSString *js = [NSString stringWithFormat:@"zss_editor.contentHeight = %f;", contentHeight];
    [self.editorView stringByEvaluatingJavaScriptFromString:js];
    
}

#pragma mark - Editor Interaction : focus 、blur

- (void)focusTextEditor {
    self.editorView.keyboardDisplayRequiresUserAction = NO;
    NSString *js = [NSString stringWithFormat:@"zss_editor.focusEditor();"];
    [self.editorView stringByEvaluatingJavaScriptFromString:js];
}

- (void)blurTextEditor {
    NSString *js = [NSString stringWithFormat:@"zss_editor.blurEditor();"];
    [self.editorView stringByEvaluatingJavaScriptFromString:js];
}

- (void)setHTML:(NSString *)html title:(NSString *)title{
    
    self.internalHTML = html;
    self.inneralTitle = title;
    
    if (self.editorLoaded) {
        [self updateHTML];
    }
    
}

- (void)updateHTML {
    if (self.inneralTitle == nil) {
        self.inneralTitle = @"";
    }
    //NSString *html = self.internalHTML;
    //self.sourceView.text = html;
    self.sourceView.text = self.internalHTML;
    NSString *cleanedHTML = [self removeQuotesFromHTML:self.internalHTML];
    NSLog(@" 再编辑 DOM 树:%@",cleanedHTML);
    NSString *trigger = [NSString stringWithFormat:@"zss_editor.setHTML(\"%@\",\"%@\");", cleanedHTML,self.inneralTitle];
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
    
}

- (NSString *)getHTML {
    
    NSString *html = [self.editorView stringByEvaluatingJavaScriptFromString:@"zss_editor.getHTML();"];
    html = [self removeQuotesFromHTML:html];
    html = [self tidyHTML:html];
    html = [self clearUpHTMLContent:html];
    return html;
    
}


- (void)insertHTML:(NSString *)html {
    
    NSString *cleanedHTML = [self removeQuotesFromHTML:html];
    NSString *trigger = [NSString stringWithFormat:@"zss_editor.insertHTML(\"%@\");", cleanedHTML];
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
    
}

- (NSString *)getText {
    
    return [self.editorView stringByEvaluatingJavaScriptFromString:@"zss_editor.getText();"];
    
}

- (void)dismissKeyboard {
    [self.view endEditing:YES];
}

- (void)showHTMLSource:(ZSSBarButtonItem *)barButtonItem {
    if (self.sourceView.hidden) {
        self.sourceView.text = [self getHTML];
        self.sourceView.hidden = NO;
        barButtonItem.tintColor = [UIColor blackColor];
        self.editorView.hidden = YES;
        [self enableToolbarItems:NO];
    } else {
        //[self setHTML:self.sourceView.text];
        [self setHTML:self.sourceView.text title:nil];
        barButtonItem.tintColor = [self barButtonItemDefaultColor];
        self.sourceView.hidden = YES;
        self.editorView.hidden = NO;
        [self enableToolbarItems:YES];
    }
}

- (void)removeFormat {
    NSString *trigger = @"zss_editor.removeFormating();";
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
}

- (void)alignLeft {
    NSString *trigger = @"zss_editor.setJustifyLeft();";
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
}

- (void)alignCenter {
    NSString *trigger = @"zss_editor.setJustifyCenter();";
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
}

- (void)alignRight {
    NSString *trigger = @"zss_editor.setJustifyRight();";
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
}

- (void)alignFull {
    NSString *trigger = @"zss_editor.setJustifyFull();";
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
}

- (void)setSubscript {
    NSString *trigger = @"zss_editor.setSubscript();";
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
}

- (void)setUnderline {
    NSString *trigger = @"zss_editor.setUnderline();";
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
}

- (void)setSuperscript {
    NSString *trigger = @"zss_editor.setSuperscript();";
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
}


- (void)setUnorderedList {
    NSString *trigger = @"zss_editor.setUnorderedList();";
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
}

- (void)setOrderedList {
    NSString *trigger = @"zss_editor.setOrderedList();";
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
}

- (void)setHR {
    NSString *trigger = @"zss_editor.setHorizontalRule();";
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
}

- (void)setIndent {
    NSString *trigger = @"zss_editor.setIndent();";
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
}

- (void)setOutdent {
    NSString *trigger = @"zss_editor.setOutdent();";
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
}

- (void)heading5 {
    NSString *trigger = @"zss_editor.setHeading('h5');";
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
}

- (void)heading6 {
    NSString *trigger = @"zss_editor.setHeading('h6');";
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
}

- (void)paragraph {
    NSString *trigger = @"zss_editor.setParagraph();";
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
}

- (void)showFontsPicker {
        
    // Save the selection location
    [self.editorView stringByEvaluatingJavaScriptFromString:@"zss_editor.prepareInsert();"];
    
    //Call picker
    ZSSFontsViewController *fontPicker = [ZSSFontsViewController cancelableFontPickerViewControllerWithFontFamily:ZSSFontFamilyDefault];
    fontPicker.delegate = self;
    [self.navigationController pushViewController:fontPicker animated:YES];
    
}

- (void)setSelectedFontFamily:(ZSSFontFamily)fontFamily {
    
    NSString *fontFamilyString;
    
    switch (fontFamily) {
        case ZSSFontFamilyDefault:
            fontFamilyString = @"Arial, Helvetica, sans-serif";
            break;
        
        case ZSSFontFamilyGeorgia:
            fontFamilyString = @"Georgia, serif";
            break;
        
        case ZSSFontFamilyPalatino:
            fontFamilyString = @"Palatino Linotype, Book Antiqua, Palatino, serif";
            break;
        
        case ZSSFontFamilyTimesNew:
            fontFamilyString = @"Times New Roman, Times, serif";
            break;
        
        case ZSSFontFamilyTrebuchet:
            fontFamilyString = @"Trebuchet MS, Helvetica, sans-serif";
            break;
        
        case ZSSFontFamilyVerdana:
            fontFamilyString = @"Verdana, Geneva, sans-serif";
            break;
        
        case ZSSFontFamilyCourierNew:
            fontFamilyString = @"Courier New, Courier, monospace";
            break;
        
        default:
            fontFamilyString = @"Arial, Helvetica, sans-serif";
            break;
    }
    
    NSString *trigger = [NSString stringWithFormat:@"zss_editor.setFontFamily(\"%@\");", fontFamilyString];

    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
    
}

- (void)textColor {
    
    // Save the selection location
    [self.editorView stringByEvaluatingJavaScriptFromString:@"zss_editor.prepareInsert();"];
    
    // Call the picker
    HRColorPickerViewController *colorPicker = [HRColorPickerViewController cancelableFullColorPickerViewControllerWithColor:[UIColor whiteColor]];
    colorPicker.delegate = self;
    colorPicker.tag = 1;
    colorPicker.title = NSLocalizedString(@"Text Color", nil);
    [self.navigationController pushViewController:colorPicker animated:YES];
    
}

- (void)bgColor {
    
    // Save the selection location
    [self.editorView stringByEvaluatingJavaScriptFromString:@"zss_editor.prepareInsert();"];
    
    // Call the picker
    HRColorPickerViewController *colorPicker = [HRColorPickerViewController cancelableFullColorPickerViewControllerWithColor:[UIColor whiteColor]];
    colorPicker.delegate = self;
    colorPicker.tag = 2;
    colorPicker.title = NSLocalizedString(@"BG Color", nil);
    [self.navigationController pushViewController:colorPicker animated:YES];
    
}

- (void)setSelectedColor:(UIColor*)color tag:(int)tag {
    
    NSString *hex = [NSString stringWithFormat:@"#%06x",HexColorFromUIColor(color)];
    NSString *trigger;
    if (tag == 1) {
        trigger = [NSString stringWithFormat:@"zss_editor.setTextColor(\"%@\");", hex];
    } else if (tag == 2) {
        trigger = [NSString stringWithFormat:@"zss_editor.setBackgroundColor(\"%@\");", hex];
    }
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
    
}

- (void)undo:(ZSSBarButtonItem *)barButtonItem {
    [self.editorView stringByEvaluatingJavaScriptFromString:@"zss_editor.undo();"];
}

- (void)redo:(ZSSBarButtonItem *)barButtonItem {
    [self.editorView stringByEvaluatingJavaScriptFromString:@"zss_editor.redo();"];
}

- (void)insertLink {
    
    // Save the selection location
    [self.editorView stringByEvaluatingJavaScriptFromString:@"zss_editor.prepareInsert();"];
    
    // Show the dialog for inserting or editing a link
    [self showInsertLinkDialogWithLink:self.selectedLinkURL title:self.selectedLinkTitle];
    
}


- (void)showInsertLinkDialogWithLink:(NSString *)url title:(NSString *)title {
    
    // Insert Button Title
    NSString *insertButtonTitle = !self.selectedLinkURL ? NSLocalizedString(@"Insert", nil) : NSLocalizedString(@"Update", nil);
    
    // Picker Button
    UIButton *am = [UIButton buttonWithType:UIButtonTypeCustom];
    am.frame = CGRectMake(0, 0, 25, 25);
    [am setImage:[UIImage imageNamed:@"ZSSpicker.png" inBundle:[NSBundle bundleForClass:[ZSSRichTextEditor class]] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    [am addTarget:self action:@selector(showInsertURLAlternatePicker) forControlEvents:UIControlEventTouchUpInside];
    
    if ([NSProcessInfo instancesRespondToSelector:@selector(isOperatingSystemAtLeastVersion:)]) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Insert Link", nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = NSLocalizedString(@"URL (required)", nil);
            if (url) {
                textField.text = url;
            }
            textField.rightView = am;
            textField.rightViewMode = UITextFieldViewModeAlways;
            textField.clearButtonMode = UITextFieldViewModeAlways;
        }];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = NSLocalizedString(@"Title", nil);
            textField.clearButtonMode = UITextFieldViewModeAlways;
            textField.secureTextEntry = NO;
            if (title) {
                textField.text = title;
            }
        }];
        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [self focusTextEditor];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:insertButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            UITextField *linkURL = [alertController.textFields objectAtIndex:0];
            UITextField *title = [alertController.textFields objectAtIndex:1];
            if (!self.selectedLinkURL) {
                [self insertLink:linkURL.text title:title.text];
                //////NSLog(@"insert link");
            } else {
                [self updateLink:linkURL.text title:title.text];
            }
            [self focusTextEditor];
        }]];
        [self presentViewController:alertController animated:YES completion:NULL];
        
    } else {
        
        self.alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Insert Link", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) otherButtonTitles:insertButtonTitle, nil];
        self.alertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
        self.alertView.tag = 2;
        UITextField *linkURL = [self.alertView textFieldAtIndex:0];
        linkURL.placeholder = NSLocalizedString(@"URL (required)", nil);
        if (url) {
            linkURL.text = url;
        }
        
        linkURL.rightView = am;
        linkURL.rightViewMode = UITextFieldViewModeAlways;
        
        UITextField *alt = [self.alertView textFieldAtIndex:1];
        alt.secureTextEntry = NO;
        alt.placeholder = NSLocalizedString(@"Title", nil);
        if (title) {
            alt.text = title;
        }
        
        [self.alertView show];
    }
    
}


- (void)insertLink:(NSString *)url title:(NSString *)title {
    
    NSString *trigger = [NSString stringWithFormat:@"zss_editor.insertLink(\"%@\", \"%@\");", url, title];
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
    
}


- (void)updateLink:(NSString *)url title:(NSString *)title {
    NSString *trigger = [NSString stringWithFormat:@"zss_editor.updateLink(\"%@\", \"%@\");", url, title];
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
}


- (void)dismissAlertView {
    [self.alertView dismissWithClickedButtonIndex:self.alertView.cancelButtonIndex animated:YES];
}

- (void)addCustomToolbarItemWithButton:(UIButton *)button {
    
    if(self.customBarButtonItems == nil)
    {
        self.customBarButtonItems = [NSMutableArray array];
    }
    
    button.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:28.5f];
    [button setTitleColor:[self barButtonItemDefaultColor] forState:UIControlStateNormal];
    [button setTitleColor:[self barButtonItemSelectedDefaultColor] forState:UIControlStateHighlighted];
    
    ZSSBarButtonItem *barButtonItem = [[ZSSBarButtonItem alloc] initWithCustomView:button];
    
    [self.customBarButtonItems addObject:barButtonItem];
    
    [self buildToolbar];
}

- (void)addCustomToolbarItem:(ZSSBarButtonItem *)item {
    
    if(self.customZSSBarButtonItems == nil)
    {
        self.customZSSBarButtonItems = [NSMutableArray array];
    }
    [self.customZSSBarButtonItems addObject:item];
    
    [self buildToolbar];
}


- (void)removeLink {
    [self.editorView stringByEvaluatingJavaScriptFromString:@"zss_editor.unlink();"];
}

- (void)quickLink {
    [self.editorView stringByEvaluatingJavaScriptFromString:@"zss_editor.quickLink();"];
}

- (void)insertImage {
    
    // Save the selection location
    [self.editorView stringByEvaluatingJavaScriptFromString:@"zss_editor.prepareInsert();"];
    
    [self showInsertImageDialogWithLink:self.selectedImageURL alt:self.selectedImageAlt];
    
}

- (void)showInsertImageDialogWithLink:(NSString *)url alt:(NSString *)alt {
    
    // Insert Button Title
    NSString *insertButtonTitle = !self.selectedImageURL ? NSLocalizedString(@"Insert", nil) : NSLocalizedString(@"Update", nil);
    
    // Picker Button
    UIButton *am = [UIButton buttonWithType:UIButtonTypeCustom];
    am.frame = CGRectMake(0, 0, 25, 25);
    [am setImage:[UIImage imageNamed:@"ZSSpicker.png" inBundle:[NSBundle bundleForClass:[ZSSRichTextEditor class]] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    [am addTarget:self action:@selector(showInsertImageAlternatePicker) forControlEvents:UIControlEventTouchUpInside];
    
    if ([NSProcessInfo instancesRespondToSelector:@selector(isOperatingSystemAtLeastVersion:)]) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Insert Image", nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = NSLocalizedString(@"URL (required)", nil);
            if (url) {
                textField.text = url;
            }
            textField.rightView = am;
            textField.rightViewMode = UITextFieldViewModeAlways;
            textField.clearButtonMode = UITextFieldViewModeAlways;
        }];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = NSLocalizedString(@"Alt", nil);
            textField.clearButtonMode = UITextFieldViewModeAlways;
            textField.secureTextEntry = NO;
            if (alt) {
                textField.text = alt;
            }
        }];
        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [self focusTextEditor];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:insertButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            UITextField *imageURL = [alertController.textFields objectAtIndex:0];
            UITextField *alt = [alertController.textFields objectAtIndex:1];
            if (!self.selectedImageURL) {
                [self insertImage:imageURL.text alt:alt.text];
            } else {
                [self updateImage:imageURL.text alt:alt.text];
            }
            [self focusTextEditor];
        }]];
        [self presentViewController:alertController animated:YES completion:NULL];
        
    } else {
        
        self.alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Insert Image", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) otherButtonTitles:insertButtonTitle, nil];
        self.alertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
        self.alertView.tag = 1;
        UITextField *imageURL = [self.alertView textFieldAtIndex:0];
        imageURL.placeholder = NSLocalizedString(@"URL (required)", nil);
        if (url) {
            imageURL.text = url;
        }
        
        imageURL.rightView = am;
        imageURL.rightViewMode = UITextFieldViewModeAlways;
        imageURL.clearButtonMode = UITextFieldViewModeAlways;
        
        UITextField *alt1 = [self.alertView textFieldAtIndex:1];
        alt1.secureTextEntry = NO;
        alt1.placeholder = NSLocalizedString(@"Alt", nil);
        alt1.clearButtonMode = UITextFieldViewModeAlways;
        if (alt) {
            alt1.text = alt;
        }
        
        [self.alertView show];
    }
    
}

- (void)showInsertImageDialogFromDeviceWithScale:(CGFloat)scale alt:(NSString *)alt {
    
    // Insert button title
    NSString *insertButtonTitle = !self.selectedImageURL ? NSLocalizedString(@"Pick Image", nil) : NSLocalizedString(@"Pick New Image", nil);
    
    //If the OS version supports the new UIAlertController go for it. Otherwise use the old UIAlertView
    if ([NSProcessInfo instancesRespondToSelector:@selector(isOperatingSystemAtLeastVersion:)]) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Insert Image From Device", nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        //Add alt text field
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = NSLocalizedString(@"Alt", nil);
            textField.clearButtonMode = UITextFieldViewModeAlways;
            textField.secureTextEntry = NO;
            if (alt) {
                textField.text = alt;
            }
        }];
        
        //Add scale text field
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.clearButtonMode = UITextFieldViewModeAlways;
            textField.secureTextEntry = NO;
            textField.placeholder = NSLocalizedString(@"Image scale, 0.5 by default", nil);
            textField.keyboardType = UIKeyboardTypeDecimalPad;
        }];
        
        //Cancel action
        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [self focusTextEditor];
        }]];
        
        //Insert action
        [alertController addAction:[UIAlertAction actionWithTitle:insertButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            UITextField *textFieldAlt = [alertController.textFields objectAtIndex:0];
            UITextField *textFieldScale = [alertController.textFields objectAtIndex:1];

            self.selectedImageScale = [textFieldScale.text floatValue]?:kDefaultScale;
            self.selectedImageAlt = textFieldAlt.text?:@"";
            
            [self presentViewController:self.imagePicker animated:YES completion:nil];

        }]];
        
        [self presentViewController:alertController animated:YES completion:NULL];
        
    } else {
        
        self.alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Insert Image", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) otherButtonTitles:insertButtonTitle, nil];
        self.alertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
        self.alertView.tag = 3;
        
        UITextField *textFieldAlt = [self.alertView textFieldAtIndex:0];
        textFieldAlt.secureTextEntry = NO;
        textFieldAlt.placeholder = NSLocalizedString(@"Alt", nil);
        textFieldAlt.clearButtonMode = UITextFieldViewModeAlways;
        if (alt) {
            textFieldAlt.text = alt;
        }
        
        UITextField *textFieldScale = [self.alertView textFieldAtIndex:1];
        textFieldScale.placeholder = NSLocalizedString(@"Image scale, 0.5 by default", nil);
        textFieldScale.keyboardType = UIKeyboardTypeDecimalPad;
        
        [self.alertView show];
    }
    
}

- (void)insertImage:(NSString *)url alt:(NSString *)alt {
    NSString *trigger = [NSString stringWithFormat:@"zss_editor.insertImage(\"%@\", \"%@\");", url, alt];
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
}


- (void)updateImage:(NSString *)url alt:(NSString *)alt {
    NSString *trigger = [NSString stringWithFormat:@"zss_editor.updateImage(\"%@\", \"%@\");", url, alt];
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
}

- (void)insertImageBase64String:(NSString *)imageBase64String alt:(NSString *)alt {
    NSString *trigger = [NSString stringWithFormat:@"zss_editor.insertImageBase64String(\"%@\", \"%@\");", imageBase64String, alt];
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
}

- (void)updateImageBase64String:(NSString *)imageBase64String alt:(NSString *)alt {
    NSString *trigger = [NSString stringWithFormat:@"zss_editor.updateImageBase64String(\"%@\", \"%@\");", imageBase64String, alt];
    [self.editorView stringByEvaluatingJavaScriptFromString:trigger];
}



#pragma mark - Mention & Hashtag Support Section

- (void)checkForMentionOrHashtagInText:(NSString *)text {
    
    if ([text containsString:@" "] && [text length] > 0) {
        
        NSString *lastWord = nil;
        NSString *matchedWord = nil;
        BOOL ContainsHashtag = NO;
        BOOL ContainsMention = NO;
        
        NSRange range = [text rangeOfString:@" " options:NSBackwardsSearch];
        lastWord = [text substringFromIndex:range.location];
        
        if (lastWord != nil) {
        
            //Check if last word typed starts with a #
            NSRegularExpression *hashtagRegex = [NSRegularExpression regularExpressionWithPattern:@"#(\\w+)" options:0 error:nil];
            NSArray *hashtagMatches = [hashtagRegex matchesInString:lastWord options:0 range:NSMakeRange(0, lastWord.length)];
            
            for (NSTextCheckingResult *match in hashtagMatches) {
                
                NSRange wordRange = [match rangeAtIndex:1];
                NSString *word = [lastWord substringWithRange:wordRange];
                matchedWord = word;
                ContainsHashtag = YES;
                
            }
            
            if (!ContainsHashtag) {
                
                //Check if last word typed starts with a @
                NSRegularExpression *mentionRegex = [NSRegularExpression regularExpressionWithPattern:@"@(\\w+)" options:0 error:nil];
                NSArray *mentionMatches = [mentionRegex matchesInString:lastWord options:0 range:NSMakeRange(0, lastWord.length)];
                
                for (NSTextCheckingResult *match in mentionMatches) {
                    
                    NSRange wordRange = [match rangeAtIndex:1];
                    NSString *word = [lastWord substringWithRange:wordRange];
                    matchedWord = word;
                    ContainsMention = YES;
                    
                }
                
            }
            
        }
        
        if (ContainsHashtag) {
            
            [self hashtagRecognizedWithWord:matchedWord];
            
        }
        
        if (ContainsMention) {
            
            [self mentionRecognizedWithWord:matchedWord];
            
        }
        
    }
    
}

#pragma mark - Callbacks

//Blank implementation
- (void)editorDidScrollWithPosition:(NSInteger)position {}

//Blank implementation
- (void)editorDidChangeWithText:(NSString *)text andHTML:(NSString *)html  {}

//Blank implementation
- (void)hashtagRecognizedWithWord:(NSString *)word {}

//Blank implementation
- (void)mentionRecognizedWithWord:(NSString *)word {}


#pragma mark - AlertView

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView {
    
    if (alertView.tag == 1) {
        UITextField *textField = [alertView textFieldAtIndex:0];
        UITextField *textField2 = [alertView textFieldAtIndex:1];
        if ([textField.text length] == 0 || [textField2.text length] == 0) {
            return NO;
        }
    } else if (alertView.tag == 2) {
        UITextField *textField = [alertView textFieldAtIndex:0];
        if ([textField.text length] == 0) {
            return NO;
        }
    }
    
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (alertView.tag == 1) {
        if (buttonIndex == 1) {
            UITextField *imageURL = [alertView textFieldAtIndex:0];
            UITextField *alt = [alertView textFieldAtIndex:1];
            if (!self.selectedImageURL) {
                [self insertImage:imageURL.text alt:alt.text];
            } else {
                [self updateImage:imageURL.text alt:alt.text];
            }
        }
    } else if (alertView.tag == 2) {
        if (buttonIndex == 1) {
            UITextField *linkURL = [alertView textFieldAtIndex:0];
            UITextField *title = [alertView textFieldAtIndex:1];
            if (!self.selectedLinkURL) {
                [self insertLink:linkURL.text title:title.text];
            } else {
                [self updateLink:linkURL.text title:title.text];
            }
        }
    } else if (alertView.tag == 3) {
        if (buttonIndex == 1) {
            UITextField *textFieldAlt = [alertView textFieldAtIndex:0];
            UITextField *textFieldScale = [alertView textFieldAtIndex:1];
            
            self.selectedImageScale = [textFieldScale.text floatValue]?:kDefaultScale;
            self.selectedImageAlt = textFieldAlt.text?:@"";
            
            [self presentViewController:self.imagePicker animated:YES completion:nil];

        }
    }
}


#pragma mark - Asset Picker

- (void)showInsertURLAlternatePicker {
    // Blank method. User should implement this in their subclass
}


- (void)showInsertImageAlternatePicker {
    // Blank method. User should implement this in their subclass
}

#pragma mark - Image Picker Delegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    //Dismiss the Image Picker
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *, id> *)info{

    UIImage *selectedImage = info[UIImagePickerControllerEditedImage]?:info[UIImagePickerControllerOriginalImage];
    
    //Scale the image
    CGSize targetSize = CGSizeMake(selectedImage.size.width * self.selectedImageScale, selectedImage.size.height * self.selectedImageScale);
    UIGraphicsBeginImageContext(targetSize);
    [selectedImage drawInRect:CGRectMake(0,0,targetSize.width,targetSize.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    //Compress the image, as it is going to be encoded rather than linked
    NSData *scaledImageData = UIImageJPEGRepresentation(scaledImage, kJPEGCompression);
    
    //Encode the image data as a base64 string
    NSString *imageBase64String = [scaledImageData base64EncodedStringWithOptions:0];
    
    //Decide if we have to insert or update
    if (!self.imageBase64String) {
        [self insertImageBase64String:imageBase64String alt:self.selectedImageAlt];
    } else {
        [self updateImageBase64String:imageBase64String alt:self.selectedImageAlt];
    }
    
    self.imageBase64String = imageBase64String;

    //Dismiss the Image Picker
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - Utilities

- (NSString *)removeQuotesFromHTML:(NSString *)html {
    html = [html stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    html = [html stringByReplacingOccurrencesOfString:@"“" withString:@"&quot;"];
    html = [html stringByReplacingOccurrencesOfString:@"”" withString:@"&quot;"];
    html = [html stringByReplacingOccurrencesOfString:@"\r"  withString:@"\\r"];
    html = [html stringByReplacingOccurrencesOfString:@"\n"  withString:@"\\n"];
//    html = [html stringByReplacingOccurrencesOfString:@"<div>&nbsp;</div>"  withString:@""]; // rain
//    html = [html stringByReplacingOccurrencesOfString:@"<div>&nbsp;"  withString:@"<div>"];  // rain
    return html;
}


- (NSString *)tidyHTML:(NSString *)html {
    html = [html stringByReplacingOccurrencesOfString:@"<br>" withString:@"<br />"];
    html = [html stringByReplacingOccurrencesOfString:@"<hr>" withString:@"<hr />"];
    if (self.formatHTML) {
        html = [self.editorView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"style_html(\"%@\");", html]];
    }
    return html;
}


- (UIColor *)barButtonItemDefaultColor {
    
    if (self.toolbarItemTintColor) {
        return self.toolbarItemTintColor;
    }
    
    return [UIColor colorWithRed:0.0f/255.0f green:122.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
}


- (UIColor *)barButtonItemSelectedDefaultColor {
    
    if (self.toolbarItemSelectedTintColor) {
        return self.toolbarItemSelectedTintColor;
    }
    
    return [UIColor blackColor];
}


- (BOOL)isIpad {
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}


- (NSString *)stringByDecodingURLFormat:(NSString *)string {
    NSString *result = [string stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    result = [result stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return result;
}

- (void)enableToolbarItems:(BOOL)enable {
    NSArray *items = self.toolbar.items;
    for (ZSSBarButtonItem *item in items) {
        if (![item.label isEqualToString:@"source"]) {
            item.enabled = enable;
        }
    }
}

#pragma mark - Memory Warning Section
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
