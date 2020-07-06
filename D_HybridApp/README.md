# HybridAPP


###### JS 与 native 间的交互问题

1. JS 点击事件调用 native 方法

2. URL 加载调用 native 方法

3. native 调用 JS 方法

4. native 管控 URL 的加载情况

5. native 向 JS 中注入变量

6. native 读取 JS 中的变量

7. 如何实现原生应用中个性化 web 的加载和跳转


###### 交互方式

1. native 调起 JS 方法或注入变量比较固定，只需通过 webkit 提供的 API 传递相应的 JS 语句执行即可 。

2. JS 调用 native ：

  > 1. 拦截并解析 URL 。 适用于 UIWebView 与 WKwebView ;但参数与 URL 解析比较繁琐且易出错。
  > 2. JavaScriptCore - JSContext 。ios7 时推出的 框架，但 iOS8 时推出的 WKwebView 控件完全可以以更加简便方式实现 。
  > 3. MessageHandler 。适用于 WKwebView ；代码繁琐。
  > 4. WebViewJavascriptBridge 。适用于 WKwebView 与 UIWebView ，推荐使用 。


3. native 调用 JS :

  > 1. evaluateJavaScript 。适用于  WKwebView 。
  > 2. stringByEvaluatingJavaScriptFromString 。适用于 UIWebView 。
  > 3. JavaScriptCore - JSContext 。适用于 WKwebView 与 UIWebView 。
  > 4. WebViewJavascriptBridge 。适用于 WKwebView 与 UIWebView 。


###### 公司项目优化笔记 - 移动端 H5(Web页) 的展示

1. 依据项目需求自定义一个基于 WKWebView 的子类，做到低耦合，以便项目使用

2. 关于混合式开发需要考虑如下几个问题

  > 2.0 某一个 Web 页前后可能是原生也可能是 Web 页

  > 2.1 加载某一个 Web 页的URL（一般结构：协议头 | 域名 | 端口 | 文件路径 | 参数）多样

  > 2.2 加载 Web 页过程中 URL 重定向

  > 2.3 加载 Web 页过程中有表单提交（Web 页表单提交操作）

  > 2.4 即便是 Web 页，也涉及原生元素(example:导航栏样式)的显示问题

  > 2.5 Web 页面回退(URL加载堆栈推出栈顶元素) - goBack 过程中，Web 页面会重新加载

3. 基于第一、二点可以将混合式开发拆分为两个关键问题：Web 加载组件的解耦封装、 跳转问题。第一个关键问题没有太多笔记记录，直接看 Demo 。第二个关键问题需要前后端约定跳转规则。

就项目而言，经过三个版本迭代，已实现移动端可加载任意 URL 的跳转，并且加载样式完全由后台控制 --- 这样做的好处在于，即便在线上出现问题，后台也可以及时修改，不需要重新发包。

4. 第一版：在项目需要跳转的地方后台拼接以  ios:jumpxxx:https://xxx 样式的 URL ，移动端拦截跳转到对应类型的控制器，展示对应的页面。

   第二版：移动端拦截当前 URL ，并提取关键词跳转到对应处理模块，展示对应的页面。

   第三版：加载 Web 的类只有一个，该类实例化的对象具备

    > 1. 解析 URL 参数的能力
    > 2. 具备依据参数设置个性化需求的能力 (example:导航栏是否展示以及导航栏显示样式等)
    > 3. 每次展示都需要检查参数设置
    > 4. 原则上拦截到新的 URL 都会新生成一个实例来加载 Web 页，但也有一些情况不需要重新生成新的实例来加载(example：重定向、返回交互中刷新操作、新生成的控制器对象即第一次加载URL、表单提交等；该部分可学习 [WK使用及问题](https://github.com/itwyhuaing/HybridAPP/tree/master/WK使用及问题) 解决)。

5. 三个版本简要对比：

 > 三个版本均采用拦截 URL 方式
  版本一与版本二很大的弊端是针对每个不同的 Web 页都有有限的类与之对应，随着项目迭代，这部分的修改就不是一般的繁琐

 > 版本一与版本二提取关键字的方式不能及时修复线上问题且不利于后台代码在版本迭代中的维护

 > 版本三能够很好的解决版本一、二的问题，且能满足跳转任意 Web 页的产品需求。


##### 具体问题笔记

1. [WKWeb输出Console.log日志](https://github.com/itwyhuaing/HybridAPP/tree/master/WKWeb输出Console.log日志)

2. [WK使用及问题](https://github.com/itwyhuaing/HybridAPP/tree/master/WK使用及问题)  [Web加载缓存问题](https://github.com/itwyhuaing/HybridAPP/tree/master/Web加载缓存问题)
