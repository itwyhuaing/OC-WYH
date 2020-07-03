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
        __weak typeof(self) weakSelf = self;
        _layout.signal = ^(NSInteger location) {
            NSLog(@" \n\n 测试信号 - 1\n\n ");
//            if (location == self.dataSource.count - 1) { // 即将最后一个
//                [weakSelf scrollToAppointedLocation:1];
//            }else if (location == 0) { // 即将第一个
//                [weakSelf scrollToAppointedLocation:self.dataSource.count - 2];
//            }
        };
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

-(NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (void)handleDataWithLocation:(NSInteger)location {
    NSInteger count = 10;
    NSArray *tmp = @[@"0",@"1",@"2",@"3",@"4",
                     @"5",@"6",@"7",@"8"];
    [self.dataSource removeAllObjects];
    for (NSInteger cou = 0; cou < count; cou ++) {
        [self.dataSource addObjectsFromArray:tmp];
    }
    [self.clv reloadData];
    [self scrollToAppointedLocation:count/2 * tmp.count + location];
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
    NSLog(@"\n 测试位置 2 : %ld \n",self.layout.location); // 1
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"\n 测试位置 3 : %ld \n",self.layout.location); // 1
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"\n 测试位置 4 : %ld \n",self.layout.location); // 1
    if (self.layout.location == self.dataSource.count - 1) { // 即将最后一个
        [self handleDataWithLocation:self.layout.location];
    }else if (self.layout.location == 0) { // 即将第一个
        [self handleDataWithLocation:self.layout.location];
    }

}

@end
