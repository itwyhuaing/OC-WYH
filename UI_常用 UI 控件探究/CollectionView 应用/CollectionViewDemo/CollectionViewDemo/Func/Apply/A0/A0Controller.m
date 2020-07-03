//
//  A0Controller.m
//  CollectionViewDemo
//
//  Created by hnbwyh on 2020/6/24.
//  Copyright © 2020 JiXia. All rights reserved.
//

#import "A0Controller.h"
#import "A0ClvLayout.h"
#import "A0ClvCell.h"

@interface A0Controller () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) A0ClvLayout        *layout;

@property (nonatomic,strong) UICollectionView   *clv;

// 基本数据源
@property (nonatomic,strong) NSMutableArray *orginalData;
// 重新设计的数据源 ： 三个基本数据源
@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation A0Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.clv];
    [self handleDataWithLocation:0];
}

-(A0ClvLayout *)layout {
    if (!_layout) {
        _layout = [[A0ClvLayout alloc] init];
    }
    return _layout;
}

-(UICollectionView *)clv {
    if (!_clv) {
        _clv = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200.0) collectionViewLayout:self.layout];
//        _clv.pagingEnabled = TRUE;
        _clv.backgroundColor = [UIColor redColor];
        [_clv registerClass:[A0ClvCell class] forCellWithReuseIdentifier:NSStringFromClass(A0ClvCell.class)];
        _clv.delegate       = (id)self;
        _clv.dataSource     = (id)self;
    
    }
    return _clv;
}

-(NSMutableArray *)orginalData {
    if (!_orginalData) {
        _orginalData = [[NSMutableArray alloc] initWithArray:@[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"]];
    }
    return _orginalData;
}

-(NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (void)handleDataWithLocation:(NSInteger)location {
    NSInteger count = 3;
    [self.dataSource removeAllObjects];
    for (NSInteger cou = 0; cou < count; cou ++) {
        [self.dataSource addObjectsFromArray:self.orginalData];
    }
    [self.clv reloadData];
    NSInteger step = count/2 * self.orginalData.count;
    NSLog(@"\n\n 实际指定位置 ：%ld - %ld \n\n",step,location);
    [self scrollToAppointedLocation:step + location];
}


// 从 0 开始
- (void)scrollToAppointedLocation:(NSInteger)location {
    [self.clv scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:location inSection:0]
                     atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                             animated:FALSE];
}


#pragma mark --- UICollectionViewDelegate,UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    A0ClvCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(A0ClvCell.class)
                                                                           forIndexPath:indexPath];
    //cell.themLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    cell.themLabel.text = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark ---


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //NSLog(@"\n 测试位置 1 : %ld \n",self.layout.location);
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    //NSLog(@"\n 测试位置 2 : %ld \n",self.layout.location); // 1
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    //NSLog(@"\n 测试位置 3 : %ld \n",self.layout.location); // 1
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //NSLog(@"\n 测试位置 4 : %ld \n",self.layout.location); // 1
    if (self.layout.location == self.dataSource.count - 1) { // 即将最后一个
        [self handleDataWithLocation:self.orginalData.count-1];
    }else if (self.layout.location == 0) { // 即将第一个
        [self handleDataWithLocation:0];
    }

}

@end
