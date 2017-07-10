###  ASDK 学习

#### 部分翻译
* 在 AsyncDisplayKit 的所有 layoutSpecs 中， ASStackLayoutSpec 是最有用也是功能最强大的一个类。
ASStackLayoutSpec 运用 flexbox 算法来确定内部子控件的位置及尺寸。其中，flexbox 可以很方便的实现在不同尺寸屏幕上的适配。在一个堆栈布局中，开发者可以指定内部子控件的水平方向布局或垂直方向布局。一个布局堆栈可以嵌套在另一个布局堆栈当中，这样一来开发者局可以实现几乎所有任何一个复杂或简单的布局。

* ASStackLayoutSpec 除了拥有 <ASLayoutElement> 的属性之外，还有其他 7 个属性。

1.  direction : 指定内部子控件的布局方向。在该值被设置 horizontalAlignment and verticalAlignment 时，内部子控件的相对位置及尺寸将做相应的调整。

2.  spacing : 子控件间的间距。

3. horizontalAlignment : 指定子控件为水平布局方向。因为子控件对齐及布局依赖于这个属性，所以需要优先设置。

4. verticalAlignment : 与 horizontalAlignment 相似，只是方向为垂直方向。

5. justifyContent : 子控件的间距。

6. alignItems : 子控件在侧轴上的布局方向。

7. flexWrap : 子控件单行或多行布局。默认单行布局。

8. alignContent : 如果多行的话，子控件在侧轴的布局。
