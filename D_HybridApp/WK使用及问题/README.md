#### WK使用及问题。

* WKWebView 与 UIWebView

> 移动端加载 web 页的新组件 WKWebView 随着 iOS8  的更新也被添加到开发行列中。
> 相比于 UIWebView 组件，WKWebView 在加载速度及性能方面都有很大改善。
> UIWebView 与 UIWebDelegate 所实现的功能，在 WKWebKit 中被重构成 16个 类、3个协议。

* WKWebView 基本使用

  >  相比于 UIWebView ，WKWebView 只可以用代码创建；而且新增了右滑返回手势能力(allowsBackForwardNavigationGestures)、加载进度条能力（estimatedProgress）、以及可以使内嵌视频正常播放的配置属性（allowsInlineMediaPlayback，该值默认为NO）。

##### 类

* WKBackForwardList
> 历史记录列表
> 属性与方法
```
@property (nullable, nonatomic, readonly, strong) WKBackForwardListItem *currentItem;
@property (nullable, nonatomic, readonly, strong) WKBackForwardListItem *backItem;
@property (nullable, nonatomic, readonly, strong) WKBackForwardListItem *forwardItem;
- (nullable WKBackForwardListItem *)itemAtIndex:(NSInteger)index;
@property (nonatomic, readonly, copy) NSArray<WKBackForwardListItem *> *backList;
@property (nonatomic, readonly, copy) NSArray<WKBackForwardListItem *> *forwardList;
```

* WKBackForwardListItem
> webView 中后退列表里的某一网页


* WKFrameInfo
> 包含一个框架在一个网页的信息
> 有 mainFrame、request、securityOrigin 三个属性，其中 securityOrigin 是一个WKSecurityOrigin对象属性，iOS9之后可使用，是由一个主机名称，协议和端口号组成。

* WKNavigation
> 包含一个网页加载进度信息

* WKNavigationAction
> 包含可能让网页导航变化的信息，用于判断是否做出导航变化
> 注意该类下 WKNavigationType 这个枚举

* WKNavigationResponse
> 包含可能让网页导航变化的返回内容信息，用于判断是否做出导航变化

* WKPreferences
> 一个 webView 的偏好设置
> 有 minimumFontSize、 javaScriptEnabled、 javaScriptCanOpenWindowsAutomatically 三个属性，值得注意的是后两个属性，一个决定是否启用javaScript,另一个是在没有用户交互的情况下，是否JavaScript可以打开windows

* WKProcessPool
> 表示一个web内容加载池

* WKUserContentController
> 主要处理与 js 的信息交互

```
// 注入 js
- (void)addUserScript:(WKUserScript *)userScript;

// 搭建 js 调用 oc 的桥梁
- (void)addScriptMessageHandler:(id <WKScriptMessageHandler>)scriptMessageHandler name:(NSString *)name;

```

* WKScriptMessage
> 包含网页发出的信息

* WKUserScript
> 表示可以被网页接受的用户脚本

* WKWebViewConfiguration
> 初始化 webview 的设置

* WKWindowFeatures
> 指定加载新网页时的窗口属性

* WKWebViewConfiguration
> 对象是属性的集合用来初始化一个web视图
> 属性比较多，不过这个对象在初始化 web 视图的时候必须会用到

* WKWebsiteDataStore
> WKWebsiteDataStore代表网站可能使用的各种类型的数据。这包括cookie、磁盘和内存缓存，以及持久数据，如WebSQL、IndexedDB数据库和本地存储。

* WKWebsiteDataRecord
> 记录使用公共后缀列表来分组的网站数据。

##### 协议

* WKNavigationDelegate

```
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler;
```


```
// 在收到响应后，决定是否跳转，该方法与 decidePolicyForNavigationAction（发送请求之前是否允许跳转） 配套使用
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler;
```



```
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation;
```


```
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation;
```



```
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation;
```



```
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation;
```



```
/**
@abstract Invoked when an error occurs while starting to load data for the main frame.
> 当开始为主框架加载数据是发生错误时调用  --- 自己翻译
*/
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error;
```


```
/**
  @abstract Invoked when an error occurs during a committed main frame navigation.
  > 在渲染数据到主框架上时发生错误时调用  --- 自己翻译
*/
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error;
```


```
// 身份验证
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler;
```


```
// WKWebView 加载操作终止时调用
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView API_AVAILABLE(macosx(10.11), ios(9.0));
```




* WKUIDelegate

```
// 创建一个新的WebView
- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures;
```



```
- (void)webViewDidClose:(WKWebView *)webView API_AVAILABLE(macosx(10.11), ios(9.0));
```

```
/**
*  @param webView           实现该代理的webview
*  @param message           警告框中的内容
*  @param frame             主窗口
*  @param completionHandler 警告框消失调用

> web界面中有弹出警告框时调用
*/
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler;
```


```
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler;
```

```
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable result))completionHandler;
```

```
- (BOOL)webView:(WKWebView *)webView shouldPreviewElement:(WKPreviewElementInfo *)elementInfo API_AVAILABLE(ios(10.0));
```

```
- (nullable UIViewController *)webView:(WKWebView *)webView previewingViewControllerForElement:(WKPreviewElementInfo *)elementInfo defaultActions:(NSArray<id <WKPreviewActionItem>> *)previewActions API_AVAILABLE(ios(10.0));
```


```
- (void)webView:(WKWebView *)webView commitPreviewingViewController:(UIViewController *)previewingViewController API_AVAILABLE(ios(10.0));
```


* WKScriptMessageHandler

```
// 该方法是 WKScriptMessageHandler 协议中必须实现的方法，提高App与web端交互的关键，它可以直接将接收到的JS脚本转为OC或Swift对象。
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message;
```


##### 其他

* WKHTTPCookieStore

* WKWebsiteDataStore

```
iOS9 以后才能用这个类，是代表 webView 不同的数据类型，cookies、disk、memory caches、WebSQL、IndexedDB数据库和本地存储。

// 三行代码执行之后，客户端的所有 web 缓存会被清除，打开 web 的所需资源会前往服务器获取最新资源，而不是读取本地的或网络节点的缓存。
NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
[[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
    //删除后执行操
}];

```

* WKWebsiteDataRecord

```
暂未发现有什么重要的应用。
```

* 几个结构体

```
// navigationAction.navigationType

typedef NS_ENUM(NSInteger, WKNavigationType) {
   WKNavigationTypeLinkActivated, // 链接被用户激活(exmple: 点击 web 页某处上发生的跳转)
   WKNavigationTypeFormSubmitted, // 表单提交 (exmple: 测试结果提交)
   WKNavigationTypeBackForward,   // web 加载堆栈中发生回退 (exmple: goBack)
   WKNavigationTypeReload,        // web 重新加载 (exmple: reload)
   WKNavigationTypeFormResubmitted, // 暂未遇到 - 据说：一个表单提交(exmple: 通过前进,后退,或重新加载)。
   WKNavigationTypeOther = -1,    // 导航发生一些原因 (exmple: 原生页面跳转至 web 页)
} API_AVAILABLE(macosx(10.10), ios(8.0));


// 发起请求钱是否导航(继续本次加载请求)

typedef NS_ENUM(NSInteger, WKNavigationActionPolicy) {
    WKNavigationActionPolicyCancel,
    WKNavigationActionPolicyAllow,
} API_AVAILABLE(macosx(10.10), ios(8.0));


// 接收响应后是否导航(继续本次加载请求)

typedef NS_ENUM(NSInteger, WKNavigationResponsePolicy) {
    WKNavigationResponsePolicyCancel,
    WKNavigationResponsePolicyAllow,
} API_AVAILABLE(macosx(10.10), ios(8.0));

```

##### 使用中常见问题

* 缓存

* 刷新机制 - 圈子详情中主贴显示


##### 参考

> swift 版本应用

* [WKWeb​View - Swift 版本](http://nshipster.cn/wkwebkit/)
* [Java​Script​Core - Swift 版本](http://nshipster.cn/javascriptcore/)


> WKWeb 缓存

* [WKWebView简单使用及关于缓存的问题](http://www.cnblogs.com/allencelee/p/6709599.html)
* [iOS9 WKWebView 缓存清除API](http://www.jianshu.com/p/186a3b236bc9)
* [NSURLRequestCachePolicy—iOS缓存策略](https://blog.csdn.net/pjk1129/article/details/50674835)
* [iOS11.3 WKWebView清除cookie](https://blog.csdn.net/u012413955/article/details/79783282) iOS 11 已将 web 所有的缓存数据类型清除功能暴露给原生。

> web 与 native 交互

* [iOS 下 JS 与原生 native 互相调用 --- 系列文章](http://www.jianshu.com/p/d19689e0ed83)


> WKWebView 嵌入 cell 加载 web ,动态修正高度

* [WKWebView 刷新机制小探](https://www.jianshu.com/p/1d739e2e7ed2)


> web 富文本编辑器

* [HTML meta viewport属性说明 --- H5页面适配到移动端窗口](http://www.cnblogs.com/pigtail/archive/2013/03/15/2961631.html)
* [iOS下Html页面中input获取焦点弹出键盘时挡住input解决方案—scrollIntoView()](http://www.cnblogs.com/wx1993/p/6059668.html)

* 项目中遇到的很多问题多半是因为见得太少，思考的太少。总结过程中，无意间发现早有大牛对该部分内容作了详细总结；贴上地址，方便今后查找。


> web 加载过程中证书受信问题

* [iOS开发---WKWebView加载不受信任的https](https://www.jianshu.com/p/7648f10613fa)
