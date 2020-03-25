* 在iOS7之后，苹果推出了手势滑动返回功能，也就是从屏幕左侧向右滑动可返回上一个界面。大大提高了APP在大屏手机和iPad上的操作体验，场景切换更加流畅。
* 常见的问题有：

> 1.右滑手势失效

> 2.右滑手势与其他手势冲突

> 3.右滑手势导致应用 Crash

> 4.右滑手势的开启与关闭

* 了解一下 navigationItem 的几个属性
```
hidesBackButton                   - 是否隐藏原生返回按钮,当前控制器设置，当前控制器有效
backBarButtonItem                 - 当前控制器设置，下一级控制器生效
leftBarButtonItem                 - 当前控制器设置，当前控制器生效
leftBarButtonItems                - 当前控制器设置，当前控制器生效
leftItemsSupplementBackButton     - 在leftBarButtonItem设置之后，再设置该属性可以控制backBarButtonItem的被覆盖状态
```
> 系统原生的右滑返回是OK的，但如果设置了 hidesBackButton 、 backBarButtonItem 、 leftBarButtonItem 、 leftBarButtonItems 几个属性，原生的右滑返回手势就会失效。

* 关于解决方式网上给了很多，但涉及到具体项目觉得使用拦截手势代理回调的方式最为合理。

> 其一，可以很便捷地解决右滑失效、手势冲突、右滑 Crash 等问题

> 其二，返回按钮你可以随意自定义

> 其三，在混合式开发中，可以在拦截的代理回调中给 web 跳转也增加逐级返回体验

* 关键代码如下 ,详见 Demo
```

<UIGestureRecognizerDelegate>
self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
self.navigationController.interactivePopGestureRecognizer.enabled  = TRUE;

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    DLog(@" gestureRecognizerShouldBegin : %@ \n %@",gestureRecognizer,[gestureRecognizer class]);
    BOOL rlt = FALSE;
    // 手势
    if(gestureRecognizer == self.navigationController.interactivePopGestureRecognizer){
        // 控制器堆栈
        if(self.navigationController.viewControllers.count >= 2){
            rlt = TRUE;
        }
    }
    return rlt;
}

```
> 其中可以将该部分代码放在积累控制器设置或自定义导航栏控制器中设置；然后在不需要的控制器中使用 self.navigationController.interactivePopGestureRecognizer.enabled  = FALSE; 单独关闭即可
