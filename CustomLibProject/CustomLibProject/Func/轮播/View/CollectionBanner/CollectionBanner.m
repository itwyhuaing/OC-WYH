//
//  CollectionBanner.m
//  CustomLibProject
//
//  Created by hnbwyh on 2019/10/21.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "CollectionBanner.h"
#import "CollectionBannerLayout.h"
#import "CollectionBannerCell.h"

@interface CollectionBanner () <UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong) UICollectionView *clv;

@property (nonatomic,strong) NSMutableArray *data;

@property (nonatomic,assign) CGFloat horizonalSpeed;

@end

@implementation CollectionBanner

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.clv];
        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

-(void)layoutSubviews {
    [self.clv setFrame:self.bounds];
}

-(void)setDataSource:(NSArray *)dataSource {
    if (dataSource) {
        _dataSource = dataSource;
        [self.clv reloadData];
        __weak typeof(self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf scrollToLocationAtIndex:0];
        });
    }
}


- (void)scrollToLocationWithOffsetX:(CGFloat)oftx {
    CGFloat clv_current_ofx  = oftx;
    CGFloat clv_content_w    = self.clv.contentSize.width;
    CGFloat clv_cell_ofx     = (int)(round(clv_current_ofx)) % (int)(round((clv_content_w/100.0)));
    NSInteger clv_current_idx= (int)(clv_cell_ofx/200.0);
    //[self.clv setContentOffset:CGPointMake(clv_content_w/2.0+clv_cell_ofx, 0)];
    [self scrollToLocationAtIndex:clv_current_idx];
}

- (void)scrollToLocationAtIndex:(NSInteger)idx {
    //NSLog(@"\n 滚动到指定位置 \n");
    [self.clv scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:100/2]
    atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:FALSE];
}

#pragma mark ------ UICollectionViewDelegate,UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 100;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(CollectionBannerCell.class)
                                                                           forIndexPath:indexPath];
    cell.themLabel.backgroundColor = [UIColor purpleColor];
    cell.themLabel.text = [NSString stringWithFormat:@"S:%ld\nR:%ld",indexPath.section,indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"\n 选中 ：S:%ld-R:%ld",indexPath.section,indexPath.row);
}

#pragma mark ------ UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"\n 偏移量测试: %f \n",scrollView.contentOffset.x);
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    NSLog(@"\n\n WillEndDragging : %f \n\n",velocity.x);
    self.horizonalSpeed = velocity.x;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"\n\n DidEndDragging \n\n");
    if (self.horizonalSpeed <= 0) {
        [self scrollToLocationWithOffsetX:scrollView.contentOffset.x];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"\n\n DidEndDecelerating \n\n");
    [self scrollToLocationWithOffsetX:scrollView.contentOffset.x];
}

#pragma mark ------ lazy load

- (UICollectionView *)clv {
    if (!_clv) {
        CollectionBannerLayout *layout = [[CollectionBannerLayout alloc] init];
        _clv = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_clv registerClass:[CollectionBannerCell class] forCellWithReuseIdentifier:NSStringFromClass(CollectionBannerCell.class)];
        _clv.delegate                   = self;
        _clv.dataSource                 = self;
        _clv.backgroundColor            = [UIColor cyanColor];
        //layout.itemSize                 = CGSizeMake(100, 180);
//        layout.minimumLineSpacing       = 10.0;
//        layout.minimumInteritemSpacing  = 10.0;
        layout.scrollDirection          = UICollectionViewScrollDirectionHorizontal;
    }
    return _clv;
}

-(NSMutableArray *)data {
    if (!_data) {
        _data = [NSMutableArray new];
    }
    return _data;
}

@end
