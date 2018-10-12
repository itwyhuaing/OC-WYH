### UICollectionView 简要认识
UICollectionView 与 UICollectionViewLayout 联合使用可以实现很多效果。

UICollectionViewLayout是一个应该子类化的抽象基类，用来生成collectionview的布局信息。UICollectionViewFlowLayout 是官方提供的子类化的 UICollectionViewLayout，能满足绝大部分需求。

collectionview 内部有三种子视图 cell、追加视图(supplementary views)、装饰视图(decoration views) ；子视图的布局位置由相应的 UICollectionViewLayout 给出；并由 collectionview 展示出来。


### UICollectionViewLayoutAttributes
collectionView 上面子视图的相关设置都是由强大的 UICollectionViewLayout 来实现的，
其中 UICollectionViewLayoutAttributes 的属性及方法如下：


```

@property (nonatomic) CGRect frame;
@property (nonatomic) CGPoint center;
@property (nonatomic) CGSize size;
@property (nonatomic) CATransform3D transform3D; // 设置 3D 动画
@property (nonatomic) CGRect bounds NS_AVAILABLE_IOS(7_0);
@property (nonatomic) CGAffineTransform transform NS_AVAILABLE_IOS(7_0); // 设置缩放与旋转
@property (nonatomic) CGFloat alpha;
@property (nonatomic) NSInteger zIndex; // default is 0
@property (nonatomic, getter=isHidden) BOOL hidden; // As an optimization, UICollectionView might not create a view for items whose hidden attribute is YES
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, readonly) UICollectionElementCategory representedElementCategory;
@property (nonatomic, readonly, nullable) NSString *representedElementKind; // nil when representedElementCategory is UICollectionElementCategoryCell

// 初始化方法 - 分别对应三种子视图
+ (instancetype)layoutAttributesForCellWithIndexPath:(NSIndexPath *)indexPath;
+ (instancetype)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind withIndexPath:(NSIndexPath *)indexPath;
+ (instancetype)layoutAttributesForDecorationViewOfKind:(NSString *)decorationViewKind withIndexPath:(NSIndexPath *)indexPath;

```


### 自定义 UICollectionViewLayout 时比较常用的一些方法
1. collectionView 每次需要重新布局(初始、layout 被设置 invalidated 等)的时候会首先调用这个方法。Apple 建议我们可以在重写的该方法中为自定义布局做一些准备操作。例如，在 cell 比较少的情况下，可以在这个方法立即算好所有 cell 的布局并缓存，需要时直接取出使用。

```
- (void)prepareLayout;
```

2. Apple 要求这个方法必须重写，并且提供相应 rect 范围内的 cell 的所有布局的 UICollectionViewLayoutAttributes 。

```
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect;
```

3. 当 collectionView 的 bounds 变化的时候会调用该方法。倘若需要滚动过程中重新布局，那么我们需要返回 TRUE ，默认值为 FALSE 。
    3.1> 返回值为 TRUE 时，会将 collectionView 的 layout 设置为 invalidated ；将会使 collectionView 重新调用上面的 prepareLayout 方法重新获得布局。
    3.2> 屏幕旋转时，collectionView 的 bounds 也会调用该方法；若设置为 FALSE ，将不会达到屏幕适配的效果。
    3.3> 当 collectionView 执行一些操作如 delete insert reload 等时候，不会调用这个方法，而会直接调用 prepareLayout 方法重新获得布局 。

```
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds; // return YES to cause the collection view to requery the layout for geometry information
```

4. 需要设置 collectionView 的滚动范围 collectionViewContentSize 。自定义 collectionViewLayout 的时候，必须重写这个方法，并且返回正确的滚动范围，collectionView 才能正常滚动。

```
@property(nonatomic, readonly) CGSize collectionViewContentSize;
```

5. Apple 建议重写, 返回正确的自定义对象的布局因为有时候当 collectionView 执行一些操作(delete insert reload)等系统会调用这些方法获取布局, 如果没有重写, 可能发生意想不到的效果。

```
// 所有元素（比如 cell、补充控件、装饰控件）的布局属性: 返回 UICollectionViewLayoutAttributes 类型的数组，UICollectionViewLayoutAttributes 对象包含 cell 或 view 的布局信息。子类必须重载该方法，并返回该区域内所有元素的布局信息，包括cell,追加视图和装饰视图
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect;
// 自定义cell布局的时候重写
- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath;
// 自定义SupplementaryView的时候重写
- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath;
// 自定义DecorationView的时候重写
- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString*)elementKind atIndexPath:(NSIndexPath *)indexPath;
```

6. 当 collectionView 将停止滚动的时候调用，可以重写来实现，collectionView 停在指定的位置 。

```
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity; // return a point at which to rest after scrolling - for layouts that want snap-to-point scrolling behavior
```


