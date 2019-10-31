//
//  CollectionBannerLayout.m
//  CustomLibProject
//
//  Created by hnbwyh on 2019/10/21.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "CollectionBannerLayout.h"
#import "CLVBannerMacro.h"

@interface CollectionBannerLayout ()


@end


@implementation CollectionBannerLayout

-(void)prepareLayout {
    NSLog(@" \n \n 测试函数 1 prepareLayout \n\n ");
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.itemSize        = CGSizeMake(ScreenWidth - 2 * kItemLeftRightGap, CGRectGetHeight(self.collectionView.frame));
    self.minimumLineSpacing = kItemLineSpace;
    self.headerReferenceSize = CGSizeMake(kItemLineSpace, CGRectGetHeight(self.collectionView.frame));
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
     NSLog(@" \n \n 测试函数 2 shouldInvalidateLayoutForBoundsChange \n\n ");
    return YES;
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSLog(@" \n \n 测试函数 3 layoutAttributesForElementsInRect \n\n ");
    // 计算屏幕中心点相比于当前section所在位置
    NSArray *layoutAttrs    = [super layoutAttributesForElementsInRect:rect];
    CGFloat displayCenterX  = CGRectGetWidth(self.collectionView.frame)/2.0 + self.collectionView.contentOffset.x;
    for (NSInteger coun = 0; coun < layoutAttrs.count; coun ++) {
        UICollectionViewLayoutAttributes *ats = layoutAttrs[coun];
        CGFloat gap                           = ABS(ats.center.x - displayCenterX);
        CGFloat scale                         = 1 - gap/ScreenWidth/6.0;
        //NSLog(@"\n\n left,x,right,scale : %f - %f - %f - %f \n\n\n",left_value,ats.frame.origin.x,right_value,scale);
        ats.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return layoutAttrs;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    NSLog(@" \n \n 测试函数 4 targetContentOffsetForProposedContentOffset \n\n ");
    CGRect rect = CGRectMake(proposedContentOffset.x, 0.0,
                             ScreenWidth, CGRectGetHeight(self.collectionView.frame));
    NSArray *layoutAttrs = [self layoutAttributesForElementsInRect:rect];
    CGFloat displayCenterX  = CGRectGetWidth(self.collectionView.frame)/2.0 + proposedContentOffset.x;
    CGFloat min             = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *ats in layoutAttrs) {
        CGFloat tmp = ABS(ats.center.x - displayCenterX);
        if (tmp < ABS(min)) {
            min = ats.center.x - displayCenterX;
        }
    }
    return CGPointMake(proposedContentOffset.x + min,
                       proposedContentOffset.y);
}

@end
