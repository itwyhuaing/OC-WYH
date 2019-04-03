# 关于设计模式

#### 关于设计模式

 > 设计模式简单的理解就是处理 UI 展示与逻辑问题的方式方法。

 ##### 1> MVC 模式
  * 最常见的设计模式；Model View Control，把模型 视图 控制器 层进行解耦合编写。
  * MVC是一切设计的基础，所有新的设计模式都是基于MVC进行的改进。

 ##### 2> MVVM 模式
  * Model View ViewModel 把模型 视图 业务逻辑 层进行解耦和编写。
  * MVVM是对胖模型进行的拆分，其本质是给控制器减负，将一些弱业务逻辑放到VM中去处理。

 ##### 3> MVP 模式
  * 从 MVC 中又抽象出了 P 层, 即 Presenter 层。
  * P 层完全拥有 MVC 模式下 C 层的权利和职责。
  * 该模式下的 C 只需要调用 P 层暴露出的接口，进而完成整个业务逻辑和页面展示。 

 ##### 4> 单例模式
 * 整个应用或系统只能有该类的一个实例。单例的实例方法与类方法的区别。
 * 优势：使用简单，易于跨模块，资源共享控制
 * 敏捷原则：单一职责原则
 * iOS开发中常用的单例有：UIApplication、NSBundle、NSFileManager、NSNotificationCenter、NSUserDefaults

  ##### 5> 代理模式/委托模式
 * 一个实例对象可以设置一个代理对象，且代理对象可以替代被替代的实例对象实现方法。
 * 优势：解耦合
 * 敏捷原则：开放-封闭原则
 * iOS开发中常用的代理：UIScrollViewDelegate、UITableViewDelegate、UITableViewDataSource、UICollectionViewDelegate,UICollectionViewDataSource

  ##### 6> 监听模式/观察者模式
 * 一个对象状态改变，通知正在对他进行观察的对象，且对这些改变做出反应。
 * 优势：解耦合
 * 敏捷原则：接口隔离原则，开放-封闭原则
 * iOS开发中常用的监听机制：NSNotificationCenter、KVO(Key-Value-Observing)

  ##### 7> 适配模式
 * [参考](http://www.cocoachina.com/ios/20161013/17740.html)
 * 场景 ： 1> UIWeb 升级 WKWeb   2> 不同的地方复用同一个界面但赋值不同

  ##### 8> 工厂模式
* [参考](http://www.jianshu.com/p/69eb3026b5d4)

 #####  9> 策略模式
* [参考](http://www.jianshu.com/p/9aa7f1e14728)
