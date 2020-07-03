* 直接搜索 UIWebView ， 涉及 富文本编辑、AFNetworking、Meiqia、WebViewJavascriptBridge


* 终端查看涉及 UIWebView 全部代码 

```

cd 目标目录

grep -r -F UIWebView .

```

遇到如下报错，可 [参考文章](https://stackoom.com/question/37Y97/)

```

grep: warning: recursive search of stdin

```



```

Binary file ./hinabian/Code/Libs/AlipaySDK/AlipaySDK.framework/AlipaySDK matches
./hinabian/Code/Libs/ZSSRichTextEditor/NativeBridge/ZSSRichTextEditor.h:@interface ZSSRichTextEditor : UIViewController <UIWebViewDelegate, HRColorPickerViewControllerDelegate, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate,ZSSFontsViewControllerDelegate>
./hinabian/Code/Libs/ZSSRichTextEditor/NativeBridge/ZSSRichTextEditor.m: UIWebView modifications for hiding the inputAccessoryView
./hinabian/Code/Libs/ZSSRichTextEditor/NativeBridge/ZSSRichTextEditor.m:@interface UIWebView (HackishAccessoryHiding)
./hinabian/Code/Libs/ZSSRichTextEditor/NativeBridge/ZSSRichTextEditor.m:@implementation UIWebView (HackishAccessoryHiding)
./hinabian/Code/Libs/ZSSRichTextEditor/NativeBridge/ZSSRichTextEditor.m: *  UIWebView for writing/editing/displaying the content
./hinabian/Code/Libs/ZSSRichTextEditor/NativeBridge/ZSSRichTextEditor.m:@property (nonatomic, strong) UIWebView *editorView;
./hinabian/Code/Libs/ZSSRichTextEditor/NativeBridge/ZSSRichTextEditor.m:    self.editorView = [[UIWebView alloc] initWithFrame:frame];
./hinabian/Code/Libs/ZSSRichTextEditor/NativeBridge/ZSSRichTextEditor.m:#pragma mark - UIWebView Delegate
./hinabian/Code/Libs/ZSSRichTextEditor/NativeBridge/ZSSRichTextEditor.m:- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
./hinabian/Code/Libs/ZSSRichTextEditor/NativeBridge/ZSSRichTextEditor.m:    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
./hinabian/Code/Libs/ZSSRichTextEditor/NativeBridge/ZSSRichTextEditor.m:- (void)webViewDidFinishLoad:(UIWebView *)webView {
Binary file ./hinabian.xcworkspace/xcuserdata/yujian.xcuserdatad/UserInterfaceState.xcuserstate matches
Binary file ./hinabian.xcworkspace/xcuserdata/XIAOZE.xcuserdatad/UserInterfaceState.xcuserstate matches
Binary file ./hinabian.xcworkspace/xcuserdata/hnbwyh.xcuserdatad/UserInterfaceState.xcuserstate matches
./Pods/Pods.xcodeproj/project.pbxproj:		337C8A9592224E2629F71F4759AE0DF2 /* UIWebView+AFNetworking.h in Headers */ = {isa = PBXBuildFile; fileRef = 95AB95C9DBF28D9E5E89F90B6E7E5D27 /* UIWebView+AFNetworking.h */; settings = {ATTRIBUTES = (Project, ); }; };
./Pods/Pods.xcodeproj/project.pbxproj:		6326910744CB757A56F0D16A8892445E /* UIWebView+AFNetworking.m in Sources */ = {isa = PBXBuildFile; fileRef = 6CFDFDB5785E734FAC929D72B7EE6378 /* UIWebView+AFNetworking.m */; settings = {COMPILER_FLAGS = "-w -Xanalyzer -analyzer-disable-all-checks"; }; };
./Pods/Pods.xcodeproj/project.pbxproj:		6CFDFDB5785E734FAC929D72B7EE6378 /* UIWebView+AFNetworking.m */ = {isa = PBXFileReference; includeInIndex = 1; lastKnownFileType = sourcecode.c.objc; name = "UIWebView+AFNetworking.m"; path = "UIKit+AFNetworking/UIWebView+AFNetworking.m"; sourceTree = "<group>"; };
./Pods/Pods.xcodeproj/project.pbxproj:		95AB95C9DBF28D9E5E89F90B6E7E5D27 /* UIWebView+AFNetworking.h */ = {isa = PBXFileReference; includeInIndex = 1; lastKnownFileType = sourcecode.c.h; name = "UIWebView+AFNetworking.h"; path = "UIKit+AFNetworking/UIWebView+AFNetworking.h"; sourceTree = "<group>"; };
./Pods/Pods.xcodeproj/project.pbxproj:				95AB95C9DBF28D9E5E89F90B6E7E5D27 /* UIWebView+AFNetworking.h */,
./Pods/Pods.xcodeproj/project.pbxproj:				6CFDFDB5785E734FAC929D72B7EE6378 /* UIWebView+AFNetworking.m */,
./Pods/Pods.xcodeproj/project.pbxproj:				337C8A9592224E2629F71F4759AE0DF2 /* UIWebView+AFNetworking.h in Headers */,
./Pods/Pods.xcodeproj/project.pbxproj:				6326910744CB757A56F0D16A8892445E /* UIWebView+AFNetworking.m in Sources */,
./Pods/Meiqia/Meiqia-SDK-files/MQChatViewController/Vendors/TTTAttributedLabel/MEIQIA_TTTAttributedLabel.h: to emulate the link detection behaviour of UIWebView. 
./Pods/Meiqia/Meiqia-SDK-files/MQChatViewController/Views/MQWebView/MQWebViewController.m:@interface MQWebViewController()<UIWebViewDelegate>
./Pods/Meiqia/Meiqia-SDK-files/MQChatViewController/Views/MQWebView/MQWebViewController.m:    self.webView = [UIWebView new];
./Pods/Meiqia/Meiqia-SDK-files/MQChatViewController/Views/MQWebView/MQWebViewController.m:- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
./Pods/Meiqia/Meiqia-SDK-files/MQChatViewController/Views/MQWebView/MQWebViewController.m:- (void)webViewDidStartLoad:(UIWebView *)webView {
./Pods/Meiqia/Meiqia-SDK-files/MQChatViewController/Views/MQWebView/MQWebViewController.m:- (void)webViewDidFinishLoad:(UIWebView *)webView {
./Pods/Meiqia/Meiqia-SDK-files/MQChatViewController/Views/MQWebView/MQWebViewController.m:- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
./Pods/Meiqia/Meiqia-SDK-files/MQChatViewController/Views/MQWebView/MQEmbededWebView.h:@interface MQEmbededWebView : UIWebView
./Pods/Meiqia/Meiqia-SDK-files/MQChatViewController/Views/MQWebView/MQWebViewController.h:@property (nonatomic, strong) UIWebView *webView;
./Pods/Meiqia/Meiqia-SDK-files/MQChatViewController/Views/MQWebView/MQEmbededWebView.m:@interface MQEmbededWebView()<UIWebViewDelegate>
./Pods/Meiqia/Meiqia-SDK-files/MQChatViewController/Views/MQWebView/MQEmbededWebView.m:- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
./Pods/Meiqia/Meiqia-SDK-files/MQChatViewController/Views/MQWebView/MQEmbededWebView.m:- (void)webViewDidStartLoad:(UIWebView *)webView {
./Pods/Meiqia/Meiqia-SDK-files/MQChatViewController/Views/MQWebView/MQEmbededWebView.m:- (void)webViewDidFinishLoad:(UIWebView *)webView {
./Pods/Meiqia/Meiqia-SDK-files/MQChatViewController/Views/MQWebView/MQEmbededWebView.m:- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
./Pods/WebViewJavascriptBridge/WebViewJavascriptBridge/WebViewJavascriptBridge.m:- (void)webViewDidFinishLoad:(UIWebView *)webView {
./Pods/WebViewJavascriptBridge/WebViewJavascriptBridge/WebViewJavascriptBridge.m:- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
./Pods/WebViewJavascriptBridge/WebViewJavascriptBridge/WebViewJavascriptBridge.m:- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
./Pods/WebViewJavascriptBridge/WebViewJavascriptBridge/WebViewJavascriptBridge.m:- (void)webViewDidStartLoad:(UIWebView *)webView {
./Pods/WebViewJavascriptBridge/WebViewJavascriptBridge/WebViewJavascriptBridge.h:    #import <UIKit/UIWebView.h>
./Pods/WebViewJavascriptBridge/WebViewJavascriptBridge/WebViewJavascriptBridge.h:    #define WVJB_WEBVIEW_TYPE UIWebView
./Pods/WebViewJavascriptBridge/WebViewJavascriptBridge/WebViewJavascriptBridge.h:    #define WVJB_WEBVIEW_DELEGATE_TYPE NSObject<UIWebViewDelegate>
./Pods/WebViewJavascriptBridge/WebViewJavascriptBridge/WebViewJavascriptBridge.h:    #define WVJB_WEBVIEW_DELEGATE_INTERFACE NSObject<UIWebViewDelegate, WebViewJavascriptBridgeBaseDelegate>
./Pods/WebViewJavascriptBridge/README.md:An iOS/OSX bridge for sending messages between Obj-C and JavaScript in WKWebViews, UIWebViews & WebViews.
./Pods/WebViewJavascriptBridge/README.md:2) Instantiate WebViewJavascriptBridge with a WKWebView, UIWebView (iOS) or WebView (OSX):
./Pods/WebViewJavascriptBridge/README.md:##### `[WebViewJavascriptBridge bridgeForWebView:(WKWebVIew/UIWebView/WebView*)webview`
./Pods/WebViewJavascriptBridge/README.md:	NSLog(@"Current UIWebView page URL is: %@", responseData);
./Pods/WebViewJavascriptBridge/README.md:Optionally, set a `WKNavigationDelegate/UIWebViewDelegate` if you need to respond to the [web view's lifecycle events](https://developer.apple.com/reference/uikit/uiwebviewdelegate).
./Pods/MJRefresh/README.md:    * [UIWebView01-The drop-down refresh](#UIWebView01-The_drop-down_refresh)
./Pods/MJRefresh/README.md:* `UIScrollView`、`UITableView`、`UICollectionView`、`UIWebView`
./Pods/MJRefresh/README.md:## <a id="UIWebView01-The_drop-down_refresh"></a>UIWebView01-The drop-down refresh
./Pods/Headers/Public/Meiqia/MQEmbededWebView.h:@interface MQEmbededWebView : UIWebView
./Pods/Headers/Public/Meiqia/MQWebViewController.h:@property (nonatomic, strong) UIWebView *webView;
./Pods/Headers/Public/Meiqia/MEIQIA_TTTAttributedLabel.h: to emulate the link detection behaviour of UIWebView. 
./Pods/Headers/Public/WebViewJavascriptBridge/WebViewJavascriptBridge.h:    #import <UIKit/UIWebView.h>
./Pods/Headers/Public/WebViewJavascriptBridge/WebViewJavascriptBridge.h:    #define WVJB_WEBVIEW_TYPE UIWebView
./Pods/Headers/Public/WebViewJavascriptBridge/WebViewJavascriptBridge.h:    #define WVJB_WEBVIEW_DELEGATE_TYPE NSObject<UIWebViewDelegate>
./Pods/Headers/Public/WebViewJavascriptBridge/WebViewJavascriptBridge.h:    #define WVJB_WEBVIEW_DELEGATE_INTERFACE NSObject<UIWebViewDelegate, WebViewJavascriptBridgeBaseDelegate>
./Pods/Headers/Public/AFNetworking/UIWebView+AFNetworking.h:// UIWebView+AFNetworking.h
./Pods/Headers/Public/AFNetworking/UIWebView+AFNetworking.h: This category adds methods to the UIKit framework's `UIWebView` class. The methods in this category provide increased control over the request cycle, including progress monitoring and success / failure handling.
./Pods/Headers/Public/AFNetworking/UIWebView+AFNetworking.h:@interface UIWebView (AFNetworking)
./Pods/Headers/Public/AFNetworking/UIKit+AFNetworking.h:    #import "UIWebView+AFNetworking.h"
./Pods/Headers/Private/Meiqia/MQEmbededWebView.h:@interface MQEmbededWebView : UIWebView
./Pods/Headers/Private/Meiqia/MQWebViewController.h:@property (nonatomic, strong) UIWebView *webView;
./Pods/Headers/Private/Meiqia/MEIQIA_TTTAttributedLabel.h: to emulate the link detection behaviour of UIWebView. 
./Pods/Headers/Private/WebViewJavascriptBridge/WebViewJavascriptBridge.h:    #import <UIKit/UIWebView.h>
./Pods/Headers/Private/WebViewJavascriptBridge/WebViewJavascriptBridge.h:    #define WVJB_WEBVIEW_TYPE UIWebView
./Pods/Headers/Private/WebViewJavascriptBridge/WebViewJavascriptBridge.h:    #define WVJB_WEBVIEW_DELEGATE_TYPE NSObject<UIWebViewDelegate>
./Pods/Headers/Private/WebViewJavascriptBridge/WebViewJavascriptBridge.h:    #define WVJB_WEBVIEW_DELEGATE_INTERFACE NSObject<UIWebViewDelegate, WebViewJavascriptBridgeBaseDelegate>
./Pods/Headers/Private/AFNetworking/UIWebView+AFNetworking.h:// UIWebView+AFNetworking.h
./Pods/Headers/Private/AFNetworking/UIWebView+AFNetworking.h: This category adds methods to the UIKit framework's `UIWebView` class. The methods in this category provide increased control over the request cycle, including progress monitoring and success / failure handling.
./Pods/Headers/Private/AFNetworking/UIWebView+AFNetworking.h:@interface UIWebView (AFNetworking)
./Pods/Headers/Private/AFNetworking/UIKit+AFNetworking.h:    #import "UIWebView+AFNetworking.h"
Binary file ./Pods/UMengUShare/UShareSDK/UMSocialSDK/UMSocialCore.framework/UMSocialCore matches
Binary file ./Pods/UMengUShare/UShareSDK/SocialLibraries/WeChat/libSocialWeChat.a matches
Binary file ./Pods/UMengUShare/UShareSDK/SocialLibraries/WeChat/WechatSDK/libWeChatSDK.a matches
Binary file ./Pods/UMengUShare/UShareSDK/SocialLibraries/Sina/libSocialSina.a matches
Binary file ./Pods/UMengUShare/UShareSDK/SocialLibraries/QQ/QQSDK/TencentOpenAPI.framework/TencentOpenAPI matches
./Pods/AFNetworking/UIKit+AFNetworking/UIWebView+AFNetworking.h:// UIWebView+AFNetworking.h
./Pods/AFNetworking/UIKit+AFNetworking/UIWebView+AFNetworking.h: This category adds methods to the UIKit framework's `UIWebView` class. The methods in this category provide increased control over the request cycle, including progress monitoring and success / failure handling.
./Pods/AFNetworking/UIKit+AFNetworking/UIWebView+AFNetworking.h:@interface UIWebView (AFNetworking)
./Pods/AFNetworking/UIKit+AFNetworking/UIKit+AFNetworking.h:    #import "UIWebView+AFNetworking.h"
./Pods/AFNetworking/UIKit+AFNetworking/UIWebView+AFNetworking.m:// UIWebView+AFNetworking.m
./Pods/AFNetworking/UIKit+AFNetworking/UIWebView+AFNetworking.m:#import "UIWebView+AFNetworking.h"
./Pods/AFNetworking/UIKit+AFNetworking/UIWebView+AFNetworking.m:@interface UIWebView (_AFNetworking)
./Pods/AFNetworking/UIKit+AFNetworking/UIWebView+AFNetworking.m:@implementation UIWebView (_AFNetworking)
./Pods/AFNetworking/UIKit+AFNetworking/UIWebView+AFNetworking.m:@implementation UIWebView (AFNetworking)
Binary file ./hinabian.xcodeproj/project.xcworkspace/xcuserdata/yujian.xcuserdatad/UserInterfaceState.xcuserstate matches


```


* 项目中涉及 UIWebView 部分

```

/hinabian/Code/Libs/AlipaySDK/AlipaySDK.framework/AlipaySDK

/hinabian/Code/Libs/ZSSRichTextEditor


AFNetworking
Meiqia
WebViewJavascriptBridge
MJRefresh
UMengUShare

```
