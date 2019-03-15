# NSRuntime

## Demo查看
> FirstVC：获取 PersonDataModel 与 UIView 的属性、获取 PersonDataModel 与 UIView 的方法、获取 PersonDataModel 实例 / 类方法、系统方法拦截、属性遍历在数据模型归解档中的应用 ： MJEXtension,YYModel 字典与模型间的转换、依据类名字符串创建该类的实例对象

> DefendContinHitVC 按钮防连击应用


## 1. 概念
 NSRuntime即运行时系统，其位于OC 的底层，是一套C语言的API ！

## 2. 机制
动态语言，信息在程序运行阶段确定；消息分发机制。

## 3. 应用

### block 原理探究
> block 即匿名函数，在 iOS 开发中有着重要作用，其原理与具体应用细节见 《Objective-C高级编程 iOS与OS X多线程和内存管理》 一书整理笔记。  也可参考这里 [iOS中Block的用法，举例，解析与底层原理（这可能是最详细的Block解析）](http://www.cocoachina.com/ios/20180424/23147.html)


#### 方法的添加、替换、交换
> 替换系统方法相当于获取系统的底层实现，然后在系统方法里添加自己的修改代码；可以类比于 window 系统的 hook 功能。项目中自定义的统计系统，在统计pv时通过拦截控制器的生命周期函数，在其中添加自己的统计代码即可，还有按钮的防连击功能等。

* 必要基础

> objc_msgSend 最基本的用于消息转发的函数。

> SEL    : @selector();

>  Method : Method class_getInstanceMethod(Class cls, SEL name);

>  IMP    : IMP method_getImplementation(Method m);


* 方法替换
```
IMP class_replaceMethod(Class cls, SEL name, IMP imp, const char *types);
```
> cls   ：被添加方法的类  
> name  ：被替换/添加方法的方法名  
> imp   ：被替换/添加方法的实现函数  
> types ：被添加方法的实现函数的返回值类型和参数类型的字符串


* 方法增加
```
BOOL class_addMethod(Class cls, SEL name, IMP imp, const char *types);
```
> cls   ：被添加方法的类  
> name  ：被替换/添加方法的方法名  
> imp   ：被替换/添加方法的实现函数  
> types ：被添加方法的实现函数的返回值类型和参数类型的字符串

* 方法交换
```
void method_exchangeImplementations(Method m1, Method m2);
```
> m1  ：被替换的方法
>
> m2  ：自定义的方法

####  获取属性列表 / 方法列表
> 属性遍历最常用的场景是在数据模型归档与解档中，以及字典转模型-这在知名 MJEXtension,YYModel 等三方库中都有使用。

* 属性列表获取
```
objc_property_t  _Nonnull * class_copyPropertyList(Class cls, unsigned int *outCount);
const char * property_getName(objc_property_t property);
```

* 方法列表获取
```
Method  _Nonnull * class_copyMethodList(Class cls, unsigned int *outCount);
SEL method_getName(Method m);
NSString * NSStringFromSelector(SEL aSelector);

```

* 获取类的实例方法 / 获取类的类方法
```
Method class_getInstanceMethod(Class cls, SEL name);
Method class_getClassMethod(Class cls, SEL name);
```

#### 分类增加属性
> oc 分 Categary 功能是不能为现有类增加属性的，但借助NSRuntime可以轻松实现。

* Associated Objects 主要有以下三个使用场景。
  1. 为现有类添加私有属性
  2. 为现有类添加公有属性
  3. 为 KVO 创建一个关联的观察者

* 相关函数
```
id objc_getAssociatedObject(id object, const void *key);
void objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy);
```
> 几个参数中需要补充的是：objc_AssociationPolicy policy ，该参数对应表如下：

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/NSRuntime/image/image_1.png)

#### 依据类名字符串创建该类的实例对象
> 给出已存在类的类名字符串，借助NSRuntime创建出该类实例。


##### 参考文章

* [让你快速上手Runtime](https://www.jianshu.com/p/e071206103a4)

* [runtime详解](https://www.jianshu.com/p/46dd81402f63)

* [Runtime 10种用法（没有比这更全的了）](http://www.jianshu.com/p/3182646001d1)

* [class_getInstanceMethod和class_getClassMethod](http://blog.csdn.net/lvdezhou/article/details/49636561)

* [Objective C运行时（runtime）技术的几个要点总结](http://www.cnblogs.com/gugupluto/p/3159733.html)

* [Objective-C Associated Objects 的实现原理](http://www.cocoachina.com/ios/20150629/12299.html)
