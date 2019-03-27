# 关于设计模式

#### 关于设计模式

 ##### 1> 单例模式
 * 整个应用或系统只能有该类的一个实例。单例的实例方法与类方法的区别。
 * 优势：使用简单，易于跨模块，资源共享控制
 * 敏捷原则：单一职责原则
 * iOS开发中常用的单例有：UIApplication、NSBundle、NSFileManager、NSNotificationCenter、NSUserDefaults

  ##### 2> 代理模式
 * 一个实例对象可以设置一个代理对象，且代理对象可以替代被替代的实例对象实现方法。
 * 优势：解耦合
 * 敏捷原则：开放-封闭原则
 * iOS开发中常用的代理：UIScrollViewDelegate、UITableViewDelegate、UITableViewDataSource、UICollectionViewDelegate,UICollectionViewDataSource

  ##### 3> 监听模式
 * 一个对象状态改变，通知正在对他进行观察的对象，且对这些改变做出反应。
 * 优势：解耦合
 * 敏捷原则：接口隔离原则，开放-封闭原则
 * iOS开发中常用的监听机制：NSNotificationCenter、KVO(Key-Value-Observing)

  ##### 4> 适配模式
 * [参考](http://www.cocoachina.com/ios/20161013/17740.html)
 * 场景 ： 1> UIWeb 升级 WKWeb   2> 不同的地方复用同一个界面但赋值不同
 *
 *

  ##### 5> 工厂模式
* [参考](http://www.jianshu.com/p/69eb3026b5d4)

 #####  6> 策略模式
* [参考](http://www.jianshu.com/p/9aa7f1e14728)
