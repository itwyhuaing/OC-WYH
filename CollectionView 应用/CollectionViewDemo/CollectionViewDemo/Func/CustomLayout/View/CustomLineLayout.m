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
//- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect;

/**
 * 当collectionView的显示范围发生改变的时候，是否需要重新刷新布局
 * 一旦重新刷新布局，就会重新调用下面的方法：
 1.prepareLayout
 2.layoutAttributesForElementsInRect:方法
 */
//- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds;


/**
 重写 targetContentOffsetForProposedContentOffset:withScrollingVelocity: 方法
 作用：返回值决定了 collectionView 停止滚动时最终的偏移量（contentOffset）
 参数：
 - proposedContentOffset：原本情况下， collectionView 停止滚动时最终的偏移量
 - velocity：滚动速率，通过这个参数可以了解滚动的方向
 */
//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity;

/**
 *  用来做布局的初始化操作（不建议在init方法中进行布局的初始化操作）
 作用：在这个方法中做一些初始化操作
 注意：一定要调用[super prepareLayout]
 */
//- (void)prepareLayout;


-(void)prepareLayout{
    [super prepareLayout];
    //NSLog(@"\n 测试 ======= > prepareLayout \n");
}


-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSLog(@"\n 测试 ======= > layoutAttributesForElementsInRect \n");
    itemCount       = [self.collectionView numberOfItemsInSection:0];
    attrs           = [NSMutableArray new];
    for (NSInteger cou = 0; cou < itemCount; cou ++) {
        UICollectionViewLayoutAttributes *atr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:cou inSection:0]];
        [attrs addObject:atr];
        NSLog(@" \n %f \n ",atr.center.x);
    }

/*
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
        
        // 尺寸方式
        // 尺寸
        size.height     =ITEM_SIZE_H - (yGap * 2 * (itemCount-1-cou));
        size.width      =ITEM_SIZE_W - (xGap * (itemCount-1-cou));
        atr.size        = size;
        
        // 中心点
        if (cou == itemCount - 1) {
            center.x        = ITEM_SIZE_W/2.0 - center_xoffset;
            atr.zIndex      = 3;
            //            NSLog(@"\n测试点3:%f\n",center.x);
        }else if (cou == itemCount - 2){
            center.x        = ITEM_SIZE_W/2.0 - center_xoffset + xGap * 1 + 10;
            atr.zIndex      = 2;
            //            NSLog(@"\n测试点2:%f\n",center.x);
        }else if (cou == itemCount - 3){
            center.x        = ITEM_SIZE_W/2.0 - center_xoffset + xGap * 2 + 20;
            atr.zIndex      = 1;
            //            NSLog(@"\n测试点1:%f\n",center.x);
        }else if (cou == itemCount - 4){
            center.x        = ITEM_SIZE_W/2.0 - center_xoffset + xGap * 3 + 30;
            atr.zIndex      = 0;
            //            NSLog(@"\n测试点0:%f\n",center.x);
        }
        atr.center      = center;
        
        
        [attrs addObject:atr];
        
*/
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
//    }
    
    return attrs;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    //NSLog(@"\n 测试 ======= > targetContentOffsetForProposedContentOffset \n");
    if (velocity.x > 0) { // 向左
        NSLog(@"\n 测试点 - 向左:%f - %f \n",velocity.x,proposedContentOffset.x);
    } else {
        NSLog(@"\n 测试点 - 向右 - 展示最后一个:%f - %f \n",velocity.x,proposedContentOffset.x);
    }
    return CGPointZero;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    //NSLog(@"\n 测试 ======= > shouldInvalidateLayoutForBoundsChange \n");
    return YES;
}

@end
