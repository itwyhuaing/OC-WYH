# iOS基础
iOS基础 记录 。

---
### 深浅拷贝

1. 浅拷贝只是拷贝指向存储空间的指针；深拷贝是新开辟一块内存，将已存储的待拷贝对象拷贝一份存储在新的内存空间里。

2. copy 得到的类型为不可变，mutableCopy 得到的类型为可变；copy 即可是浅拷贝也可是深拷贝，mutableCopy 深拷贝。

3. 属性中，NSString、NSArray、NSDictionary 等不可变类型应当使用 copy 而非 strong ；可见 Demo 数据结果。

---
### 类的继承、类的类别（分类）、类的扩展

1. 继承，继承了父类的所有方法与属性，避免重新定义也避免代码冗杂；可新增方法与属性、成员变量，可重写父类方法。

2. 类别（category），可在不熟悉原有类的基础上为其新增方法；倘若新增方法与原类中已有方法冲突，则类别中的方法将会覆盖原类中的方法，具有更高优先级。类别可以新增属性，但无法生成相应的成员变量和getter 、setter 方法的实现。

3. 扩展(extensions)，既可以新增属性、成员变量也可以添加方法；扩展可以视为私有的类别。

4. 类别为何不可以新增成员变量，而扩张可以新增成员变量 ？（内存方面可以作如下理解）类别是在运行时加载的；扩展是作为类的一部分在编译时加载的，在编译过程中，内存已完成分配，在之后的运行过程中不太可能再为类别中新增的成员变量改变内存分配。

#### 参考
* [【iOS】Category VS Extension 原理详解](http://www.cocoachina.com/ios/20170502/19163.html)
* [关于分类添加成员变量及分类中方法重写(覆盖) Demo](https://github.com/itwyhuaing/OC-WYH/tree/master/NSRuntime)


---
### KVC 与 KVO

1. KVC，键值编码机制，提供一种读写对象成员变量和属性的方式；这里包括对象的私有的成员变量和属性。

2. KVO，键值监听(键值观察机制)，提供了一种监听对象属性变化的方式；KVO 依赖于 setter 方法的调用，所以避开 setter 方法而进行的设置值并不受监听。

#### 参考
* [iOS KVC和KVO详解](https://www.jianshu.com/p/b9f020a8b4c9)
* [用代码探讨 KVC/KVO 的实现原理](https://juejin.im/post/5ac5f4b46fb9a028d5675645)


---
### 如何理解 OC 是动态语言 ?

OC 程序在运行过程中，数据类型和对象的类别并不是编译时确定，而是推迟到了运行时。
这里我们可以先理解两个概念：多态和运行时。
多态，该技术以继承为基础，继承同一个父类的子类重写父类方式时，可以有各自不同的实现。在调用过程中，子类调用各自的实现，父类不会调用任何一个子类的实现。
运行时，OC 语言的运行时机制使得一个对象类别的确定以及该类的方法列表的确定推迟到运行时才确定。

---
### 响应链


### Block


#### 参考
* [iOS中Block的用法，举例，解析与底层原理](http://www.cocoachina.com/ios/20180424/23147.html)











---
#### OC 语言的三大特性 [参考](https://blog.csdn.net/wl635512958/article/details/41750831)

* 封装

> 过滤不合理的值;屏蔽内部的赋值过程;让外界不必关注内部的细节。

* 继承

> 抽取了重复代码;建立了类与类之间的联系。

* 多态

> 要想使用多态必须使用继承（继承是多态的前提）


* 多重继承、分类、方法重写

> Objective-C的类不可以多重继承；可以实现多个接口（协议）。一个类的方法重写，采用分类比较好，这样重写的方法仅对本分类有效，不会影响其他类与原有类的关系。

#### Property 与 属性修饰符  [参考1](https://juejin.im/post/5bf608c6e51d451f6e5299f7)

* Property

```
property = 实例变量+setter方法+getter方法
```
> 属性修饰符会直接影响后续编译器对于 setter 和 getter 方法的合成。

* 线程安全问题(原子性 : atomic VS nonatomic)

> 具备atomic特质的属性，编译器合成的setter和getter方法会加锁，能够保证当多个线程在读写属性时，总是能够获取到属性值，如果修饰符为nonatomic，则不会对setter和getter方法加锁，在通常情况下，使用nonatomic不会带来什么问题，但是如果一个线程在多次修改某个属性时，另一个线程去读取属性时，可能会取到未修改好的属性。

* 读/写权限 (readwrite VS readonly)

> readwrite 修饰的属性只会合成setter和getter方法 。readonly 修饰的属性只会合成getter方法，可以以直接访问实例变量的方式来完成赋值操作。

* 内存管理 (assign、weak、strong、retain、unsafe_unretained、copy)

> 该部分的修饰符主要影响编译器合成 setter 方法。

  * assign

    > 修饰基础类型数据，setter 方法只执行简单的赋值操作。

  * weak

    > weak 是 ARC 中新增加的属性修饰符，使用 weak 修饰的属性的 setter 方法会既不保留新值，也不释放旧值，不会使属性指的对象的引用计数增加，当指向的对象被释放时，属性值也会被自动置为 nil。

  * strong

    > strong 是 ARC 中新增加的属性修饰符，跟MRC时代中的retain修饰符很像，描述一种“拥有关系”，使用strong修饰的属性的setter方法会先保留新值，再释放旧值，最后把新值设置上。

  * retain  

    > 类似 ARC 下的 strong 。

  * unsafe_unretained

    > unsafe_unretained与assign类似，但是用于对象类型，从字面意思上，也能看到，它是不安全，也不会强引用对象，所以它跟weak很相似，跟weak的区别在于当指向的对象被释放时，属性不会被置为nil，所以是不安全的。

  * copy

    > copy表达的语义相似，都会持有对象，但是它的setter方法不会保留新值，而是会调用对象的copy方法将新值拷贝一份，然后将它设置上。

    ```
    1. NSString、NSArray、NSDictionary 等等经常使用copy关键字，是因为他们有对应的可变类型：NSMutableString、NSMutableArray、NSMutableDictionary；
      1.1 使用copy的目的是，防止把可变类型的对象赋值给不可变类型的对象时，可变类型对象的值发生变化会无意间篡改不可变类型对象原来的值。

    2. block 也经常使用 copy 关键字。
      2.1. block 使用 copy 是从 MRC 遗留下来的“传统”,在 MRC 中,方法内部的 block 是在栈区的,使用 copy 可以把它放到堆区.在 ARC 中写不写都行：对于 block 使用 copy 还是 strong 效果是一样的，但写上 copy 也无伤大雅，还能时刻提醒我们：编译器自动对 block 进行了 copy 操作。如果不写 copy ，该类的调用者有可能会忘记或者根本不知道“编译器会自动对 block 进行了 copy 操作”，他们有可能会在调用之前自行拷贝属性值。这种操作多余而低效。

    4.
    ```

#### 浅拷贝和深拷贝

> 浅拷贝只复制指向对象的指针，而不复制引用对象本身,也就是不会另开辟存储区；深拷贝：复制引用对象本身。内存中存在了两份独立对象本身，当修改A时，A_copy不变。

#### 系统对象的 copy 与 mutableCopy

> 不管是集合类对象（ NSArray、NSDictionary、NSSet ... 之类的对象 ），还是非集合类对象（ NSString, NSNumber ... 之类的对象 ），接收到copy和mutableCopy消息时，都遵循以下准则：
  >> 1. copy 返回的是不可变对象（immutableObject）；如果用copy返回值调用mutable对象的方法就会crash。
  >> 2. mutableCopy 返回的是可变对象（mutableObject）。

> 只有对不可变对象进行 copy 操作是指针复制（浅复制），其它情况都是内容复制（深复制）！

#### OC 的内存管理

> Objective-C的内存管理主要有三种方式ARC(自动内存计数)、手动内存计数、内存池。

* 自动内存计数ARC：由Xcode自动在App编译阶段，在代码中添加内存管理代码。

* 手动内存计数MRC：遵循内存谁申请、谁释放；谁添加，谁释放的原则。

* 内存释放池Release Pool：把需要释放的内存统一放在一个池子中，当池子被抽干后(drain)，池子中所有的内存空间也被自动释放掉。内存池的释放操作分为自动和手动。自动释放受runloop机制影响。


#### Category（类别/分类）、 Extension（扩展）和继承

* 类别/分类只能扩展方法（属性也可以扩展，但需运用运行时）；类扩展可以扩展属性、方法和成员变量；继承可以增加、修改方法，也可以增加属性。

#### OC 语言的动态特性

> OC 语言的动态特性是指数据类型、对象的类别以及调用该类别对象的方法在代码编译之后的运行时确定，依赖于运行时机制。

#### #import、#include、@class； #import<>、#import””

  >  #import是Objective-C导入头文件的关键字，#include是C/C++导入头文件的关键字，使用#import头文件会自动只导入一次，不会重复导入。

  > @class告诉编译器某个类的声明，当执行时，才去查看类的实现文件，可以解决头文件的相互包含。

  > #import<>用来包含系统的头文件，#import””用来包含用户头文件。

#### @public，@protected，@private，@package 含义

```
@public 任何地方都能访问;

@protected 该类和子类中访问,是默认的;

@private 只能在本类中访问;

@package 本包内使用,跨包不可以。

```

#### Instruments

* Time Profiler: 性能分析

* Zombies：检查是否访问了僵尸对象，但是这个工具只能从上往下检查，不智能。

* Allocations：用来检查内存，写算法的那批人也用这个来检查。

* Leaks：检查内存，看是否有内存泄露。

#### GCD 与 NSOperation

> GCD 和 NSOperation 都是用于实现多线程

> GCD 基于C语言的底层API，GCD主要与block结合使用，代码简洁高效。

> NSOperation 属于Objective-C类，是基于GCD更高一层的封装。复杂任务一般用NSOperation实现。

#### 消息转发  

> 消息转发  (_objc_msgForward) 是 IMP 类型，用于消息转发的；当向一个对象发送一条消息，但它并没有实现的时候，_objc_msgForward 会尝试做消息转发 。

#### 网络

* TCP 与 UDP

> TCP 是传输控制协议。TCP 是面向连接的，建立连接需要经历三次握手，是可靠的传输层协议。

> UDP 是用户数据协议。UDP 是面向无连接的，数据传输是不可靠的 ，它只管发，不管收不收得到。

> 简单的说，TCP注重数据安全，而UDP数据传输快点，但安全性一般。


#### APNS

> APNS优势：杜绝了类似安卓那种为了接受通知不停在后台唤醒程序保持长连接的行为，由iOS系统和APNS进行长连接替代。

> APNS的原理：

  >> 1). 应用在通知中心注册，由iOS系统向APNS请求返回设备令牌(device Token)

  >> 2). 应用程序接收到设备令牌并发送给自己的后台服务器

  >> 3). 服务器把要推送的内容和设备发送给APNS

  >> 4). APNS根据设备令牌找到设备，再由iOS根据APPID把推送内容展示


### 关于面试知识题目参考

* [iOS面试知识点整理](http://www.cocoachina.com/cms/wap.php?action=article&id=23051)
* [iOS面试总结（基础知识深入及新知识扩展）](https://www.jianshu.com/p/c3e56d6cf06f)
* [iOS面试题合集（上）](https://www.jianshu.com/c/31a515b57aef)
