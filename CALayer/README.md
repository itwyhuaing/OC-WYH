# CALayer

<!-- ### 简要介绍 -->

1. 在iOS系统中，你能看得见摸得着的东西基本上都是UIView，比如一个按钮、一个文本标签、一个文本输入框、一个图标等等，这些都是UIView。
2. 其实UIView之所以能显示在屏幕上，完全是因为它内部的一个层。
3. 在创建UIView对象时，UIView内部会自动创建一个层(即CALayer对象)，通过UIView的layer属性可以访问这个层。当UIView需要显示到屏幕上时，会调用drawRect:方法进行绘图，并且会将所有内容绘制在自己的层上，绘图完毕后，系统会将层拷贝到屏幕上，于是就完成了UIView的显示。
4. 由于 UIView 的显示依赖于内部的 CALayer 类属性，所以通过操作 CALayer 可以方便地调整显示细节，诸如：圆角，阴影，描边，还可以实现部分动画。
5. 

1. 系统本身提供了两套绘图的框架，即 UIBezierPath 和 Core Graphics。
2. 使用 UIBezierPath 可以创建基于矢量的路径，是对 Core Graphics 中 CGPathRef 数据类型的封装，所以使用起来比较简单。
3. 使用 UIBezierPath 可以定义简单的形状，如椭圆、矩形或者有多个直线和曲线段组成的形状等。所以基于矢量形状的路径，都可以用直线和曲线去创建。

<!-- ### 常用方法 -->

<!-- ### 使用场景与应用 -->

* [iOS绘图－UIBezierPath的使用](http://blog.csdn.net/sinat_30898863/article/details/50823135)
* [CALayer](https://www.jianshu.com/p/09f4e36afd66)
* [CALayer的常用属性](https://www.cnblogs.com/chenweb/p/7108715.html)
* [放肆的使用UIBezierPath和CAShapeLayer画各种图形](https://www.jianshu.com/p/c5cbb5e05075)
* [图](http://upload-images.jianshu.io/upload_images/1361069-9396924d2f620514?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
