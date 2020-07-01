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

@end

@implementation A0Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.clv];
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
        _clv.backgroundColor = [UIColor redColor];
        [_clv registerClass:[A0ClvCell class] forCellWithReuseIdentifier:NSStringFromClass(A0ClvCell.class)];
        _clv.delegate       = (id)self;
        _clv.dataSource     = (id)self;
    
    }
    return _clv;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 22;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    A0ClvCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(A0ClvCell.class)
                                                                           forIndexPath:indexPath];
    cell.themLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

@end
