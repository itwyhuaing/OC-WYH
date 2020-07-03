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

@property (nonatomic,assign,readwrite) NSInteger location;

@property (nonatomic,strong) NSArray<UICollectionViewLayoutAttributes *> *atrs;

@end

@implementation A0ClvLayout

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    //NSLog(@"\n\n %s \n\n",__FUNCTION__); // 滚动 115
    return TRUE;
}

-(void)prepareLayout {
    //NSLog(@"\n\n %s \n\n",__FUNCTION__); // 滚动 115
    CGRect sf = [UIScreen mainScreen].bounds;
    _location = 1;
    CGFloat lr_gap = 10.0;
    _itemGap   = lr_gap/2.0;
    _itemCount = [self.collectionView numberOfItemsInSection:0];
    //_itemWidth = sf.size.width - lr_gap * 2.0;
    _itemWidth   = sf.size.width * 0.66;
    _itemHieght = 180.0;
    
}

-(CGSize)collectionViewContentSize {
    //NSLog(@"\n\n %s \n\n",__FUNCTION__); // 滚动 230
    CGSize size = CGSizeZero;
    size.width = (_itemWidth + _itemGap) * _itemCount;
    size.height = _itemHieght;
    return size;
}


-(NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    //NSLog(@"\n\n %s \n\n",__FUNCTION__); // 滚动 129
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (NSInteger cou = 0; cou < _itemCount; cou ++) {
        NSIndexPath *idx = [NSIndexPath indexPathForRow:cou inSection:0];
        UICollectionViewLayoutAttributes *atr = [self layoutAttributesForItemAtIndexPath:idx];
        [arr addObject:atr];
    }
    self.atrs = arr;
    
    //================== 计算缩放，0.8 1.0 0.8 只对距离中心位置最近的item两边的 item 缩放 0.8
    UICollectionViewLayoutAttributes *midAtr = [self targetLayoutAttributesWithReferencePoint:self.collectionView.contentOffset];
    for (NSInteger cou = 0; cou < self.atrs.count; cou ++) {
        UICollectionViewLayoutAttributes *atr = self.atrs[cou];
        if (atr == midAtr) {
            atr.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } else {
            atr.transform = CGAffineTransformMakeScale(0.8, 0.8);
        }
    }
    //==================
    
    
    return arr;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"\n\n %s \n\n",__FUNCTION__); // 滚动 2580
    UICollectionViewLayoutAttributes *atr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGSize clvSize = self.collectionView.frame.size;
    atr.frame = CGRectMake((_itemWidth + _itemGap) * indexPath.row, (clvSize.height - _itemHieght)/2.0, _itemWidth, _itemHieght);
    return atr;
}



-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    //NSLog(@"\n\n %s \n\n",__FUNCTION__); // 滚动 1  - 执行之后系统会自行计算布局
    
    //================== 计算目标停留位置
    // 找出最近的 item ，指定停留位置
    CGPoint targetCenter = proposedContentOffset;
    CGFloat x_will_visualCenter = proposedContentOffset.x + CGRectGetWidth(self.collectionView.frame)/2.0;
    UICollectionViewLayoutAttributes *midAtr = [self targetLayoutAttributesWithReferencePoint:proposedContentOffset];
    targetCenter.x = proposedContentOffset.x + (midAtr.center.x - x_will_visualCenter);
    //==================
    
    return targetCenter;
}


#pragma mark - pravate method

// 计算滑动后距离“中心”（此处中心意指 contentoffset.x+conllectionview.frame.size.width/2.0）最近的 item
- (UICollectionViewLayoutAttributes *)targetLayoutAttributesWithReferencePoint:(CGPoint)referPoint {
    CGFloat min_gap = MAXFLOAT;
    CGFloat x_targetCenter = referPoint.x + CGRectGetWidth(self.collectionView.frame)/2.0;
    UICollectionViewLayoutAttributes *rlt = [UICollectionViewLayoutAttributes new];
    for (NSInteger cou = 0; cou < self.atrs.count; cou ++) {
        UICollectionViewLayoutAttributes *atr = self.atrs[cou];
        CGFloat gap = fabs(atr.center.x - x_targetCenter);
        if (min_gap > gap) {
            min_gap = gap;
            rlt = atr;
            _location = cou;
        }
    }
    return rlt;
}


@end
