# WKWeb输出Console.log日志

* JS 解析

```
console.log = (function(originFunc){
                                            return function(info) {
                                                window.webkit.messageHandlers.log.postMessage(info);
                                                originFunc.call(console,info);
                                            }
                                        })(console.log)                                      
```
> originFunc 指代 log 函数；originFunc.call(console,info) 可以理解为 console.log(info) 。

> 函数声明：function fnName () {…};使用function关键字声明一个函数，再指定一个函数名，叫函数声明。

> 函数表达式 var fnName = function () {…};使用function关键字声明一个函数，但未给函数命名，最后将匿名函数赋予一个变量，叫函数表达式，这是最常见的函数表达式语法形式。

> 匿名函数：function () {}; 使用function关键字声明一个函数，但未给函数命名，所以叫匿名函数，匿名函数属于函数表达式，匿名函数有很多作用，赋予一个变量则创建函数，赋予一个事件则成为事件处理程序或创建闭包等等。

> ( function(){…} )()和( function (){…} () )这两种是立即执行函数的写法。倘若函数体后面加括号就能立即调用，则这个函数必须是函数表达式，不能是函数声明。
