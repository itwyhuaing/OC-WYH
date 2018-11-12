//
//  GangedTableBar.m
//  TableViewDemo
//
//  Created by hnbwyh on 2018/11/12.
//  Copyright © 2018年 TongXin. All rights reserved.
//

#import "GangedTableBar.h"
#import "TabBarItem.h"

//测试
#import "SDAutoLayout.h"


@interface GangedTableBar () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)    UICollectionView  *tabBar;
@property (nonatomic,strong)    UIView            *underLine;

@end

@implementation GangedTableBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI{
    
}

#pragma mark ------ UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TabBarItem *returnCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(TabBarItem.class) forIndexPath:indexPath];
    returnCell.title             = self.thems[indexPath.row];
    return returnCell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.thems.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:FALSE];
    if (_delegate && [_delegate respondsToSelector:@selector(gangedTableBar:didSelectedAtIndexPath:)]) {
        [_delegate gangedTableBar:self didSelectedAtIndexPath:indexPath];
    }
}

#pragma mark ------ method

-(void)gangedTableBarScrollToItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.tabBar scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]
                        atScrollPosition:UICollectionViewScrollPositionRight
                                animated:FALSE];
}

#pragma mark ------ setter data

-(void)setThems:(NSArray<NSString *> *)thems{
    if (![thems isEqualToArray:_thems]) {
        _thems = thems;
        [self.tabBar reloadData];
    }
}

#pragma mark ------ lazy load

-(UICollectionView *)tabBar{
    if (!_tabBar) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset                = UIEdgeInsetsZero;
        layout.minimumLineSpacing          = 10.0;
        layout.itemSize                    = CGSizeMake(100, CGRectGetHeight(self.frame));
        layout.scrollDirection             = UICollectionViewScrollDirectionHorizontal;
        _tabBar = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _tabBar.backgroundColor            = [UIColor whiteColor];
        [self addSubview:_tabBar];
        [_tabBar registerClass:[TabBarItem class] forCellWithReuseIdentifier:NSStringFromClass(TabBarItem.class)];
        _tabBar.delegate        = (id)self;
        _tabBar.dataSource      = (id)self;
        _tabBar.sd_layout
        .topEqualToView(self)
        .leftEqualToView(self)
        .rightEqualToView(self)
        .bottomEqualToView(self);
    }
    return _tabBar;
}

-(UIView *)underLine{
    if (!_underLine) {
        _underLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 5.0)];
        _underLine.backgroundColor = [UIColor redColor];
    }
    return _underLine;
}

@end
