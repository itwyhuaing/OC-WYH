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

@property (nonatomic,strong)    UICollectionView *tabBar;

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
    UICollectionViewCell *returnCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(TabBarItem.class) forIndexPath:indexPath];
    return returnCell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.thems.count;
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
        layout.sectionInset                = UIEdgeInsetsMake(5, 20, 50, 60);
        layout.minimumLineSpacing          = 10.0;
        layout.minimumInteritemSpacing     = 60.0;
        layout.itemSize                    = CGSizeMake(100, CGRectGetHeight(self.frame));
        layout.scrollDirection             = UICollectionViewScrollDirectionHorizontal;
        _tabBar = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self addSubview:_tabBar];
        [_tabBar registerClass:[TabBarItem class] forCellWithReuseIdentifier:NSStringFromClass(TabBarItem.class)];
        _tabBar.delegate        = (id)self;
        _tabBar.dataSource      = (id)self;
        _tabBar.sd_layout
        .topEqualToView(self)
        .leftEqualToView(self)
        .rightEqualToView(self)
        .bottomEqualToView(self);
        
        _tabBar.backgroundColor = [UIColor redColor];
        self.backgroundColor    = [UIColor purpleColor];
        
    }
    return _tabBar;
}

@end
