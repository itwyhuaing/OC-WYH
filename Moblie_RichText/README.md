# OC-WYH
富文本方案。

---
## 富文本展示

### UITextView

* 数据结构若为 json 格式可直接使用原生控件展示，适用于新项目。

* 将 HTML 数据结构视为字符串 NSString ，也可进一步将其转换为 NSAttributedString / NSMutableAttributedString 作进一步属性修改；最后将其赋值给  UITextView 的 attributedText 属性。
* 经测试，在加载 HTML 数据中，使用 UITextView 与 WKWebView 加载,视图内容区开始变化的时间相差（ 10 * 10 ）两个数量级。
 但是，在第一次加载 HTML 数据时需要较长时间的转换，该过程比较耗费时间。

* Demo 示例中多次加载大致时间(内容高度不在变化位置)依次为：

```
1.545074
1.089950
1.128307
1.150971
```

### UIWebView （iOS 8 之前）

* 数据结构若为 json 格式可直接使用原生控件展示，适用于新项目。

* 将 HTML 数据结构视为字符串 NSString ,然后使用 UIWebView 加载本地字符串（loadHTMLString）。

* Demo 示例中多次加载大致时间(内容高度不在变化位置)依次为：

```
1.279048
1.132917
1.121078
```

### WKWebView （iOS 8 及之后版本系统）

* 同 UIWebView。


### 原生控件展示

1. 数据源是 html 格式时，需要先解析成数据模型再使用相应的原生控件展示。
    * 关于 HTML 数据格式的解析，这里暂且使用 TFHpple ，可以解析出标签及相应的属性。但有一个问题需要思考的是，解析过程若是按标签类别解析，在解析之后还需要对已解析出的数据模型进行排序；也就是说要按照 HTML 格式将解析出的文本数据、换行数据、图片数据等类型的数据模型按照 HTML 内容展示的顺序进行排序。在自己的项目中已尝试，调试也已通过但蛮花费时间。后来在想是否可以依照标签顺序解析，尚未尝试；应为这样你只需要针对项目写出标签的解析方法就可以了，而无需在解析之后在进行排序。
    * 这种方式也是在旧项目数据结构以HTML为主且需要升级用户体验情况下采用；移动端性能如此珍贵的前提下，大部分工作堆在移动端来处理终究不是最明智的选择也不是好的产品方案。
2. 数据源是 json 格式时，直接解析成数据模型再使用相应的原生控件展示。
   * 这种方式就比较直白简单，后端给定json数据，正常解析为数据模型，使用相应原生控件展示即可。
   * 新项目大多采用这种方式，移动端只需要拿数据解析-展示，即便已发布出了问题，后端修改数据结构就可以轻松解决问题。

### 第三方库

1. 轻量级 HTML+CSS 样式的解析框架 DTCoreText 。注：集成比较坑，建议使用 Cocoapods 管理。

---
## 富文本编辑

### UITextView

#### 简述

1. 已有的轮子 SimpleWord - 石墨文档原生方案。

2. YYText 在展示中如果有太多个性化展示效果比较麻烦。


* 优点
> 可控性比较强，交互体验好。

* 缺点
> 组装 HTML 数据 或 解析 HTML 数据都不易。

#### UITextView 认识


* [键盘遮挡问题解决](http://www.zhimengzhe.com/IOSkaifa/355632.html)

```

textContainerInset


contentInset


allowsNonContiguousLayout

```

* [编辑过程中过动态高度](https://www.jianshu.com/p/36d62951ffc1)


```
-(void)textViewDidChange:(UITextView *)textView;
```



* [iOS--NSAttributedString超全属性详解及应用（富文本、图文混排）](https://www.jianshu.com/p/1056d983bdfd)    [iOS-属性字符串 NSAttributedString](https://www.jianshu.com/p/71489b66b0c3)


```

NSFontAttributeName; //字体，value是UIFont对象
NSParagraphStyleAttributeName;//绘图的风格（居中，换行模式，间距等诸多风格），value是NSParagraphStyle对象
NSForegroundColorAttributeName;// 文字颜色，value是UIFont对象
NSBackgroundColorAttributeName;// 背景色，value是UIFont
NSLigatureAttributeName; //  字符连体，value是NSNumber
NSKernAttributeName; // 字符间隔
NSStrikethroughStyleAttributeName;//删除线，value是NSNumber
NSUnderlineStyleAttributeName;//下划线，value是NSNumber
NSStrokeColorAttributeName; //描绘边颜色，value是UIColor
NSStrokeWidthAttributeName; //描边宽度，value是NSNumber
NSShadowAttributeName; //阴影，value是NSShadow对象
NSTextEffectAttributeName; //文字效果，value是NSString
NSAttachmentAttributeName;//附属，value是NSTextAttachment 对象
NSLinkAttributeName;//链接，value是NSURL or NSString
NSBaselineOffsetAttributeName;//基础偏移量，value是NSNumber对象
NSUnderlineColorAttributeName;//下划线颜色，value是UIColor对象
NSStrikethroughColorAttributeName;//删除线颜色，value是UIColor
NSObliquenessAttributeName; //字体倾斜
NSExpansionAttributeName; //字体扁平化
NSVerticalGlyphFormAttributeName;//垂直或者水平，value是 NSNumber，0表示水平，1垂直

```


### UIWebView / WKWebView

1. ZSSRichTextEditor(UIWebView)。

2. 笔记中 RichTextProjectDemo 是由 ZSSRichTextEditor 方式升级为 WKWeb 方式的富文本编辑器。


* 优点
  > 富文本编辑器实现比较容易; 不涉及  HTML 数据解析与组装的棘手问题。

* 缺点

  > 一个 web 实现所有，毕竟不是原生控件；若是想实现与原生控件无异的交互体验，需要强大的前端知识。

  > 部分标签具备兼容性问题，并不能很好的实现功能：下划线、粗体字等的选中与取消。

  > 部分标签属于行标签，选中后所修改的是整行样式，但这种大多数并不是用户所想要的。

  > 体验好不好，只有用了才知道。（用了之后就不想再用了）。

##### 参考文献

* 富文本展示
  - [iOS开发小记：iOS富文本框架DTCoreText在UITableView上的使用](https://blog.csdn.net/lala2231/article/details/50780842)


* Web 实现富文本编辑器
  - [ZSSRichTextEditor git仓库](https://github.com/nnhubbard/ZSSRichTextEditor)
  - [ZSSRichTextEditor 基础上实现富文本编辑笔记(持续更新中)](https://github.com/itwyhuaing/Web-WYH)
  - [基于 UIWebView 的富文本编辑器实践 - WeRead团队博客](http://wereadteam.github.io/2016/09/21/RichEditor/)


* 原生富文本编辑器
  - [原生富文本编辑器](https://github.com/littleMeaning/SimpleWord)
