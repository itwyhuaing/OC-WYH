//
//  CircleLayout.m
//  CollectionViewDemo
//
//  Created by hnbwyh on 2018/10/9.
//  Copyright © 2018年 JiXia. All rights reserved.
//

#import "CircleLayout.h"

@interface CircleLayout (){
    
    NSMutableArray<UICollectionViewLayoutAttributes *> * _attributeAttay;
    int _itemCount; //item 个数
    
}
@end


@implementation CircleLayout


-(void)prepareLayout{
    [super prepareLayout];
    //获取item的个数
    _itemCount      = (int)[self.collectionView numberOfItemsInSection:0];
    _attributeAttay = [[NSMutableArray alloc]init];
    //先设定大圆的半径 取长和宽最短的
    CGFloat radius  = MIN(self.collectionView.frame.size.width, self.collectionView.frame.size.height)/2;
    //计算圆心位置
    CGPoint center  = CGPointMake(self.collectionView.frame.size.width/2, self.collectionView.frame.size.height/2);
    //设置每个item的大小为50*50 则半径为25
    for (int i=0; i<_itemCount; i++) {
        UICollectionViewLayoutAttributes * attris = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        //设置item大小
        attris.size = CGSizeMake(ITEM_SIZE, ITEM_SIZE);
        //计算每个item的圆心位置
        //算出的x y值还要减去item自身的半径大小
        float x = center.x + cosf(2 * M_PI/_itemCount * i) * (radius - ITEM_SIZE);
        float y = center.y + sinf(2 * M_PI/_itemCount * i) * (radius - ITEM_SIZE);
        
        attris.center = CGPointMake(x, y);
        [_attributeAttay addObject:attris];
    }
}

// 设置内容区域的大小
-(CGSize)collectionViewContentSize{
    return self.collectionView.frame.size;
}

// 返回设置数组
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return _attributeAttay;
}


@end
