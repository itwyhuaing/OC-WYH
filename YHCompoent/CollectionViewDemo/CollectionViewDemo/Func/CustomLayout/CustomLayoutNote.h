### UICollectionView 简要认识
UICollectionView 与 UICollectionViewLayout 联合使用可以实现很多效果。

UICollectionViewLayout是一个应该子类化的抽象基类，用来生成collectionview的布局信息。UICollectionViewFlowLayout 是官方提供的子类化的 UICollectionViewLayout，能满足绝大部分需求。

collectionview 内部有三种子视图 cell、追加视图(supplementary views)、装饰视图(decoration views) ；子视图的布局位置由相应的 UICollectionViewLayout 给出；并由 collectionview 展示出来
