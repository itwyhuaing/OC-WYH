//
//  CustomLineLayout.m
//  CollectionViewDemo
//
//  Created by hnbwyh on 2018/10/24.
//  Copyright © 2018年 JiXia. All rights reserved.
//

#import "CustomLineLayout.h"

@interface CustomLineLayout ()
{
    NSMutableArray<UICollectionViewLayoutAttributes *> *attrs;
    NSInteger                                          itemCount;
}


@end

@implementation CustomLineLayout


/**
 UICollectionViewLayoutAttributes *attrs;
 1. 一个 cell 对应一个 UICollectionViewLayoutAttributes 对象
 2. UICollectionViewLayoutAttributes 对象决定了 cell 的 frame
 这个方法的返回值是一个数组（数组里面存放着rect范围内所有元素的布局属性）
 * 这个方法的返回值决定了rect范围内所有元素的排布（frame）
 */
//- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
//    NSArray *layoutAttrs = [super layoutAttributesForElementsInRect:rect];
//    // collectionView 中心点的位置
//    CGFloat collectionViewCenterX = self.collectionView.bounds.size.width * 0.5 + self.collectionView.contentOffset.x;
//    //collectionViewCenterX = self.collectionView.bounds.size.height * 0.25;
//    NSLog(@"\n\n测试点1: %f - %f - %f \n\n",self.collectionView.bounds.size.width,self.collectionView.contentOffset.x,collectionViewCenterX);
//    for (UICollectionViewLayoutAttributes *attrs in layoutAttrs) {
//
//        // item 距离 collectionView 中点的位置距离
//        CGFloat delta = ABS(collectionViewCenterX - attrs.center.x);
//
//        CGFloat scale  = 1 - delta / self.collectionView.bounds.size.width;
//        attrs.transform = CGAffineTransformMakeScale(scale, scale);
//    }
//
//    return layoutAttrs;
//}

/**
 * 当collectionView的显示范围发生改变的时候，是否需要重新刷新布局
 * 一旦重新刷新布局，就会重新调用下面的方法：
 1.prepareLayout
 2.layoutAttributesForElementsInRect:方法
 */
//- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
//    //NSLog(@" \n\n%s\n\n ",__FUNCTION__);
//    return YES;
//}


/**
 重写 targetContentOffsetForProposedContentOffset:withScrollingVelocity: 方法
 作用：返回值决定了 collectionView 停止滚动时最终的偏移量（contentOffset）
 参数：
 - proposedContentOffset：原本情况下， collectionView 停止滚动时最终的偏移量
 - velocity：滚动速率，通过这个参数可以了解滚动的方向
 */
//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
//
//    // 目的的位置，然后计算与中心点的距离 最小的那一个就 = 中心点的位置。
//    NSArray *layoutAttrs = [self layoutAttributesForElementsInRect:CGRectMake(proposedContentOffset.x, 0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height)];
//
//    NSLog(@"\n\n测试点2： %f - %f \n",proposedContentOffset.x,proposedContentOffset.y);
//
//    CGFloat centerX = self.collectionView.bounds.size.width * 0.5 + proposedContentOffset.x;
//    CGFloat minDelta = MAXFLOAT;
//    for (UICollectionViewLayoutAttributes *attrs in layoutAttrs) {
//        if (!CGRectIntersectsRect(CGRectMake(proposedContentOffset.x, proposedContentOffset.y, self.collectionView.frame.size.width, self.collectionView.frame.size.height), attrs.frame)){
//            continue;
//        }
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

/**
 *  用来做布局的初始化操作（不建议在init方法中进行布局的初始化操作）
 作用：在这个方法中做一些初始化操作
 注意：一定要调用[super prepareLayout]
 */
//- (void)prepareLayout {
//
//    [super prepareLayout];
//    self.scrollDirection        = UICollectionViewScrollDirectionHorizontal;
//    self.itemSize               = CGSizeMake(self.collectionView.bounds.size.height * 0.5, self.collectionView.bounds.size.height * 0.5);
//}


-(void)prepareLayout{
    [super prepareLayout];
    itemCount       = [self.collectionView numberOfItemsInSection:0];
    attrs           = [NSMutableArray new];
    
    
//    for (NSInteger cou = 0; cou < itemCount; cou ++) {
//
//        UICollectionViewLayoutAttributes *atr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:cou inSection:0]];
//        atr.size        = CGSizeMake(ITEM_SIZE_W, ITEM_SIZE_H);
//        CGFloat x       = 20;
//        CGFloat y       = 00;
//        atr.center      = CGPointMake(center.x + x * cou, center.y + y * cou);
//        CGFloat sx      = 1-0.1*cou;
//        CGFloat sy      = 1-0.1*cou;
//        atr.transform   = CGAffineTransformMakeScale(sx,sy);
//        [attrs addObject:atr];
//    }
    
//    CGPoint center  = CGPointMake(ITEM_SIZE_W/2.0, self.collectionView.frame.size.height/2 - ITEM_SIZE_H/2.0); // self.collectionView.frame.size.height/2);
//    for (NSInteger cou = 0; cou < itemCount; cou ++) {
//
//        UICollectionViewLayoutAttributes *atr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:cou inSection:0]];
//        atr.size        = CGSizeMake(ITEM_SIZE_W, ITEM_SIZE_H);
//        CGFloat x       = 60;
//        CGFloat y       = 00;
//        atr.center      = CGPointMake(center.x + x * cou, center.y + y * cou);
//        CGFloat sx      = 1-0.1*cou;
//        CGFloat sy      = 1-0.1*cou;
//        atr.transform   = CGAffineTransformMakeScale(sx,sy);
//        [attrs addObject:atr];
//    }
    
    // 可调试参数
    CGFloat yGap                = 8.0;
    CGFloat center_xoffset      = 14.0;
    CGFloat center_y            = 32;
    // 计算参数
    CGSize size     = CGSizeMake(ITEM_SIZE_W, ITEM_SIZE_H);
    CGPoint center  = CGPointMake(ITEM_SIZE_W/2.0 - center_xoffset, center_y);
    CGFloat allGapW = SCREEN_WIDTH - ITEM_SIZE_W;
    CGFloat xGap    = allGapW / (itemCount - 1);

    for (NSInteger cou = itemCount-1; cou >= 0; cou --) {
        
        UICollectionViewLayoutAttributes *atr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:cou inSection:0]];

/**<尺寸方式>*/
// 尺寸
        size.height     =ITEM_SIZE_H - (yGap * 2 * (itemCount-1-cou));
        size.width      =ITEM_SIZE_W - (xGap * (itemCount-1-cou));
        atr.size        = size;

// 中心点
        if (cou == itemCount - 1) {
            center.x        = ITEM_SIZE_W/2.0 - center_xoffset;
            NSLog(@"\n测试点3:%f\n",center.x);
        }else if (cou == itemCount - 2){
            center.x        = ITEM_SIZE_W/2.0 - center_xoffset + xGap * 1 + 10;
            NSLog(@"\n测试点2:%f\n",center.x);
        }else if (cou == itemCount - 3){
            center.x        = ITEM_SIZE_W/2.0 - center_xoffset + xGap * 2 + 20;
            NSLog(@"\n测试点1:%f\n",center.x);
        }else if (cou == itemCount - 4){
            center.x        = ITEM_SIZE_W/2.0 - center_xoffset + xGap * 3 + 30;
            NSLog(@"\n测试点0:%f\n",center.x);
        }
        atr.center      = center;
        [attrs addObject:atr];
        
        
/**<缩放方式>*/
//        atr.size        = size;
//
//        if (cou == 3) {
//            atr.transform   = CGAffineTransformMakeScale(1,1);
//        }else if (cou == 2){
//            atr.transform   = CGAffineTransformMakeScale(0.95,0.95);
//            center.x        += 20;
//        }else if (cou == 1){
//            atr.transform   = CGAffineTransformMakeScale(0.85,0.85);
//            center.x        += 30;
//        }else if (cou == 0){
//            atr.transform   = CGAffineTransformMakeScale(0.70,0.70);
//            center.x        += 40;
//        }
//        atr.center      = center;
//        [attrs addObject:atr];
        
        
    }
    
}


-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return attrs;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    NSLog(@"\n 测试点:%f \n",velocity.x);
    return CGPointZero;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    NSLog(@" \n 测试点 : BOOL \n ");
    return YES;
}

@end
