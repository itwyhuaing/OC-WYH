
//@interface UICollectionViewFlowLayout : UICollectionViewLayout

// 行与行之间最小行间距，这里的 “行” 其方向与滚动方向垂直
@property (nonatomic) CGFloat minimumLineSpacing;
// 同一行的cell中互相之间的最小间隔，设置这个值之后，那么cell与cell之间至少为这个值
@property (nonatomic) CGFloat minimumInteritemSpacing;
//每个cell统一尺寸
@property (nonatomic) CGSize itemSize;
//预估高度
@property (nonatomic) CGSize estimatedItemSize;
//滑动反向，默认滑动方向是垂直方向滑动
@property (nonatomic) UICollectionViewScrollDirection scrollDirection;
//每一组头视图的尺寸。如果是垂直方向滑动，则只有高起作用；如果是水平方向滑动，则只有宽起作用。
@property (nonatomic) CGSize headerReferenceSize;
//每一组尾部视图的尺寸。如果是垂直方向滑动，则只有高起作用；如果是水平方向滑动，则只有宽起作用。
@property (nonatomic) CGSize footerReferenceSize;
//每一组的内容缩进
@property (nonatomic) UIEdgeInsets sectionInset;

/**
 The reference boundary that the section insets will be defined as relative to. Defaults to `.fromContentInset`.
 NOTE: Content inset will always be respected at a minimum. For example, if the sectionInsetReference equals `.fromSafeArea`, but the adjusted content inset is greater that the combination of the safe area and section insets, then section content will be aligned with the content inset instead.
 */
@property (nonatomic) UICollectionViewFlowLayoutSectionInsetReference sectionInsetReference;

// 悬浮效果设置 - TRUE 有悬浮，FALSE 无悬浮
@property (nonatomic) BOOL sectionHeadersPinToVisibleBounds;
@property (nonatomic) BOOL sectionFootersPinToVisibleBounds;

@end

