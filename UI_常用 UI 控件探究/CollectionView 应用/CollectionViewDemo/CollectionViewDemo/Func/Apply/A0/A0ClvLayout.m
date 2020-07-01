//
//  A0ClvLayout.m
//  CollectionViewDemo
//
//  Created by hnbwyh on 2020/6/24.
//  Copyright © 2020 JiXia. All rights reserved.
// 

#import "A0ClvLayout.h"

@interface A0ClvLayout ()

@property (nonatomic,assign) NSInteger itemCount;

@property (nonatomic,assign) CGFloat   itemWidth;

@property (nonatomic,assign) CGFloat   itemHieght;

@property (nonatomic,assign) CGFloat   itemGap;

@property (nonatomic,strong) NSArray<UICollectionViewLayoutAttributes *> *atrs;

@end

@implementation A0ClvLayout

-(void)prepareLayout {
    
    _itemCount = [self.collectionView numberOfItemsInSection:0];
    _itemWidth = 66.0;
    _itemHieght = 100.0;
    _itemGap   = 16.0;
    //NSLog(@"\n\n %s \n\n",__FUNCTION__); // 1
}

-(CGSize)collectionViewContentSize {
    CGSize size = CGSizeZero;
    size.width = (_itemWidth + _itemGap) * _itemCount;
    size.height = _itemHieght;
    //NSLog(@"\n\n %s \n\n",__FUNCTION__); // 2
    return size;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *atr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGSize clvSize = self.collectionView.frame.size;
    atr.frame = CGRectMake((_itemWidth + _itemGap) * indexPath.row, (clvSize.height - _itemHieght)/2.0, _itemWidth, _itemHieght);
    //NSLog(@"\n\n %s \n\n",__FUNCTION__); // 22
    return atr;
}

-(NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    //NSLog(@"\n\n %s \n\n",__FUNCTION__); // 1
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (NSInteger cou = 0; cou < _itemCount; cou ++) {
        NSIndexPath *idx = [NSIndexPath indexPathForRow:cou inSection:0];
        UICollectionViewLayoutAttributes *atr = [self layoutAttributesForItemAtIndexPath:idx];
        [arr addObject:atr];
    }
    
    CGFloat curCenterX = self.collectionView.contentOffset.x + CGRectGetWidth(self.collectionView.frame)/2.0;
    for (NSInteger cou = 0; cou < self.atrs.count; cou ++) {
        UICollectionViewLayoutAttributes *atr = self.atrs[cou];
        CGFloat gap = fabs(atr.center.x - curCenterX);
        //NSLog(@" \n\n %f \n\n",gap);
        CGFloat tmp     = MIN(gap/CGRectGetWidth(self.collectionView.frame)/2.0, 1.0);
        CGFloat scale   = 1.0 - tmp;
        NSLog(@" \n\n %f \n\n",scale);
        atr.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    self.atrs = arr;
    return arr;
}


-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    //NSLog(@"\n\n %s \n\n",__FUNCTION__); // 0
    CGSize clvSize = self.collectionView.frame.size;
    CGPoint clvCenter = CGPointMake(clvSize.width/2.0, clvSize.height/2.0);
    return proposedContentOffset;
}

@end
