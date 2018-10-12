##### CGAffineTransform 简要认识
CGAffineTransform 是一个用于处理形变的类,其可以改变控件的平移、缩放、旋转等,其坐标系统采用的是二维坐标系(平面),即向右为x轴正方向,向下为y轴正方向。

1. 平移：实现以初始位置为基准,在x轴方向上平移x单位,在y轴方向上平移y单位。

```
CGAffineTransformMakeTranslation(CGFloat tx, CGFloat ty)
```

2. 缩放：实现以初始位置为基准,在x轴方向上缩放x倍,在y轴方向上缩放y倍。

```
CGAffineTransformMakeScale(CGFloat sx, CGFloat sy)
```

3. 旋转：实现以初始位置为基准,将坐标系统逆时针旋转angle弧度(弧度=π/180×角度,M_PI弧度代表180角度)。弧度为正值时控件做顺时针旋转即坐标系左逆时针旋转。

```
CGAffineTransformMakeRotation(CGFloat angle)
```

4. 在已有形变上的形变处理
CGAffineTransformTranslate      实现以一个已经存在的形变为基准,继续平移形变 。
CGAffineTransformScale          实现以一个已经存在的形变为基准,继续缩放形变 。
CGAffineTransformRotate         实现以一个已经存在的形变为基准,继续旋转形变 。
```
CGAffineTransformTranslate(CGAffineTransform t, CGFloat tx, CGFloat ty)

CGAffineTransformScale(CGAffineTransform t, CGFloat sx, CGFloat sy)

CGAffineTransformRotate(CGAffineTransform t, CGFloat angle)
```


5. CGAffineTransformIdentity  在形变之后设置该值以还原到最初状态。
