# CALayer

### CALayer 简要介绍

1. 在iOS系统中，你能看得见摸得着的东西基本上都是UIView，比如一个按钮、一个文本标签、一个文本输入框、一个图标等等，这些都是UIView。
2. 其实 UIView 之所以能显示在屏幕上，完全是因为它内部所关联的一个 CALayer 类的属性，可称这个 Layer 为 Root Layer（根层）,所有的非 Root Layer，也就是手动创建的 CALayer 对象，都存在着隐式动画。
3. 在创建UIView对象时，UIView内部会自动创建一个层(即CALayer对象)，通过UIView的layer属性可以访问这个层。当UIView需要显示到屏幕上时，会调用drawRect:方法进行绘图，并且会将所有内容绘制在自己的层上，绘图完毕后，系统会将层拷贝到屏幕上，于是就完成了UIView的显示。
4. 由于 UIView 的显示依赖于内部的 CALayer 类属性，所以通过操作 CALayer 可以方便地调整显示细节，诸如：圆角，阴影，描边，还可以实现部分动画。
5. 常用属性：

```
@property CGRect frame;                           // 图层大小和位置
@property CGRect bounds;                          // 图层大小
@property(nullable) CGColorRef backgroundColor;   // 图层背景颜色
@property(nullable) CGColorRef borderColor;       // 图层边框颜色
@property CGFloat borderWidth;                    // 图层边框宽度
@property(nullable, strong) id contents;          // 图层显示内容，例如可以将图片作为图层内容显示
@property CGRect contentsRect;                    // 图层显示内容的大小和位置
@property CGFloat cornerRadius;                   // 圆角半径
@property(getter=isHidden) BOOL hidden;           // 是否隐藏
@property(nullable, strong) CALayer *mask;        // 图层蒙版
@property BOOL masksToBounds;                     // 子图层是否剪切图层边界，默认是NO
@property float opacity;                          // 图层透明度，类似与UIView的alpha
@property(nullable) CGColorRef shadowColor;       // 阴影颜色
@property CGSize shadowOffset;                    // 阴影偏移量
@property float shadowOpacity;                    // 阴影透明度，注意默认为0，如果设置阴影必须设置此属性
@property(nullable) CGPathRef shadowPath;         // 阴影形状
@property CGFloat shadowRadius;                   // 阴影模糊半径

@property CGFloat zPosition;                        // 图层中心点在z轴中的位置
@property(getter=isDoubleSided) BOOL doubleSided;   // 图层背景是否显示，默认是YES
@property CGFloat anchorPointZ;                     // 图层在z轴中的锚点；
@property CATransform3D transform;                  // 与动画相关

@property CGPoint position;
@property CGPoint anchorPoint;
```

其中 position 与 anchorPoint 两个属性对于图层位置的影响如下：
![]()

其中具有隐身动画的属性有：bounds 、backgroundColor
倘若想要关闭默认的隐式动画，这里提供如下参考代码：
```
[CATransactionbegin];
[CATransactionsetDisableActions:YES];
self.myview.layer.position= CGPointMake(100, 80);
[CATransactioncommit];
```

6. 常用实例方法
```
- (void)addSublayer:(CALayer *)layer;                                         // 添加子图层
- (void)insertSublayer:(CALayer *)layer atIndex:(unsigned)idx;                // 在自己子图层数组中的第idx位置添加图层
- (void)insertSublayer:(CALayer *)layer below:(nullable CALayer *)sibling;    // 将图层layer添加在子图层sibling的下面
- (void)insertSublayer:(CALayer *)layer above:(nullable CALayer *)sibling;    // 将图层layer添加在子图层sibling的上面
- (void)replaceSublayer:(CALayer *)layer with:(CALayer *)layer2;              // 将图层layer替换layer2
- (void)removeFromSuperlayer;                                                 // 移除所有子图层

- (void)addAnimation:(CAAnimation )anim forKey:(nullable NSString )key;       // 添加某一属性动画
- (nullable NSArray< NSString > )animationKeys;                               // 获取所有动画的属性
- (nullable CAAnimation )animationForKey:(NSString )key;                      // 获取某一属性的动画
- (void)removeAnimationForKey:(NSString *)key;                                // 移除某一属性动画
- (void)removeAllAnimations;                                                  // 移除所有动画
```

7. 关于 UIView 与 CALayer 在搭建 UI 中的选择问题：
> UIView 相对于 CALayer 而言，不仅具有显示能力，同时也有事件处理能力。

### CALayer 的常见应用场景

* 阴影、描边

* 图片倒影、音乐控制条

* 粒子效果

### UIBezierPath 简要介绍

1. 系统本身提供了两套绘图的框架，即 UIBezierPath 和 Core Graphics。
2. 使用 UIBezierPath 可以创建基于矢量的路径，是对 Core Graphics 中 CGPathRef 数据类型的封装，所以使用起来比较简单。
3. 使用 UIBezierPath 可以定义简单的形状，如椭圆、矩形或者有多个直线和曲线段组成的形状等。所以基于矢量形状的路径，都可以用直线和曲线去创建。



* [iOS绘图－UIBezierPath的使用](http://blog.csdn.net/sinat_30898863/article/details/50823135)
* [CALayer](https://www.jianshu.com/p/09f4e36afd66)
* [CALayer的常用属性](https://www.cnblogs.com/chenweb/p/7108715.html)
* [放肆的使用UIBezierPath和CAShapeLayer画各种图形](https://www.jianshu.com/p/c5cbb5e05075)
* [图](http://upload-images.jianshu.io/upload_images/1361069-9396924d2f620514?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
