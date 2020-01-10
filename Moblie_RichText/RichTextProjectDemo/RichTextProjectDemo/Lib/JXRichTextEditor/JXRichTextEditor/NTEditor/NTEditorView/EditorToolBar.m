//
//  EditorToolBar.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2018/5/9.
//  Copyright © 2018年 hainbwyh. All rights reserved.
//

#import "EditorToolBar.h"
#import "ToolBarCommonItem.h"

#define LAYER_LINE_HEIGHT 0.8

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
    _itemLineSpace = 0.0;
    _barInset = UIEdgeInsetsZero;
    _scrollEnable = TRUE;
    _itemSize = CGSizeMake(CGRectGetHeight(self.frame), CGRectGetHeight(self.frame));
}

- (void)initUI{
    self.collectV.bounces = FALSE;
    self.collectV.showsHorizontalScrollIndicator = FALSE;
    [self.collectV registerClass:[ToolBarCommonItem class] forCellWithReuseIdentifier:identity_ToolBarCommonItem];
    self.collectV.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.collectV];
    
    // top - bottom : line
    [self createLayerWithOriginY:0];
    [self createLayerWithOriginY:CGRectGetHeight(self.frame)-LAYER_LINE_HEIGHT];
    
    
}

- (void)createLayerWithOriginY:(CGFloat)y{
    CGRect rect = self.frame;
    rect.origin.y = y;
    rect.size.height = LAYER_LINE_HEIGHT;
    CALayer *l = [CALayer layer];
    [l setFrame:rect];
    [self.layer addSublayer:l];
    l.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.8].CGColor;
}

#pragma mark ------ delegate

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ToolBarCommonItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identity_ToolBarCommonItem forIndexPath:indexPath];
    [cell configContentForThem:self.items[indexPath.row]];
    return cell;
    
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@" didSelected ");
    [self updateBarWithDidSelectedIndex:indexPath.row];
    if (_delegate && [_delegate respondsToSelector:@selector(editorToolBar:didSelectItemAtIndexPath:)]) {
        [_delegate editorToolBar:self didSelectItemAtIndexPath:indexPath.row];
    }
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

- (void)updateBarWithDidSelectedIndex:(NSInteger)index {
    
    //NSLog(@" \n 点击Bar修改前:%@\n",self.items);
    NSString *didSelectedCnt = self.items[index];
    if (index < 0) {
        NSString *theImageName = didSelectedCnt;
        if ([didSelectedCnt rangeOfString:@"_down"].location != NSNotFound) {
            theImageName = [didSelectedCnt stringByReplacingOccurrencesOfString:@"_down" withString:@""];
        }else{
            theImageName = [NSString stringWithFormat:@"%@_down",didSelectedCnt];
        }
        [self.items replaceObjectAtIndex:index withObject:theImageName];
    }else{
        
        if ([didSelectedCnt rangeOfString:@"_selected"].location != NSNotFound) {
            // 取消
            NSString *theNormal  = [didSelectedCnt stringByReplacingOccurrencesOfString:@"_selected" withString:@""];
            [self.items replaceObjectAtIndex:index withObject:theNormal];
        }else{
            // 选中
            NSString *selectedImageName = [NSString stringWithFormat:@"%@_selected",didSelectedCnt                   ];
            for (NSInteger cou = 0;cou < self.items.count;cou ++) {
                NSString *imageName = self.items[cou];
                if ([imageName rangeOfString:@"_selected"].location != NSNotFound) {
                    NSString *tmpNormal = [imageName stringByReplacingOccurrencesOfString:@"_selected" withString:@""];
                    [self.items replaceObjectAtIndex:cou withObject:tmpNormal];
                }
            }
            [self.items replaceObjectAtIndex:index withObject:selectedImageName];
        }
        
    }
    [self.collectV reloadData];
    return ;
    //NSLog(@" \n 点击Bar修改后:%@\n",self.items);
}


#pragma mark ------ publick

-(void)editorToolBarWithContents:(NSArray *)cnts{
    if (cnts) {
        [self.items removeAllObjects];
        [self.items addObjectsFromArray:cnts];
        [self.collectV reloadData];
    }
}

#pragma mark - 样式修改
- (void)modifyItemSize:(CGSize)itemSize reloadRightNow:(BOOL)reloadRightNow{
    if (!CGSizeEqualToSize(itemSize, _itemSize)) {
        // 赋值前确保值域
        _itemSize.height = itemSize.height > self.frame.size.height ? self.frame.size.height : itemSize.height;
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

