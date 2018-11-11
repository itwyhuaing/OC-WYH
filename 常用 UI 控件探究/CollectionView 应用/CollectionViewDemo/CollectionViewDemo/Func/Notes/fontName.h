##### view 图层与UI刷新
1. layoutSubviews
* 这个方法，默认没有做任何事情，需要子类进行重写 。系统在很多时候会去调用这个方法，初始化不会触发layoutSubviews，但是如果设置了不为CGRectZero的frame的时候就会触发。
* 直接调用 [self setNeedsLayout] 、添加子视图、size 发生变化、UIScrollView 滚动或Screen发生旋转

2. layoutIfNeeded
* 使用约束的时候 调一下可以立即更新效果；setNeedsLayout方法并不会立即刷新。

3. setNeedsDisplay
* 该方法在调用时，会自动调用drawRect方法。drawRect方法主要用来画图。
* 当需要刷新布局时，用setNeedsLayOut方法；当需要重新绘画时，调用setNeedsDisplay方法。

4. sizeThatFits/sizeToFit
* 一般在使用UILabel的时候会用到，使用这两个方法之前，必须要给label赋值，否则不会显示内容的。
* 赋值 - 调用 之后可以拿到尺寸。

================================================
extendedLayoutIncludesOpaqueBars
automaticallyAdjustsScrollViewInsets

1. 这两个属性属于UIViewController
2. 默认情况下extendedLayoutIncludesOpaqueBars = false 扩展布局不包含导航栏；默认情况下automaticallyAdjustsScrollViewInsets = true 自动计算滚动视图的内容边距
3. 当导航栏是不透明时,而tabBar为透明的时候,为了正确显示tableView的全部内容,需要重新设置这两个属性的值,然后设置contentInset



contentInsetAdjustmentBehavior
1. 概属性属于UIScrollView
2. iOS 11 之后 automaticallyAdjustsScrollViewInsets 已弃用，contentInsetAdjustmentBehavior 为新增 API
