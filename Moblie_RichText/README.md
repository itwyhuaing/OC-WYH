# OC-WYH
富文本方案。

### JS 部分语法记录
* window.getSelection() ;
> 返回一个  Selection 对象，表示用户选择的文本范围或插入符号的当前位置。

* document.close()
> 关闭一个由 document.open 方法打开的输出流，并显示选定的数据

* document.open()
> 打开文档流

* document.write()
> 写入 文档流

* document.createElement()
* document.createTextNode()
* document.createAttribute()
> 标签、文本、属性创建

* HTMLElement.setAttribute()
* HTMLElement.getAttribute()
> 属性获取与设置(对于已有的属性进行覆盖，否则先创建在赋值)

* document. getElementsByClassName()
* document.getElementById()
* document.getElementsByName()
* document.getElementsByTagName()
>  标签元素获取

* document.images
>

* innerHTML
> 读或写

* bool = document.execCommand(aCommandName, aShowDefaultUI, aValueArgument)
> 当使用 contentEditable时，调用 execCommand() 将影响当前活动的可编辑元素。
  开启或关闭 的 aCommandName有 :bold 、italic 、strikeThrough 、subscript、superscript、underline

* isEnabled = document.queryCommandEnabled(command);
> 查询浏览器是否支持指定的富文本编辑指令

* window.location
> 衔接跳转。

* JavaScript event对象
> 该对象表示当前事件。


### 参考文献
* [DOM-API中英文](https://developer.mozilla.org/zh-CN/docs/Web/API)
* [JavaScriptCore 使用](http://www.jianshu.com/p/a329cd4a67ee)
* [JS Event对象了解](http://www.itxueyuan.org/view/6340.html)
