##### CGAffineTransform 简要认识

CGAffineTransform 是一个用于处理形变的类,其可以改变控件的平移、缩放、旋转等,其坐标系统采用的是二维坐标系(平面),即向右为x轴正方向,向下为y轴正方向。直接作用在视图控件上。CATransform3D 系列与之相似，作用与视图的 layer 层。


* 平移：实现以初始位置为基准,在x轴方向上平移x单位,在y轴方向上平移y单位。

```
CGAffineTransformMakeTranslation(CGFloat tx, CGFloat ty)
```


* 缩放：实现以初始位置为基准,在x轴方向上缩放x倍,在y轴方向上缩放y倍。


```
CGAffineTransformMakeScale(CGFloat sx, CGFloat sy)
```


* 旋转：实现以初始位置为基准,将坐标系统逆时针旋转angle弧度(弧度=π/180×角度,M_PI弧度代表180角度)。弧度为正值时控件做顺时针旋转即坐标系做逆时针旋转。

```
CGAffineTransformMakeRotation(CGFloat angle)
```

* 在已有形变上的形变处理

CGAffineTransformTranslate      实现以一个已经存在的形变为基准,继续平移形变 。

CGAffineTransformScale          实现以一个已经存在的形变为基准,继续缩放形变 。

CGAffineTransformRotate         实现以一个已经存在的形变为基准,继续旋转形变 。

CGAffineTransformConcat         链接两个不同的动画。

```
CGAffineTransformTranslate(CGAffineTransform t, CGFloat tx, CGFloat ty)

CGAffineTransformScale(CGAffineTransform t, CGFloat sx, CGFloat sy)

CGAffineTransformRotate(CGAffineTransform t, CGFloat angle)
```

* CGAffineTransformIdentity  在形变之后设置该值以还原到最初状态 。


##### Core Animation 与 UIview

Core Animation 作用在 CALayer 上，UIView动画可以看成是对核心动画的封装，其本质也是对其 layer 进行操作；不同的是，通过 Core Animation 改变 layer 的状态（比如position），动画执行完毕后实际上是没有改变的 。

> 动画所作用的层级

![image]()


> Core Animation 动画家族

![image]()



Core Animation 动画优点：

  > 1. 性能强大，硬件加速，可以向多个图层添加不同的动画

  > 2. 接口简单易用，只需少量代码就可以直接实现复杂的动画效果

  > 3. 动画运动在后台线程中，在动画过程中可以响应交互事件(UIView 动画默认动画过程中不响应交互事件)


###### 参考

* [iOS动画篇_CoreAnimation(超详细解析核心动画)](http://www.cocoachina.com/ios/20170623/19612.html)

* [iOS动画篇：核心动画](https://www.jianshu.com/p/d05d19f70bac)
