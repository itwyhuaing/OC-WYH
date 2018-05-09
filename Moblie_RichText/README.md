# OC-WYH
富文本方案。

### Web 富文本编辑器方案

> ZSSRichTextEditor
> 笔记中 RichTextProjectDemo 是由 ZSSRichTextEditor 方式升级为 WKWeb 方式的富文本编辑器。

* 优点
> 富文本编辑器实现比较容易;不涉及  HTML 数据解析与组装的棘手问题。

* 缺点
> 一个 web 实现所有，毕竟不是原生控件；若是想实现与原生控件无异的交互体验，需要强大的前端知识。
> 部分标签具备兼容性问题，并不能很好的实现功能：下划线、粗体字等的选中与取消。
> 部分标签属于行标签，选中后所修改的是整行样式，但这种大多数并不是用户所想要的。

### 原生富文本编辑器方案

> UITextView ，其中已有的轮子 SimpleWord - 石墨文档原生方案
> YYText 在展示中如果有太多个性化展示效果比较麻烦。

* 优点
> 可控性比较强，交互体验好。

* 缺点
> 组装 HTML 数据 或 解析 HTML 数据都不易。


### 富文本展示(不可编辑)
* 轻量级 HTML+CSS 样式的解析框架 DTCoreText 。注：集成比较坑，建议使用 Cocoapods 管理。


### 参考文献
* [Web 富文本编辑器](https://github.com/nnhubbard/ZSSRichTextEditor)
* [原生富文本编辑器](https://github.com/littleMeaning/SimpleWord)
* [iOS开发小记：iOS富文本框架DTCoreText在UITableView上的使用](https://blog.csdn.net/lala2231/article/details/50780842)
