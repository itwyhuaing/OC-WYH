//
//  CustomCollectionLayout.m
//  CollectionViewDemo
//
//  Created by hnbwyh on 2018/9/29.
//  Copyright © 2018年 JiXia. All rights reserved.
//

#import "CustomCollectionLayout.h"

@implementation CustomCollectionLayout

/**
 collectionView内容区的宽度和高度，子类必须重载该方法，返回值代表了所有内容的宽度和高度，而不仅仅是可见范围的，collectionView通过该信息配置它的滚动范围，默认返回 CGSizeZero 。
 */
- (CGSize)collectionViewContentSize{
    return CGSizeZero;
}


/**
 所有元素（比如cell、补充控件、装饰控件）的布局属性:
 返回UICollectionViewLayoutAttributes 类型的数组，UICollectionViewLayoutAttributes 对象包含cell或view的布局信息。子类必须重载该方法，并返回该区域内所有元素的布局信息，包括cell,追加视图和装饰视图
 */
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return [NSArray new];
}

@end
