# NSRunloop

* 常见应用场景：
 (多源处理)UI 操作过程中定时器停止，最常见于 UIScrollView 滚动过程中。示例与简要分析见Demo。

* 常见应用场景：
 (线程保活)iOS / OS 系统为了提供系统性能，子线程会在任务执行结束之后，自动销毁。但偶尔也会遇到保证一个线程不被销毁的场景，解决方案如下。示例与简要分析见Demo。

* 简要认识

  > 1. 字面的意思来看就是：运行循环。

  > 2. 基本作用：
  >> 2.1、保持程序的持续运行  
  >> 2.2、处理app中各种事件（触摸事件、定时器事件、Selector事件等）
  >> 2.3、能节省CPU，提高程序的性能：该做事的时候就被唤醒，没有事情就睡眠。

  > 3. RunLoop与线程： 每条线程都有唯一的一个与之相对应的 RunLoop 对象；主线程的 RunLoop 由系统自动创建，子线程的RunLoop可以手动创建； RunLoop 在线程结束的时候会被销毁。

  > 4. 一个 RunLoop 中包含多个 Mode ，每个 Mode 中又包含了多个 Source/Timer/Observer ； 一个 RunLoop 在同一时间只能处在一种运行模式下，这个模式就是 CurrentMode 。

  > 5. 系统默认注册了5种Mode ：

  ```
  NSDefaultRunLoopMode          - 默认的 Model ,通常主线程的 RunLoop 是在这个 Mode 下运行
  UITrackingRunLoopMode         - 界面跟踪 Model ，当用户与界面交互的时候会在此 Model 下运行
  NSRunLoopCommonModes          - 这个不是一个真正的 Model ，是一个占位用的 Model
  UIInitializationRunLoopMode   - 程序启动时的 Model ，启动完成后就不在此 Model 下
  GSEventReceiveRunLoopMode     - 接受系统事件的内部 Model ，一般我们用不到
  ```

##### 参考资料
* [RunLoop - 比较基础](http://www.jianshu.com/p/e60088c1c46f)
* [深入理解RunLoop](https://blog.ibireme.com/2015/05/18/runloop/)
