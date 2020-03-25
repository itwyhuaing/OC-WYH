//
//  HNBLinearLayout.m
//  FineHouse
//
//  Created by 蔡成汉 on 2018/8/31.
//  Copyright © 2018年 Hinabian. All rights reserved.
//

#import "HNBLinearLayout.h"

@interface HNBLinearLayout ()

// item number
@property (nonatomic, assign) NSUInteger itemCount;

// item size
@property (nonatomic, assign) CGSize itemSize;

@end

@implementation HNBLinearLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        _itemWidth = 134.0;
        _itemScale = 0.82;
        _itemAlpha = 0.5;
        _itemSpacing = 15.0;
        _fixOffset = 0.0;
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    _itemCount = [self.collectionView numberOfItemsInSection:0];
    _itemSize = CGSizeMake(_itemWidth, self.collectionView.bounds.size.height);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (CGSize)collectionViewContentSize {
    CGFloat width = self.itemSize.width * self.itemCount - (self.itemSize.width - self.itemSpacing);
    CGSize contentSize = CGSizeMake(width, self.collectionView.bounds.size.height);
    return contentSize;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.frame = CGRectMake(self.itemSize.width*indexPath.row, 0, self.itemSize.width, self.itemSize.height);
    return attributes;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    CGFloat currentCenterX = self.collectionView.contentOffset.x + self.itemSize.width*1.5;
    NSMutableArray* attributesArray = [NSMutableArray array];
    for (NSInteger i=0 ; i < [self.collectionView numberOfItemsInSection:0 ]; i++) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [attributesArray addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    for (UICollectionViewLayoutAttributes *attributes in attributesArray) {
        CGFloat distance = attributes.center.x - currentCenterX;
        CGFloat offsetX = 0;
        CGFloat scale = 1.0;
        CGFloat alpha = 1.0;
        NSInteger zIndex = 0;
        if (distance <= - self.itemSize.width && distance > - self.itemSize.width*2.0) {
            // 第一段：缩小、右移
            scale = self.itemScale;
            alpha = (distance < -(self.itemSize.width + 0.5*self.itemSpacing)) ? 0.0 : self.itemAlpha;
            CGFloat scaleOffsetX = self.itemSize.width/2.0*(1-scale);
            CGFloat autoOffsetX = MAX(distance + self.itemSize.width, -0.5*self.itemSpacing);
            offsetX = self.itemSize.width + distance + scaleOffsetX + autoOffsetX;
            zIndex = 1;
        }
        if (distance <=0 && distance > - self.itemSize.width) {
            // 第二段：左移、缩小+渐变
            CGFloat tpScale = ((1.0-self.itemScale)*distance + self.itemSize.width - self.itemScale*self.itemSpacing)/(self.itemSize.width - self.itemSpacing);
            scale = MIN( tpScale, 1.0);
            CGFloat tpAlpha = ((1-self.itemAlpha)*distance + (self.itemSize.width - self.itemAlpha*self.itemSpacing))/(self.itemSize.width - self.itemSpacing);
            alpha = MIN( tpAlpha, 1);
            CGFloat scaleOffsetX = self.itemSize.width/2.0*(1-scale);
            CGFloat autoOffsetX = (distance < - self.itemSpacing) ? distance + self.itemSpacing : 0.0;
            offsetX = self.itemSize.width - self.itemSpacing + scaleOffsetX + autoOffsetX;
            zIndex = 2;
        }
        if (distance <= self.itemSize.width && distance > 0) {
            // 第三段：左移、放大
            CGFloat tpScale = (self.itemScale - 1.0)/self.itemSize.width*distance + 1.0;
            scale = MIN(tpScale, 1.0);
            CGFloat scaleOffsetX = (self.itemSize.width/2.0*(1-scale) - self.itemSpacing)/self.itemSize.width*distance;
            offsetX = self.itemSize.width - self.itemSpacing + scaleOffsetX;
            zIndex = 3;
        }
        if (distance > self.itemSize.width) {
            // 第四段：左移
            scale = self.itemScale;
            CGFloat leftScaleX = self.itemSize.width/2.0*(1-self.itemScale) - self.itemSpacing;
            CGFloat rightScaleX = self.itemSize.width*(1-self.itemScale) - self.itemSpacing + (self.itemSize.width/2.0*(1-self.itemScale) - self.itemSpacing);
            CGFloat scaleOffsetX = (rightScaleX - leftScaleX)/self.itemSize.width*distance+(2*leftScaleX-rightScaleX);
            offsetX = self.itemSize.width - self.itemSpacing + scaleOffsetX;
            zIndex = 4;
        }
        attributes.zIndex = zIndex;
        attributes.alpha = alpha;
        CATransform3D scaleTransform = CATransform3DMakeScale(scale, scale, 1.0);
        CATransform3D translationTransform = CATransform3DMakeTranslation(-offsetX, 0, 0);
        CATransform3D transform = CATransform3DConcat(scaleTransform, translationTransform);
        attributes.transform3D = transform;
    }
    return attributesArray;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray *arrayAttrs = [self layoutAttributesForElementsInRect:targetRect];
    CGFloat centerX = proposedContentOffset.x + self.itemSpacing + self.itemSize.width + self.itemScale*self.itemSize.width/2.0 - 2.8/375.0*SCREEN_WIDTH - (self.itemSpacing - 15.0) - self.fixOffset;
    CGFloat offsetAdjustment = CGFLOAT_MAX;
    for (UICollectionViewLayoutAttributes *attr in arrayAttrs) {
        if (ABS(attr.center.x - centerX) < ABS(offsetAdjustment)) {
            offsetAdjustment = attr.center.x - centerX;
        }
    }
    proposedContentOffset.x = proposedContentOffset.x + offsetAdjustment;
    return proposedContentOffset;
}

- (void)setItemWidth:(CGFloat)itemWidth {
    _itemWidth = itemWidth;
    _itemSize = CGSizeMake(_itemWidth, self.collectionView.bounds.size.height);
    [self invalidateLayout];
}

- (void)setItemScale:(CGFloat)itemScale {
    _itemScale = itemScale;
    [self invalidateLayout];
}

- (void)setItemAlpha:(CGFloat)itemAlpha {
    _itemAlpha = itemAlpha;
    [self invalidateLayout];
}

- (void)setItemSpacing:(CGFloat)itemSpacing {
    _itemSpacing = itemSpacing;
    [self invalidateLayout];
}

- (void)setFixOffset:(CGFloat)fixOffset {
    _fixOffset = fixOffset;
    [self invalidateLayout];
}

@end
