##### Class
* TYTabPagerBar
> ToolBar 载体

* TYTabPagerBarCell
> ToolBar 上所需 cell

* TYTabPagerBarLayout
> ToolBar 样式管控类，通过该类可以自定义所需样式的 ToolBar

* TYTabPagerController
* TYTabPagerView
* TYPagerController
> Page 相对应的 Controller

* TYPagerView


* TYPagerViewLayout
> Page 相对应的 Controller 的 view 的管控类

>
```

```



##### Protocol
* TYTabPagerBarDataSource
> ToolBar 数据源代理方法

```

- (NSInteger)numberOfItemsInPagerTabBar;

- (UICollectionViewCell<TYTabPagerBarCellProtocol> *)pagerTabBar:(TYTabPagerBar *)pagerTabBar cellForItemAtIndex:(NSInteger)index;

```

* TYTabPagerBarDelegate
> ToolBar 配置及点击交互的回调。

```
// configure layout
- (void)pagerTabBar:(TYTabPagerBar *)pagerTabBar configureLayout:(TYTabPagerBarLayout *)layout;

// if cell wdith is not variable,you can set layout.cellWidth. otherwise ,you can implement this return cell width. cell width not contain cell edge
- (CGFloat)pagerTabBar:(TYTabPagerBar *)pagerTabBar widthForItemAtIndex:(NSInteger)index;

// did select cell item
- (void)pagerTabBar:(TYTabPagerBar *)pagerTabBar didSelectItemAtIndex:(NSInteger)index;

// transition frome cell to cell with animated
- (void)pagerTabBar:(TYTabPagerBar *)pagerTabBar transitionFromeCell:(UICollectionViewCell<TYTabPagerBarCellProtocol> * _Nullable)fromCell toCell:(UICollectionViewCell<TYTabPagerBarCellProtocol> * _Nullable)toCell animated:(BOOL)animated;

// transition frome cell to cell with progress
- (void)pagerTabBar:(TYTabPagerBar *)pagerTabBar transitionFromeCell:(UICollectionViewCell<TYTabPagerBarCellProtocol> * _Nullable)fromCell toCell:(UICollectionViewCell<TYTabPagerBarCellProtocol> * _Nullable)toCell progress:(CGFloat)progress;
```

* TYTabPagerViewDataSource
* TYTabPagerViewDelegate
* TYTabPagerControllerDataSource
* TYPagerControllerDataSource
> Page 相对应的 Controller 个数及 控制器对象。
```
// viewController's count in pagerController
- (NSInteger)numberOfControllersInPagerController;

/* 1.viewController at index in pagerController
   2.if prefetching is YES,the controller is preload,not display.
   3.if controller will display,will call viewWillAppear.
   4.you can register && dequeue controller, usage like tableView
 */
- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index prefetching:(BOOL)prefetching;
```
* TYPagerControllerDelegate
> Page 相对应的 Controller 在交互中所表现出得展示、隐藏及滚动等回调。
```

```

* TYTabPagerControllerDelegate
* TYTabPagerBarCellProtocol
* TYPagerViewLayoutDataSource
> Page 相对应的 Controller 的 view 处理
```
- (NSInteger)numberOfItemsInPagerViewLayout;

// if item is preload, prefetch will YES
- (id)pagerViewLayout:(TYPagerViewLayout *)pagerViewLayout itemForIndex:(NSInteger)index prefetching:(BOOL)prefetching;

// return item's view
- (UIView *)pagerViewLayout:(TYPagerViewLayout *)pagerViewLayout viewForItem:(id)item atIndex:(NSInteger)index;

// see TYPagerView&&TYPagerController, add&&remove item ,must implement scrollView addSubView item's view
- (void)pagerViewLayout:(TYPagerViewLayout *)pagerViewLayout addVisibleItem:(id)item atIndex:(NSInteger)index;
- (void)pagerViewLayout:(TYPagerViewLayout *)pagerViewLayout removeInVisibleItem:(id)item atIndex:(NSInteger)index;

// if have not viewController return nil.
- (UIViewController *)pagerViewLayout:(TYPagerViewLayout *)pagerViewLayout viewControllerForItem:(id)item atIndex:(NSInteger)index;

```

* TYPagerViewLayoutDelegate
> Page 相对应的 Controller 的 view 处理
```
// Transition animation customization

// if you implement ↓↓↓transitionFromIndex:toIndex:progress:,only tap change index will call this, you can set progressAnimateEnabel NO that not call progress method
- (void)pagerViewLayout:(TYPagerViewLayout *)pagerViewLayout transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex animated:(BOOL)animated;

// if you implement the method,also you need implement ↑↑↑transitionFromIndex:toIndex:animated:,deal with tap change index animate
- (void)pagerViewLayout:(TYPagerViewLayout *)pagerViewLayout transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress;

// ScrollViewDelegate

- (void)pagerViewLayoutDidScroll:(TYPagerViewLayout *)pagerViewLayout;
- (void)pagerViewLayoutWillBeginScrollToView:(TYPagerViewLayout *)pagerViewLayout animate:(BOOL)animate;
- (void)pagerViewLayoutDidEndScrollToView:(TYPagerViewLayout *)pagerViewLayout animate:(BOOL)animate;
- (void)pagerViewLayoutWillBeginDragging:(TYPagerViewLayout *)pagerViewLayout;
- (void)pagerViewLayoutDidEndDragging:(TYPagerViewLayout *)pagerViewLayout willDecelerate:(BOOL)decelerate;
- (void)pagerViewLayoutWillBeginDecelerating:(TYPagerViewLayout *)pagerViewLayout;
- (void)pagerViewLayoutDidEndDecelerating:(TYPagerViewLayout *)pagerViewLayout;
- (void)pagerViewLayoutDidEndScrollingAnimation:(TYPagerViewLayout *)pagerViewLayout;
```

* TYPagerViewDataSource
* TYPagerViewDelegate
