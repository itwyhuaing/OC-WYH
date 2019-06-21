# 不常用API/Class

##### CAGradientLayer

* 简要认识

> CAGradientLayer 是 CALayer 的一个子类，用来生成渐变色的 Layer ; CAGradientLayer 只能实现矩形范围内的颜色渐变（Demo 中展示矩形与环形(利用 CALayer 的 mask 属性的切割能力)渐变案例）。

> CAGradientLayer有5个属性：

```
// CGColorRef数组，用来定义渐变节点颜色
@property(nullable, copy) NSArray *colors;

// 存储每个渐变节点位置
@property(nullable, copy) NSArray<NSNumber *> *locations;

// 渐变色的起始点
@property CGPoint startPoint;

// 渐变色的结束点，和起始点共同能够成渐变方向
@property CGPoint endPoint;

// 没什么意义，只能设置为axial
@property(copy) NSString *type;
```

##### UIView

1. layoutSubviews

这个方法，默认没有做任何事情，需要子类进行重写 。

以下情况下会调用：

1> 直接调用[self setNeedsLayout];（这个在上面苹果官方文档里有说明）
2> addSubview的时候。
3> 当view的size发生改变的时候，前提是frame的值设置前后发生了变化。
4> 滑动UIScrollView的时候。
5> 旋转Screen会触发父UIView上的layoutSubviews事件（这个我验证了一下 确实没有触发layoutSubviews方法，查了很多资料都说会触发，大家自己定夺）。


2. layoutIfNeeded

调用该方法，可以立即更新约束效果。
setNeedsLayout 方法并不会立即刷新，立即刷新需要调用layoutIfNeeded方法！

3. setNeedsDisplay

与setNeedsLayout方法相似的方法是setNeedsDisplay方法。
该方法在调用时，会自动调用drawRect方法。drawRect方法主要用来画图。

小结：
当需要刷新布局时，用setNeedsLayOut方法；当需要重新绘画时，调用setNeedsDisplay方法。




##### 参考

* [渲染颜色渐变](https://www.jianshu.com/p/e7c9e94e165b)
