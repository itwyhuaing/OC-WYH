//
//  LineLayout.m
//  CollectionViewDemo
//
//  Created by hnbwyh on 2018/10/9.
//  Copyright © 2018年 JiXia. All rights reserved.
//

#import "LineLayout.h"

@implementation LineLayout

/**
 * 当 collectionView 的显示范围发生改变的时候，是否需要重新刷新布局
 * 一旦重新刷新布局，就会重新调用下面的方法：
 1. prepareLayout
 2. layoutAttributesForElementsInRect: 方法
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    NSLog(@" \n \n 测试函数 1 - shouldInvalidateLayoutForBoundsChange \n\n ");
    return YES;
}

/**
 *  用来做布局的初始化操作（不建议在init方法中进行布局的初始化操作）
 作用：在这个方法中做一些初始化操作
 注意：一定要调用[super prepareLayout]
 */
- (void)prepareLayout {
    [super prepareLayout];
    
    NSLog(@" \n \n 测试函数 2 - prepareLayout \n\n ");
    self.scrollDirection        = UICollectionViewScrollDirectionHorizontal;
    self.itemSize               = CGSizeMake(self.collectionView.bounds.size.height * 0.5, self.collectionView.bounds.size.height * 0.5);
    
}


/**
 UICollectionViewLayoutAttributes *attrs;
 1.一个cell对应一个UICollectionViewLayoutAttributes对象
 2.UICollectionViewLayoutAttributes对象决定了cell的frame
 这个方法的返回值是一个数组（数组里面存放着rect范围内所有元素的布局属性）
 * 这个方法的返回值决定了rect范围内所有元素的排布（frame）
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {

    NSLog(@" \n \n 测试函数 3 - layoutAttributesForElementsInRect \n\n ");
    
    NSArray *layoutAttrs = [super layoutAttributesForElementsInRect:rect];
    //collectionView 中心点的位置
    CGFloat collectionViewCenterX = self.collectionView.bounds.size.width * 0.5 + self.collectionView.contentOffset.x;
    for (UICollectionViewLayoutAttributes *attrs in layoutAttrs) {

        // item 距离 collectionView 中点的位置距离
        CGFloat delta = ABS(collectionViewCenterX - attrs.center.x);
        
        CGFloat scale  = 1 - delta / self.collectionView.bounds.size.width;
        attrs.transform = CGAffineTransformMakeScale(scale, scale);
        
    }

    return layoutAttrs;
}


/**
 重写 targetContentOffsetForProposedContentOffset:withScrollingVelocity: 方法
 作用：返回值决定了 collectionView 停止滚动时最终的偏移量（contentOffset）
 参数：
 - proposedContentOffset：原本情况下， collectionView 停止滚动时最终的偏移量
 - velocity：滚动速率，通过这个参数可以了解滚动的方向
 */
//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
//
//    NSLog(@" \n \n 测试函数 4 - targetContentOffsetForProposedContentOffset \n\n ");
//    return proposedContentOffset;
//
//    // 目的的位置，然后计算与中心点的距离 最小的那一个就 = 中心点的位置。
//    NSArray *layoutAttrs = [self layoutAttributesForElementsInRect:CGRectMake(proposedContentOffset.x, 0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height)];
//
//    CGFloat centerX = self.collectionView.bounds.size.width * 0.5 + proposedContentOffset.x;
//    CGFloat minDelta = MAXFLOAT;
//    for (UICollectionViewLayoutAttributes *attrs in layoutAttrs) {
////        if (!CGRectIntersectsRect(CGRectMake(proposedContentOffset.x, proposedContentOffset.y, self.collectionView.frame.size.width, self.collectionView.frame.size.height), attrs.frame)){
////            continue;
////        }
//        CGFloat delta = ABS(attrs.center.x - centerX);
//        if (delta < ABS(minDelta)) {
//            // 计算出距离中心点最近的 item 与 中心点间的间距
//            minDelta = attrs.center.x - centerX;
//        }
//    }
//
//    // 最近 item 的中心点距离加上偏移
//    return CGPointMake(proposedContentOffset.x + minDelta, proposedContentOffset.y);
//}

@end
