//
//  EditorToolBar.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2018/5/9.
//  Copyright © 2018年 hainbwyh. All rights reserved.
//

#import "EditorToolBar.h"
#import "ToolBarCommonItem.h"

@interface EditorToolBar ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionViewFlowLayout *layout;
@property (nonatomic,strong) UICollectionView *collectV;
@property (nonatomic,strong) NSMutableArray *items;

/**<样式>*/
@property (nonatomic,assign) CGFloat itemLineSpace;
@property (nonatomic,assign) CGSize itemSize;
@property (nonatomic,assign) UIEdgeInsets barInset;

@end

@implementation EditorToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self initUI];
    }
    return self;
}

- (void)initData{
    _items = [[NSMutableArray alloc] init];
    _itemLineSpace = 5.0;
    _itemSize = CGSizeMake(CGRectGetHeight(self.frame), CGRectGetHeight(self.frame));
    _barInset = UIEdgeInsetsMake(0, 10.0, 0, 10.0);
    
}

- (void)initUI{
    self.collectV.bounces = FALSE;
    self.collectV.showsHorizontalScrollIndicator = FALSE;
    [self.collectV registerClass:[ToolBarCommonItem class] forCellWithReuseIdentifier:identity_ToolBarCommonItem];
    [self addSubview:self.collectV];
    
    self.collectV.backgroundColor = [UIColor cyanColor];
    self.backgroundColor = [UIColor purpleColor];
    
}

#pragma mark ------ delegate

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_dataSource && [_dataSource respondsToSelector:@selector(contentsForEditorToolBar:)]) {
        [_items removeAllObjects];
        [_items addObjectsFromArray:[_dataSource contentsForEditorToolBar:self]];
    }
    return _items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ToolBarCommonItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identity_ToolBarCommonItem forIndexPath:indexPath];
    [cell configContentForThem:self.items[indexPath.row]];
    cell.backgroundColor = [UIColor greenColor];
    cell.layer.borderWidth = 0.5f;
    cell.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:1.0].CGColor;
    return cell;
    
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@" didSelected ");
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.itemSize;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    // Top - Left - Bottom - Right
    return self.barInset;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return self.itemLineSpace;
}

#pragma mark ------ publick

#pragma mark - 样式修改
- (void)modifyItemSize:(CGSize)itemSize reloadRightNow:(BOOL)reloadRightNow{
    if (!CGSizeEqualToSize(itemSize, _itemSize)) {
        _itemSize = itemSize;
        reloadRightNow ? [self.collectV reloadData] : nil;
    }
}

- (void)modifyminimumLineSpacing:(CGFloat)lineSpace reloadRightNow:(BOOL)reloadRightNow{
    if (lineSpace != _itemLineSpace) {
        _itemLineSpace = lineSpace;
        reloadRightNow ? [self.collectV reloadData] : nil;
    }
}

- (void)modifyInset:(UIEdgeInsets)inset reloadRightNow:(BOOL)reloadRightNow{
    _barInset = inset;
    reloadRightNow ? [self.collectV reloadData] : nil;
}

#pragma mark ------ lazy load
- (UICollectionView *)collectV{
    if (!_collectV) {
        CGRect rect = self.frame;
        rect.origin = CGPointZero;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectV = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout];
        _collectV.delegate = self;
        _collectV.dataSource = self;
    }
    return _collectV;
}

@end

