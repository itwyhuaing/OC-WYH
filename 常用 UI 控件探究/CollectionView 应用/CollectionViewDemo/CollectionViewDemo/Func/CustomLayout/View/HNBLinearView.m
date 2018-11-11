//
//  HNBLinearView.m
//  FineHouse
//
//  Created by 蔡成汉 on 2018/8/31.
//  Copyright © 2018年 Hinabian. All rights reserved.
//

#import "HNBLinearView.h"
#import "HNBLinearCell.h"
#import <SDAutoLayout/SDAutoLayout.h>

typedef NS_ENUM(NSUInteger, HNBLinearViewScrollDirection) {
    HNBLinearViewScrollDirectionNone,
    HNBLinearViewScrollDirectionLeft,
    HNBLinearViewScrollDirectionRight,
};

@interface HNBLinearView ()<UICollectionViewDataSource,UICollectionViewDelegate>

// layout
@property (nonatomic, strong, readwrite) HNBLinearLayout *layout;

// collectionView
@property (nonatomic, strong) UICollectionView *collectionView;

// 页面索引数组 - 索引数组代替内容数组，减少内存占用
@property (nonatomic, strong) NSMutableArray *indexArray;

// 重复次数 - 默认为100
@property (nonatomic, assign) NSUInteger repeatCount;

// x轴偏移记录
@property (nonatomic, assign) CGFloat lastContentOffsetx;

// 滚动方向
@property (nonatomic, assign) HNBLinearViewScrollDirection scrollDirection;

@end

@implementation HNBLinearView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _indexArray = [NSMutableArray array];
        _repeatCount = 100;
        [self initialView];
        [self makeConstraints];
    }
    return self;
}

- (void)initialView {
    [self addSubview:self.collectionView];
}

- (void)makeConstraints {
    self.collectionView.sd_layout
    .topEqualToView(self)
    .leftEqualToView(self)
    .rightEqualToView(self)
    .bottomEqualToView(self);
}

// 设置页面数据、显示的索引
- (void)setDataArray:(NSArray<id> *)dataArray {
    [self setDataArray:dataArray index:0];
}

- (void)setIndex:(NSUInteger)index {
    _index = (MIN(index, _dataArray.count-1));
    [self scrollItemWithIndex:self.repeatCount/2.0*self.dataArray.count+1+_index];
}

- (void)setDataArray:(NSArray<id> *)dataArray index:(NSUInteger)index {
    _dataArray = dataArray;
    if (_dataArray) {
        [self prepareIndexArray:_dataArray];
        [self.collectionView reloadData];
        self.index = index;
    }
}

// 索引数组准备（重置）
- (void)prepareIndexArray:(NSArray *)dataArray {
    NSMutableArray *tpArray = [NSMutableArray array];
    for (NSInteger i=0; i<dataArray.count; i++) {
        [tpArray addObject:@(i)];
    }
    [self.indexArray removeAllObjects];
    for (NSInteger i=0; i<self.repeatCount; i++) {
        [self.indexArray addObjectsFromArray:tpArray];
    }
}

// 驱动页面到指定位置
- (void)scrollItemWithIndex:(NSInteger)index {
    [self.collectionView layoutIfNeeded];
    [self.collectionView setNeedsLayout];
    CGFloat offset = index*self.layout.itemWidth-self.layout.itemWidth*2.0;
    [self.collectionView setContentOffset:CGPointMake(offset, 0) animated:NO];
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _collectionView.clipsToBounds = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.alwaysBounceHorizontal = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.decelerationRate = 0.1;
        [_collectionView registerClass:[HNBLinearCell class] forCellWithReuseIdentifier:@"HNBLinearCell"];
        
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _collectionView;
}

- (HNBLinearLayout *)layout {
    if (_layout == nil) {
        _layout = [[HNBLinearLayout alloc]init];
    }
    return _layout;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.indexArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HNBLinearCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HNBLinearCell" forIndexPath:indexPath];
    NSInteger index = [self.indexArray[indexPath.row] integerValue];
    cell.data = self.dataArray[index];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _lastContentOffsetx = scrollView.contentOffset.x;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x > _lastContentOffsetx) {
        self.scrollDirection = HNBLinearViewScrollDirectionLeft;
    } else if (scrollView.contentOffset.x < _lastContentOffsetx) {
        self.scrollDirection = HNBLinearViewScrollDirectionRight;
    } else {
        self.scrollDirection = HNBLinearViewScrollDirectionNone;
    }
    NSInteger offsetx = scrollView.contentOffset.x*1000;
    NSInteger itemWidth = self.layout.itemWidth*1000;
    NSInteger offset = offsetx%itemWidth;
    CGFloat scrollOffset = offset/1000.0;
    if (self.delegate && [self.delegate respondsToSelector:@selector(linearView:itemDidScroll:nextIndex:)]) {
        NSInteger tpIndex = self.index;
        if (self.scrollDirection == HNBLinearViewScrollDirectionLeft) {
            tpIndex = tpIndex + 1;
            if (tpIndex > self.dataArray.count - 1) {
                tpIndex = 0;
            }
        }
        if (self.scrollDirection == HNBLinearViewScrollDirectionRight) {
            tpIndex = tpIndex - 1;
            if (tpIndex < 0) {
                tpIndex = self.dataArray.count - 1;
            }
        }
        [self.delegate linearView:self itemDidScroll:scrollOffset nextIndex:tpIndex];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(linearView:itemDidSelect:view:)]) {
        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
        [self.delegate linearView:self itemDidSelect:indexPath.row%self.dataArray.count view:cell];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint pointInView = [self convertPoint:CGPointMake(self.layout.itemSpacing*2.0+self.layout.itemWidth+self.layout.itemWidth*self.layout.itemScale/2.0, self.collectionView.center.y) toView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:pointInView];
    NSInteger tpIndex = indexPath ? indexPath.row : 0;
    NSInteger targetIndex = tpIndex%self.dataArray.count;
    _index = targetIndex - 1;
    if (_index == -1) {
        _index = self.dataArray.count - 1;
    }
    [self scrollItemWithIndex:self.repeatCount/2*self.dataArray.count + targetIndex];
    if (self.delegate && [self.delegate respondsToSelector:@selector(linearViewDidEndScroll:)]) {
        [self.delegate linearViewDidEndScroll:self];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
