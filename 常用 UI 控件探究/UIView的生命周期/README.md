# UIView


#### UIView 布局相关

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


#### UIView 生命周期

> 视图添加子视图时调用

```
- (void)didAddSubview:(UIView *)subview;
```

> 子视图即将从本视图移除时调用

```
- (void)willRemoveSubview:(UIView *)subview;
```


> 当本视图即将加入父视图时 或 当本视图即将从父视图移除时调用

```
- (void)willMoveToSuperview:(nullable UIView *)newSuperview;
```


> 当本视图加入父视图时 或 当本视图从父视图移除时调用

```
- (void)didMoveToSuperview;
```


> 当本视图即将加入窗口UIWindow时 或 当本视图即将从窗口UIWindow移除时调用

```
- (void)willMoveToWindow:(nullable UIWindow *)newWindow;
```


> 当本视图加入窗口UIWindow时 或 当本视图从窗口UIWindow移除时调用

```
- (void)didMoveToWindow;
```


> 代码示例

```

// ViewLifeCycleVC.m

@implementation ViewLifeCycleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    ViewLifeCycle *v = [ViewLifeCycle new];
    [v setFrame:CGRectMake(100, 100, 200, 200)];
    v.backgroundColor = [UIColor redColor];
    NSLog(@"\n ====== 添加 ====== \n");
    [self.view addSubview:v];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"\n ====== 移除 ====== \n");
        [v removeFromSuperview];
    });
}

@end


// ViewLifeCycle.m

@implementation ViewLifeCycle

-(void)willMoveToSuperview:(UIView *)newSuperview {
    NSLog(@" \n willMoveToSuperview ： %@ \n ",newSuperview);
}

-(void)didMoveToSuperview {
    NSLog(@" \n didMoveToSuperview  \n ");
}

-(void)didAddSubview:(UIView *)subview {
    NSLog(@" \n didAddSubview ： %@ \n ",subview);
}

-(void)willMoveToWindow:(UIWindow *)newWindow {
    NSLog(@" \n willMoveToWindow ： %@ \n ",newWindow);
}

-(void)didMoveToWindow {
    NSLog(@" \n didMoveToWindow  \n ");
}

@end


// 打印结果简要信息:

 ====== 添加 ======

 willMoveToSuperview ： <UIView: 0x7f9fd0c21cd0; frame = (0 0; 414 896); autoresize = W+H; layer = <CALayer: 0x6000019c1c40>>

 didMoveToSuperview

 willMoveToWindow ： <UIWindow: 0x7f9fd0c0edb0; frame = (0 0; 414 896); gestureRecognizers = <NSArray: 0x6000017c9590>; layer = <UIWindowLayer: 0x6000019d87a0>>

 didMoveToWindow

 ====== 移除 ======

 willMoveToSuperview ： (null)

 willMoveToWindow ： (null)

 didMoveToWindow

 didMoveToSuperview

```
