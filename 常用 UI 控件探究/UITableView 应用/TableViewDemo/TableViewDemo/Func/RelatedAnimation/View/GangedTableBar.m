//
//  GangedTableBar.m
//  TableViewDemo
//
//  Created by hnbwyh on 2018/11/12.
//  Copyright © 2018年 TongXin. All rights reserved.
//

#import "GangedTableBar.h"

//测试
#import "SDAutoLayout.h"


@interface TabBarItem ()

@property (nonatomic,strong) UILabel *cntLabel;

@end

@implementation TabBarItem

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

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.cntLabel setFrame:self.bounds];
    
    self.backgroundColor            = [UIColor cyanColor];
    self.cntLabel.backgroundColor   = [UIColor orangeColor];
    
}

-(void)setTitle:(NSString *)title{
    if (title) {
        _title = title;
        self.cntLabel.text = title;
    }
}

-(UILabel *)cntLabel{
    if (!_cntLabel) {
        _cntLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_cntLabel];
        _cntLabel.textColor = [UIColor blackColor];
        _cntLabel.font      = [UIFont systemFontOfSize:16.0];
        _cntLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _cntLabel;
}

@end



@interface GangedTableBar () <UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>

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
    [self.tabBar addSubview:self.underLine];
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
    [self relayoutTheSelectedUnderLineAtIndexPath:indexPath];
    if (_delegate && [_delegate respondsToSelector:@selector(gangedTableBar:didSelectedAtIndexPath:)]) {
        [_delegate gangedTableBar:self didSelectedAtIndexPath:indexPath];
    }
}

#pragma mark ------ method

-(void)gangedTableBarScrollToItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //NSLog(@"\n\n 测试点 ScrollToItemAtIndexPath : %ld \n\n",indexPath.row);
    
    [self.tabBar scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]
                        atScrollPosition:UICollectionViewScrollPositionRight
                                animated:FALSE];
    
    [self relayoutTheSelectedUnderLineAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
}

- (void)relayoutTheSelectedUnderLineAtIndexPath:(NSIndexPath *)index{
    TabBarItem *item = (TabBarItem *)[self.tabBar cellForItemAtIndexPath:index];
    CGRect rect = self.underLine.frame;
    rect.origin.x = item.origin.x;
    [self.underLine setFrame:rect];
    
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
        layout.sectionInset                = UIEdgeInsetsMake(0.0, 0.0, 8.0, 0.0);
        layout.minimumLineSpacing          = 10.0;
        layout.itemSize                    = CGSizeMake(100, CGRectGetHeight(self.frame) - 8.0);
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
        _underLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) - 5.0 - 2.0, 100.0, 5.0)];
        _underLine.backgroundColor = [UIColor blueColor];
    }
    return _underLine;
}

@end
