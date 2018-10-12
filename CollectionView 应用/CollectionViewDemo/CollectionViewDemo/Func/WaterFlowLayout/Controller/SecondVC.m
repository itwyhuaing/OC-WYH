//
//  SecondVC.m
//  CollectionViewDemo
//
//  Created by hnbwyh on 2018/9/29.
//  Copyright © 2018年 JiXia. All rights reserved.
//

#import "SecondVC.h"
#import "WaterFlowItem.h"
#import "WaterFlowModel.h"

#define kMAX_COUNT              12


@interface SecondVC () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView                           *collectionV;
@property (nonatomic,strong) NSMutableArray<WaterFlowModel *>           *listData;

@end

@implementation SecondVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor           = [UIColor whiteColor];
    self.title                          = NSStringFromClass(self.class);
    [self.collectionV registerClass:[WaterFlowItem class] forCellWithReuseIdentifier:NSStringFromClass(WaterFlowItem.class)];
    [self loadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

#pragma mark ------ UICollectionViewDelegate,UICollectionViewDataSource

//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return 0;
//}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.listData.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WaterFlowItem    *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(WaterFlowItem.class) forIndexPath:indexPath];
    cell.contentView.backgroundColor                = [UIColor orangeColor];
    cell.dataModel                                  = self.listData[indexPath.row];
    return cell;
}

#pragma mark ------ UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cnt = self.listData[indexPath.row].cntText;
    return [self getStringSize:[UIFont systemFontOfSize:13.0] size:CGSizeZero content:cnt];
}

#pragma mark ------ 数据

- (void)loadData{
    [self.listData removeAllObjects];
    NSArray *thems              = @[@"1最近使用1",@"2我的应用2",@"3智慧城市3",@"4我的金融",@"5我的生活",@"6数据测试中心",@"7数据",@"6数据测试中心中国河南南阳"];
    for (NSInteger cou = 0; cou < thems.count; cou ++) {
        WaterFlowModel    *m      = [WaterFlowModel new];
        m.cntText                 = thems[cou];
        [self.listData addObject:m];
    }
    [self.collectionV reloadData];
}

- (CGSize)getStringSize:(UIFont *)font size:(CGSize)size content:(NSString *)cnt{
    if (cnt == nil || cnt.length == 0) {
        return CGSizeMake(size.width, 0);
    } else {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:font forKey:NSFontAttributeName];
        CGRect rect = [cnt boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
        return rect.size;
    }
}

#pragma mark ------ lazy load

-(UICollectionView *)collectionV{
    if (!_collectionV) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing          = 10.0 * SCREEN_WIDTHRATE_6;
        flowLayout.minimumInteritemSpacing     = 10.0 * SCREEN_WIDTHRATE_6;
        _collectionV                           = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _collectionV.backgroundColor           = [UIColor cyanColor];
        _collectionV.delegate                  = (id)self;
        _collectionV.dataSource                = (id)self;
        [self.view addSubview:_collectionV];
    }
    return _collectionV;
}


-(NSMutableArray *)listData{
    if (!_listData) {
        _listData               = [NSMutableArray new];
    }
    return _listData;
}


@end
