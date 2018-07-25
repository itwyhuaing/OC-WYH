# CALayer 与 UIBezierPath 基础及常见应用

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
![3](https://github.com/itwyhuaing/OC-WYH/blob/master/CALayer/image/3.png)

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

### UIBezierPath 简要介绍

1. 系统本身提供了两套绘图的框架，即 UIBezierPath 和 Core Graphics。
2. 使用 UIBezierPath 可以创建基于矢量的路径，是对 Core Graphics 中 CGPathRef 数据类型的封装，所以使用起来比较简单。
3. 使用 UIBezierPath 可以定义简单的形状，如椭圆、矩形或者有多个直线和曲线段组成的形状等。所以基于矢量形状的路径，都可以用直线和曲线去创建。
4. 属性

```
@property(readonly,getter=isEmpty) BOOL empty; // 该值指示路径是否有任何有效的元素
@property(nonatomic,readonly) CGRect bounds;  // 路径包括的矩形
@property(nonatomic,readonly) CGPoint currentPoint; // 图形路径中的当前点
- (BOOL)containsPoint:(CGPoint)point; // 接收器是否包含指定的点

// Drawing properties
@property(nonatomic) CGFloat lineWidth; // 线宽
@property(nonatomic) CGLineCap lineCapStyle; // 端点类型
typedef CF_ENUM(int32_t, CGLineCap) {
    kCGLineCapButt, // 默认的
    kCGLineCapRound, // 轻微圆角
    kCGLineCapSquare // 正方形
};

@property(nonatomic) CGLineJoin lineJoinStyle; // 连接类型
typedef CF_ENUM(int32_t, CGLineJoin) {
    kCGLineJoinMiter, // 默认的表示斜接
    kCGLineJoinRound, // 圆滑衔接
    kCGLineJoinBevel  // 斜角连接
};

// 最大斜接长度   斜接长度指的是在两条线交汇处内角和外角之间的距离 ， 可参考如下示意图
// 只有lineJoin属性为kCALineJoinMiter时miterLimit才有效
// 边角的角度越小，斜接长度就会越大。为了避免斜接长度过长，我们可以使用 miterLimit属性。如果斜接长度超过 miterLimit的值，边角会以 lineJoin的 "bevel"即kCALineJoinBevel类型来显示
@property(nonatomic) CGFloat miterLimit;

@property(nonatomic) CGFloat flatness; // 确定弯曲路径短的绘制精度的因素
@property(nonatomic) BOOL usesEvenOddFillRule; // 个bool值指定even-odd规则是否在path可用 ,默认 NO
```

5. 实例方法

```
- (instancetype)bezierPath;                                                                // 适用的范围比较广，适用于画出任意曲线
- (instancetype)bezierPathWithRect:(CGRect)rect;                                           // 依据 Rect 参数画曲线
+ (instancetype)bezierPathWithOvalInRect:(CGRect)rect;                                     // 依据 Rect 参数画内切的曲线即画圆或者椭圆
+ (instancetype)bezierPathWithRoundedRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius; // 依据参数画带有圆角的矩形，第一个参数是矩形，第二个参数是圆角大小
+ (instancetype)bezierPathWithCGPath:(CGPathRef)CGPath;

// 依据参数画带有圆角的矩形，第一个参数是矩形，第二个参数是圆角大小，第三个参数指定把矩形某一个角画成圆角
+ (instancetype)bezierPathWithRoundedRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;

// 画弧线，参数依次为：弧线中心点的坐标 、弧线所在圆的半径 、弧线开始的角度 、弧线结束的角度 、是否顺时针画弧线（YES表示顺时针 NO表示逆时针）
// 关于角度方向问题可参见下图
+ (instancetype)bezierPathWithArcCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise;


- (void)moveToPoint:(CGPoint)point; // 指定绘制起点
- (void)addLineToPoint:(CGPoint)point; // 绘制直线条中指定(起始点除外)下一点
- (void)addQuadCurveToPoint:(CGPoint)endPoint controlPoint:(CGPoint)controlPoint; // 绘制二次贝塞尔曲线
- (void)addCurveToPoint:(CGPoint)endPoint controlPoint1:(CGPoint)controlPoint1 controlPoint2:(CGPoint)controlPoint2; // 绘制三次贝塞尔曲线

// 画弧线，参数依次为：弧线中心点的坐标 、弧线所在圆的半径 、弧线开始的角度 、弧线结束的角度 、是否顺时针画弧线（YES表示顺时针 NO表示逆时针）
// 关于角度方向问题可参见下图
- (void)addArcWithCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise;
- (void)closePath; // 闭环，返回起点
- (void)removeAllPoints; // 移除所有坐标点
- (void)appendPath:(UIBezierPath *)bezierPath; // Appending paths
- (UIBezierPath *)bezierPathByReversingPath; // 创建并返回一个与当前路径相反的新的贝塞尔路径对象
- (void)applyTransform:(CGAffineTransform)transform; // 用指定的仿射变换矩阵变换路径的所有点


// 设置线型，可设置成虚线
- (void)setLineDash:(nullable const CGFloat *)pattern count:(NSInteger)count phase:(CGFloat)phase;

// 检索线型
- (void)getLineDash:(nullable CGFloat *)pattern count:(nullable NSInteger *)count phase:(nullable CGFloat *)phase;

// 填充颜色
- (void)fill;

// 利用当前绘图属性沿着接收器的路径绘制
- (void)stroke;

// 用指定的混合模式和透明度值来描绘受接收路径所包围的区域
- (void)fillWithBlendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha;

// 使用指定的混合模式和透明度值沿着接收器路径，绘制一行
- (void)strokeWithBlendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha;

// 剪切被接收者路径包围的区域该路径是带有剪切路径的当前绘图上下文，使得其成为我们当前的剪切路径
- (void)addClip;

```

圆曲线绘制，关于方向与角度问题示意图:

![2](https://github.com/itwyhuaing/OC-WYH/blob/master/CALayer/image/2.png)


最大斜接长度 miterLimit 示意图：

![1](https://github.com/itwyhuaing/OC-WYH/blob/master/CALayer/image/1.png)


> 关于曲线绘制示例代码可查看 CALayerDemo ;

> 其中 FirstVC 展示利用 UIBezierPath 提供的生成实例对象的 API 直接绘制直线、弧线等。

> SecondVC 展示 moveToPoint 、addLineToPoint、addQuadCurveToPoint 等绘制。

> ThirdVC 展示二次与三次贝塞尔曲线的绘制。

> FourthVC 展示圆弧绘制。

6. UIBezierPath 功能比较单一，主要用于指定曲线路径，但与 CAShapeLayer (CALayer子类) 相结合，便可以实现绘制、动画等效果。

### UIBezierPath 与 CALayer 的应用
* LayerPathVC 主要展示 CAShapeLayer 与 UIBezierPath 联合使用绘制镂空效果

> 1. UIView 之所以可以展示不同的形状，在于其根 layer 上的 mask(CALayer类型) 属性是可以修改的。

> 2. 利用 UIBezierPath 可以绘制出任意图形，但需注意的是曲线添加必须是反向的。

> 3. 设法将绘制的图形借助 CAShapeLayer 展示出来。

> 4. 具体代码可查看 LayerPathVC

* CALayerDemo 中常见应用示例：卡片效果、镂空效果、线条绘制 等持续更新 。。。
* [RWGuidanceView - 镂空效果，用于新功能提醒](https://github.com/itwyhuaing/RWGuidanceView)
* [YHChartView - 坐标系中曲线绘制](https://github.com/itwyhuaing/OC-WYH/tree/master/YHCompoent/YHChartView)
