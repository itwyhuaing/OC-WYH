
*  Native 调用 JS ， 类似下面的错误 “ Can't find variable ” , 原因在于自己的 JS 方法没找到 。为避免需要：1. 正确引用 JS 文件  2. 正确定义 JS 方法 。

> error:Error Domain=WKErrorDomain Code=4 "A JavaScript exception occurred" UserInfo={WKJavaScriptExceptionMessage=ReferenceError: Can't find variable: zss_editor, WKJavaScriptExceptionLineNumber=1, WKJavaScriptExceptionColumnNumber=11, NSLocalizedDescription=A JavaScript exception occurred, WKJavaScriptExceptionSourceURL=about:blank}


* Web 页嵌入移动端之后的，尺寸适配移动端的两种方式：

  1. HTML 设置方式

```
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
```

  2. WKWebView 设置方式
```
  WKPreferences *preferences = [WKPreferences new];

  preferences.javaScriptCanOpenWindowsAutomatically = YES;

  preferences.minimumFontSize = 40.0;

  configuration.preferences = preferences;
```

* iOS 下 元素的 focus() 无法唤起键盘

 1. UIWebView - keyboardDisplayRequiresUserAction 属性设置
```
默认为 true ，这种情况下需要用户主动去点击元素，这样才能唤起键盘，通过focus去模拟的话是不行的。如果API设为false.这个时候是可以通过focus去模拟，并唤起键盘的。
```
 2. WKWebView 设置

 [可参考1](https://stackoverflow.com/questions/32407185/wkwebview-cant-open-keyboard-for-input-field)
 [可参考2](http://www.jianshu.com/p/c7bd2af5005b)
