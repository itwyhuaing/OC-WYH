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

##### 参考

* [渲染颜色渐变](https://www.jianshu.com/p/e7c9e94e165b)
