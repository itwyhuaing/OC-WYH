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

@property (nonatomic,strong) NSMutableArray *atsData;

@end


@implementation CollectionBannerLayout

-(void)prepareLayout {
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.itemSize        = CGSizeMake(ScreenWidth - 2 * 30.0, 180.0);
    self.minimumLineSpacing = 15.0;
    self.headerReferenceSize = CGSizeMake(15.0, 180.0);
}

//-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
//    return self.atsData;
//}

//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
//    NSLog(@"\n 测试点 - targetContentOffsetForProposedContentOffset \n");
//    return CGPointZero;
//}

-(NSMutableArray *)atsData {
    if (!_atsData) {
        _atsData = [NSMutableArray new];
    }
    return _atsData;
}

@end
