#

### 白说
* 使用真机设备。
* 应用程序运行处于发布配置 而不是调试配置。
* 利用 TiTime Profiler , 可以获取到整个应用程序运行消耗时间分布和百分比。



### 原理
* 按照固定的时间间隔来跟踪每一个线程的堆栈信息,通过统计比较时间间隔之间的堆栈状态，来推算某个方法执行的时间，并获得一个近似值。


### 参考资料
* [iOS性能优化](http://www.jianshu.com/p/9e1f0b44935c)
* [IOS性能调优系列：使用Time Profiler发现性能瓶颈](http://www.cnblogs.com/ym123/p/4324335.html)
* [iOS Instrument使用之Timer Profiler耗时分析 - 新版](https://blog.csdn.net/kuangdacaikuang/article/details/78919702)
* [使用 Instruments 做 iOS 程序性能调试](https://blog.csdn.net/wlly1/article/details/78461197)
* [Leaks](http://www.jianshu.com/p/d0e149332380)


* [Analyze 静态分析简单示例](https://www.jianshu.com/p/f344abae35ce)
