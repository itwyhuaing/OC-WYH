//
//  ZSSRichTextEditorViewController.h
//  ZSSRichTextEditor
//
//  Created by Nicholas Hubbard on 11/30/13.
//  Copyright (c) 2013 Zed Said Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HRColorPickerViewController.h"
#import "ZSSFontsViewController.h"
#import "HNBAssetModel.h"

typedef enum : NSUInteger {
    InsertImageClickedTypeHS = 1000, // 高处选中
    InsertImageClickedTypeHC,        // 高处取消
    InsertImageClickedTypeDS,        // 低处选中
    InsertImageClickedTypeDC,         // 低处取消
    KeyBArrowClickedTypeHDown,       // 图片选择器展示出来且高处箭头向下
    InsertImageClickedTypeNone
} InsertImageClickedType;


/**
1. 记录进入发帖功能页面的来源，后续有需要可以拓展补充
2. 默认 PostingEntryOriginWritingNewTribeThem 
3. 编辑旧帖及在具体圈子入口处进入情况下不准许选择圈子
4. 发帖成功之后需要操作控制器堆栈
5. 草稿箱内容发布成功之后需要移除存储
6. 除了旧帖再编辑或者发布成功不需要保存其他情况均需保存数据
**/
typedef enum : NSUInteger {
    PostingEntryOriginWritingNewTribeThem = 2000, // 圈子首页 - 发新帖
    PostingEntryOriginEditingOldTribeThem,        // 编辑就贴
    PostingEntryOriginLookOverDraft,              // 草稿
    PostingEntryOriginTribeDetailNewThem,         // 具体圈子首页 - 发新帖
    PostingEntryOriginJoinTopicDiscuss,           // 参与话题讨论
} PostingEntryOrigin;

/**
 *  The types of toolbar items that can be added
 */
static NSString * const ZSSRichTextEditorToolbarBold = @"com.zedsaid.toolbaritem.bold";
static NSString * const ZSSRichTextEditorToolbarItalic = @"com.zedsaid.toolbaritem.italic";
static NSString * const ZSSRichTextEditorToolbarSubscript = @"com.zedsaid.toolbaritem.subscript";
static NSString * const ZSSRichTextEditorToolbarSuperscript = @"com.zedsaid.toolbaritem.superscript";
static NSString * const ZSSRichTextEditorToolbarStrikeThrough = @"com.zedsaid.toolbaritem.strikeThrough";
static NSString * const ZSSRichTextEditorToolbarUnderline = @"com.zedsaid.toolbaritem.underline";
static NSString * const ZSSRichTextEditorToolbarRemoveFormat = @"com.zedsaid.toolbaritem.removeFormat";
static NSString * const ZSSRichTextEditorToolbarJustifyLeft = @"com.zedsaid.toolbaritem.justifyLeft";
static NSString * const ZSSRichTextEditorToolbarJustifyCenter = @"com.zedsaid.toolbaritem.justifyCenter";
static NSString * const ZSSRichTextEditorToolbarJustifyRight = @"com.zedsaid.toolbaritem.justifyRight";
static NSString * const ZSSRichTextEditorToolbarJustifyFull = @"com.zedsaid.toolbaritem.justifyFull";
static NSString * const ZSSRichTextEditorToolbarH1 = @"com.zedsaid.toolbaritem.h1";
static NSString * const ZSSRichTextEditorToolbarH2 = @"com.zedsaid.toolbaritem.h2";
static NSString * const ZSSRichTextEditorToolbarH3 = @"com.zedsaid.toolbaritem.h3";
static NSString * const ZSSRichTextEditorToolbarH4 = @"com.zedsaid.toolbaritem.h4";
static NSString * const ZSSRichTextEditorToolbarH5 = @"com.zedsaid.toolbaritem.h5";
static NSString * const ZSSRichTextEditorToolbarH6 = @"com.zedsaid.toolbaritem.h6";
static NSString * const ZSSRichTextEditorToolbarTextColor = @"com.zedsaid.toolbaritem.textColor";
static NSString * const ZSSRichTextEditorToolbarBackgroundColor = @"com.zedsaid.toolbaritem.backgroundColor";
static NSString * const ZSSRichTextEditorToolbarUnorderedList = @"com.zedsaid.toolbaritem.unorderedList";
static NSString * const ZSSRichTextEditorToolbarOrderedList = @"com.zedsaid.toolbaritem.orderedList";
static NSString * const ZSSRichTextEditorToolbarHorizontalRule = @"com.zedsaid.toolbaritem.horizontalRule";
static NSString * const ZSSRichTextEditorToolbarIndent = @"com.zedsaid.toolbaritem.indent";
static NSString * const ZSSRichTextEditorToolbarOutdent = @"com.zedsaid.toolbaritem.outdent";
static NSString * const ZSSRichTextEditorToolbarInsertImage = @"com.zedsaid.toolbaritem.insertImage";
static NSString * const ZSSRichTextEditorToolbarInsertImageFromDevice = @"com.zedsaid.toolbaritem.insertImageFromDevice";
static NSString * const ZSSRichTextEditorToolbarInsertLink = @"com.zedsaid.toolbaritem.insertLink";
static NSString * const ZSSRichTextEditorToolbarRemoveLink = @"com.zedsaid.toolbaritem.removeLink";
static NSString * const ZSSRichTextEditorToolbarQuickLink = @"com.zedsaid.toolbaritem.quickLink";
static NSString * const ZSSRichTextEditorToolbarUndo = @"com.zedsaid.toolbaritem.undo";
static NSString * const ZSSRichTextEditorToolbarRedo = @"com.zedsaid.toolbaritem.redo";
static NSString * const ZSSRichTextEditorToolbarViewSource = @"com.zedsaid.toolbaritem.viewSource";
static NSString * const ZSSRichTextEditorToolbarParagraph = @"com.zedsaid.toolbaritem.paragraph";
static NSString * const ZSSRichTextEditorToolbarAll = @"com.zedsaid.toolbaritem.all";
static NSString * const ZSSRichTextEditorToolbarNone = @"com.zedsaid.toolbaritem.none";
static NSString * const ZSSRichTextEditorToolbarFonts = @"com.zedsaid.toolbaritem.fonts";

@class ZSSBarButtonItem;

/**
 *  The viewController used with ZSSRichTextEditor
 */
@interface ZSSRichTextEditor : UIViewController <UIWebViewDelegate, HRColorPickerViewControllerDelegate, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate,ZSSFontsViewControllerDelegate>


/**
 *  The base URL to use for the webView
 */
@property (nonatomic, strong) NSURL *baseURL;

/**
 *  If the HTML should be formatted to be pretty
 */
@property (nonatomic) BOOL formatHTML;

/**
 *  If the keyboard should be shown when the editor loads
 */
@property (nonatomic) BOOL shouldShowKeyboard;

/**
 * If the toolbar should always be shown or not
 */
@property (nonatomic) BOOL alwaysShowToolbar;

/**
 * If the sub class recieves text did change events or not
 */
@property (nonatomic) BOOL receiveEditorDidChangeEvents;

/**
 *  The placeholder text to use if there is no editor content
 */
@property (nonatomic, strong) NSString *placeholder;

/**
 *  Toolbar items to include
 */
@property (nonatomic, strong) NSArray *enabledToolbarItems;

/**
 *  Color to tint the toolbar items
 */
@property (nonatomic, strong) UIColor *toolbarItemTintColor;

/**
 *  Color to tint selected items
 */
@property (nonatomic, strong) UIColor *toolbarItemSelectedTintColor;

/**
 *  Sets the HTML for the entire editor
 *
 *  @param html  HTML string to set for the editor
 *
 */
- (void)setHTML:(NSString *)html title:(NSString *)title;

/**
 *  Returns the HTML from the Rich Text Editor
 *
 */
- (NSString *)getHTML;

/**
 *  Returns the plain text from the Rich Text Editor
 *
 */
- (NSString *)getText;

/**
 *  Inserts HTML at the caret position
 *
 *  @param html  HTML string to insert
 *
 */
- (void)insertHTML:(NSString *)html;

/**
 *  Manually focuses on the text editor
 */
- (void)focusTextEditor;

/**
 *  Manually dismisses on the text editor
 */
- (void)blurTextEditor;

/**
 *  Shows the insert image dialog with optinal inputs
 *
 *  @param url The URL for the image
 *  @param alt The alt for the image
 */
- (void)showInsertImageDialogWithLink:(NSString *)url alt:(NSString *)alt;

/**
 *  Inserts an image
 *
 *  @param url The URL for the image
 *  @param alt The alt attribute for the image
 */
- (void)insertImage:(NSString *)url alt:(NSString *)alt;

/**
 *  Shows the insert link dialog with optional inputs
 *
 *  @param url   The URL for the link
 *  @param title The tile for the link
 */
- (void)showInsertLinkDialogWithLink:(NSString *)url title:(NSString *)title;

/**
 *  Inserts a link
 *
 *  @param url The URL for the link
 *  @param title The title for the link
 */
- (void)insertLink:(NSString *)url title:(NSString *)title;

/**
 *  Gets called when the insert URL picker button is tapped in an alertView
 *
 *  @warning The default implementation of this method is blank and does nothing
 */
- (void)showInsertURLAlternatePicker;

/**
 *  Gets called when the insert Image picker button is tapped in an alertView
 *
 *  @warning The default implementation of this method is blank and does nothing
 */
- (void)showInsertImageAlternatePicker;

/**
 *  Dismisses the current AlertView
 */
- (void)dismissAlertView;

/**
 *  Add a custom UIBarButtonItem by using a UIButton
 */
- (void)addCustomToolbarItemWithButton:(UIButton*)button;

/**
 *  Add a custom ZSSBarButtonItem
 */
- (void)addCustomToolbarItem:(ZSSBarButtonItem *)item;

/**
 *  Scroll event callback with position
 */
- (void)editorDidScrollWithPosition:(NSInteger)position;

/**
 *  Text change callback with text and html
 */
- (void)editorDidChangeWithText:(NSString *)text andHTML:(NSString *)html;

/**
 *  Hashtag callback with word
 */
- (void)hashtagRecognizedWithWord:(NSString *)word;

/**
 *  Mention callback with word
 */
- (void)mentionRecognizedWithWord:(NSString *)word;

/**
 *  Set custom css
 */
- (void)setCSS:(NSString *)css;


/** =================hnb - rain=================== */

/**
 * 用户 ID
 */
@property (nonatomic,copy) NSString *userID;

/**
 * 帖子编码
 */
@property (nonatomic,copy) NSString *tribeThemCode;

/**
 * 圈子编码
 */
@property (nonatomic,copy) NSString *choseTribeCode;

/**
 * 圈子名称
 */
@property (nonatomic,copy) NSString *chosedTribeName;

/**
 * 话题ID , V3.0 首页增加热门话题列表中有参与讨论板块所需参数
 */
@property (nonatomic,copy) NSString *topicID;

/**
 * 记录 push 发帖功能控制器的来源，默认 PostingEntryOriginNewTribeThem 
 */
@property (nonatomic,assign) PostingEntryOrigin entryOrigin;


/**
 * 传图失败的数据模型 TZAssetModel
 */
@property (nonatomic,strong) NSMutableArray *failureModels;

/**
 * 被选中的图片数据模型总数
 */
@property (nonatomic,assign) NSInteger selectedTotal;

/**
 * 已成功上传的图片数据模型总数
 */
@property (nonatomic,assign) NSInteger sucUpLoadCount;

/**
 * 尚未成功上传的图片数据模型总数
 */
@property (nonatomic,assign) NSInteger failureUpLoadCount;

/**
 * 每篇帖子准许包含的图片个数
 */
@property (nonatomic,assign) NSInteger maxImagesCount;

/**
 * 获取标题
 */
- (NSString *)getHTMLTitle;

/**
 * 草稿进入之后需要提取保存的已经未成功上传的图片数据模型
 */

- (void)queryAndExtractFailureModels;

/**
 * 判断当前DOM树种是否存在图片正在上传的灰色蒙版
 */
- (BOOL)queryImageUploadingTagForCurrentDOM;

/**
 * 判断当前DOM树种是否存在图片的灰色蒙版
 */
- (BOOL)queryImageMaskTagForCurrentDOM;

/**
 * 获取发送给服务器的编辑区内容
 */
- (NSString *)tidyEditorContentForServer;

/**
 * 对 DOM 不做任何操作，直接获取 DOM 树
 */
- (NSString *)getOriginalDOM;

/**
 * 获取 剔出已隐藏标签节点的 DOM 树
 */
- (NSString *)getTidyedDOMAfterDelateHiddedHTML;

/**
 * 发布按钮
 */
- (void)postSubmit;

/**
 * 点击标题区域
 */
- (void)touchTitleSection;

/**
 * 是否准允 title 的可编辑状态
 */
- (void)titleContentEditable:(NSString *)able;

@end
