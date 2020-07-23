富文本展示
---

**数据结构若为 json 格式**

> 可直接使用原生控件 UILabel、UIImageView等基础控件 展示，更适用于新项目。


**数据结构若为 HTML 格式**

> 一种方式是：将 HTML 数据结构视为字符串 NSString ，也可进一步将其转换为 NSAttributedString / NSMutableAttributedString 作进一步属性修改；最后将其赋值给 UITextView 的 attributedText 属性。
    
    
> 另一种方式：将 HTML 数据结构视为字符串 NSString ,然后使用 UIWebView （iOS 8 及之前版本）/ WKWebView （iOS 8 及之后版本系统） 加载本地字符串（loadHTMLString）。


**Demo 中加载同一段 html 格式数据**

> UITextView 多次加载所需时间
    
```
    1.545074
    1.089950
    1.128307
    1.150971
```

> WKWebView 多次加载所需时间

```
1.279048
1.132917
1.121078
```

**关于使用原生控件展示 HTML 格式数据**

1. 数据源是 html 格式时，需要先解析成数据模型再使用相应的原生控件展示。
    > 关于 HTML 数据格式的解析，这里暂且使用 TFHpple ，可以解析出标签及相应的属性。但有一个问题需要思考的是，解析过程若是按标签类别解析，在解析之后还需要对已解析出的数据模型进行排序；也就是说要按照 HTML 格式将解析出的文本数据、换行数据、图片数据等类型的数据模型按照 HTML 内容展示的顺序进行排序。在自己的项目中已尝试，调试也已通过但蛮花费时间。后来在想是否可以依照标签顺序解析，尚未尝试；应为这样你只需要针对项目写出标签的解析方法就可以了，而无需在解析之后在进行排序。

    > 这种方式也是在旧项目数据结构以HTML为主且需要升级用户体验情况下采用；移动端性能如此珍贵的前提下，大部分工作堆在移动端来处理终究不是最明智的选择也不是好的产品方案。

2. 数据源是 json 格式时，直接解析成数据模型再使用相应的原生控件展示。
    > 这种方式就比较直白简单，后端给定json数据，正常解析为数据模型，使用相应原生控件展示即可。
    
    > 新项目大多采用这种方式，移动端只需要拿数据解析-展示，即便已发布出了问题，后端修改数据结构就可以轻松解决问题。

3. 借助第三方库

    > 轻量级 HTML+CSS 样式的解析框架 DTCoreText 。注：集成比较坑，建议使用 Cocoapods 管理。






富文本编辑 - 已有方案简介
---
**原生**

> 优点:可控性比较强，交互体验好。

> 但不足也很明显，组装 HTML 数据 或 解析 HTML 数据都不易。

1. 已有的轮子 SimpleWord - 石墨文档原生方案。
2. YYText 在展示中如果有太多个性化展示效果比较麻烦。

**UIWebView（iOS8及之前）**

> 优点:富文本编辑器实现比较容易; 不涉及 HTML 数据解析与组装的棘手问题。

> 缺点:
    
* 一个 web 实现所有，毕竟不是原生控件；若是想实现与原生控件无异的交互体验，需要强大的前端知识。
* 部分标签具备兼容性问题，并不能很好的实现功能：下划线、粗体字等的选中与取消。
* 部分标签属于行标签，选中后所修改的是整行样式，但这种大多数并不是用户所想要的。
* 体验好不好，只有用了才知道。（用了之后就不想再用了）。

1. ZSSRichTextEditor(UIWebView)。


富文本编辑 - 自己“造”轮子
---
1. ZSSRichTextEditor 升级 WKWebView 实现。 

> 2020 年，注定是一个见证一个又一个历史时刻的一年。具体到工作上，Apple 已放弃了 UIWebView 的使用，这里涉及到之前给项目接入的以 ZSSRichTextEditor (使用UIWebView实现)为基础，改版而来的富文本编辑器需要升级。

* 待优化问题 ： 粗体、斜体等样式换行切换才生效。

* 参见 RichTextPro 代码，其目录与效果如图。

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/D_部分问题或方案/富文本编辑/Moblie_RichText/image/RTEditor_0.png)

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/D_部分问题或方案/富文本编辑/Moblie_RichText/image/RTEditor_1.png)

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/D_部分问题或方案/富文本编辑/Moblie_RichText/image/RTEditor_2.png)

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/D_部分问题或方案/富文本编辑/Moblie_RichText/image/RTEditor_3.gif)


##### 参考
* [ZSSRichTextEditor git仓库](https://github.com/nnhubbard/ZSSRichTextEditor)
* [ZSSRichTextEditor 基础上实现富文本编辑笔记(持续更新中)](https://github.com/itwyhuaing/Web-WYH)
* [基于 UIWebView 的富文本编辑器实践 - WeRead团队博客](http://wereadteam.github.io/2016/09/21/RichEditor/)

* [参考1-IOS - WebView富文本开发](https://www.jianshu.com/p/c4d7824362cb)
* [参考2-HTML 6种空白空格的区别](https://blog.csdn.net/u014068781/article/details/77962423)
* [参考3-document.execCommand](https://developer.mozilla.org/zh-CN/docs/Web/API/Document/execCommand)